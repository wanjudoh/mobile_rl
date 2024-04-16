# import gymnasium as gym
import gym
import gym.spaces
import numpy as np
import os
import time

from mobile_config import MobileConfig
from state_buffer import StateBuffer
from utils import *

class MobileEnv_v0(gym.Env):
    """
    Environment for RL training. Set environment = "mobile_v0" to use.

    MobileEnv_v0 has one output node that returns values between 0 and 200,
    which are then applied to swappiness.
    """

    metadata = { "render.modes": ["rgb_array"] }

    def __init__(self):
        # self.action_space = gym.spaces.Discrete(201) # 0~200
        self.action_space = gym.spaces.Box(
                                    low=-0.0,
                                    high=200.0,
                                    shape=(),
                                    dtype=np.float32)

        self.observation_space = gym.spaces.Box(
                                    low=-0.0,
                                    high=np.inf,
                                    shape=(MobileConfig.nr_state,),
                                    dtype=np.float32)

        self.reset()

    def get_state(self, vmstat):
        return np.array([
            vmstat["pgpgin"],
            vmstat["pgpgout"],
            vmstat["pswpin"],
            vmstat["pswpout"],
            vmstat["inactive_anon"],
            vmstat["active_anon"],
            vmstat["inactive_file"],
            vmstat["active_file"]
        ], dtype=np.float32)


    def reset(self):
        # Reset env state & reward
        self.reward = 0
        self.done = False
        self.info = {}

        vmstat = StateBuffer.read()
        self.state = self.get_state(vmstat)
        # print(self.state)

        return self.state

    def write_swappiness(self, swappiness):
        try:
            os.system(f"adb shell 'echo {swappiness} > /sdcard/wjdoh/swappiness.txt'")
        except:
            logging.info("write /sdcard/wjdoh/swappiness.txt failed.")
            exit()

        while True:
            result = subprocess.run(["adb", "shell", "test", "-f", "/sdcard/wjdoh/swappiness.txt", "&&", "echo", "True"], stdout=subprocess.PIPE, text=True)
            if len(result.stdout.split()):
                logging.info("action does not applied yet.")
                time.sleep(1)
            else:
                break

    def get_reward(self, vmstat):
        reward = (vmstat.pgsteal_kswapd)/ \
            (vmstat.pgpgin + vmstat.pgalloc_normal/2 + vmstat.speculative_pgfault)

        logging.info(f"[REWARD] {reward}")
        return reward

    def step(self, action):
        # self.replay_buf = ReplayBuffer.read()
        # print(f"replay buf: {self.replay_buf}")
        action = int(action)
        # print(f"state {self.state} action {action}")
        logging.info(f"[STEP] state: {self.state}, action: {action}")
        self.write_swappiness(action)

        raw_vmstat, _ = read_vmstat(Vmstats())
        time.sleep(MobileConfig.interval_s)
        while True:
            raw_vmstat, delta_vmstat = read_vmstat(raw_vmstat)
            if delta_vmstat.pageoutrun:
                break
            time.sleep(MobileConfig.interval_s)

        self.reward = self.get_reward(delta_vmstat)
        
        time.sleep(MobileConfig.interval_s)
        raw_vmstat, delta_vmstat = read_vmstat(raw_vmstat)

        while read_meminfo() >= MobileConfig.wmark:
            time.sleep(MobileConfig.interval_s)
            raw_vmstat, delta_vmstat = read_vmstat(raw_vmstat)

        StateBuffer.write(delta_vmstat)

        return [self.state, self.reward, self.done, self.info]


    def close (self):
        pass
