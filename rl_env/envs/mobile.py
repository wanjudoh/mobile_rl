# import gymnasium as gym
import gym
import numpy as np
import random

from mobile_action import *
from mobile_reward import *
from mobile_config import *
from replay_buffer import *

@dataclass
class Vmstats:
    pgpgin:         int = 0
    pgpgout:        int = 0
    pswpin:         int = 0
    pswpout:        int = 0
    inactive_anon:  int = 0
    active_anon:    int = 0
    inactive_file:  int = 0
    active_file:    int = 0
    pageoutrun:     int = 0
    pgalloc_normal: int = 0
    speculative_pgfault:    int = 0

class MobileEnv(gym.Env):
    """
    Environment for RL training. Set 'select_env="mobile"' to use.

    MobileEnv gets state and reward from the experience buffer.
    The values are calculated when storing in the experience buffer.
    """

    metadata = { "render.modes": ["rgb_array"] }

    def __init__(self):
        self.action_space = gym.spaces.Discrete(201) # 0~200

        self.observation_space = gym.spaces.Box(
                                    low=-0.0,
                                    high=np.inf,
                                    shape=(MobileConfig.nr_state,),
                                    dtype=np.float32)

        # self.last_vmstat = Vmstats()
        # self.cur_vmstat = Vmstats()

        self.reset()

    def read_vmstat(self):
        try:
            result = subprocess.run(["adb", "shell", "cat", "/proc/vmstat", "|", "grep", "-E", "'pgpgin|pgpgout|pswpin|pswpout|pgalloc_normal|pageoutrun|speculative_pgfault |nr_active|nr_inactive'", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
        except:
            logging.info("read /proc/vmstat failed.")
            exit()

        stats = result.stdout.split('\n')

        self.cur_vmstat = Vmstats(
            inactive_anon   = int(stats[0]),
            active_anon     = int(stats[1]),
            inactive_file   = int(stats[2]),
            active_file     = int(stats[3]),
            pgpgin          = int(stats[4]) - self.last_vmstat.pgpgin,
            pgpgout         = int(stats[5]) - self.last_vmstat.pgpgout,
            pswpin          = int(stats[6]) - self.last_vmstat.pswpin,
            pswpout         = int(stats[7]) - self.last_vmstat.pswpout,
            pgalloc_normal  = int(stats[8]) - self.last_vmstat.pgalloc_normal,
            pageoutrun      = int(stats[9]) - self.last_vmstat.pageoutrun,
            speculative_pgfault = int(stats[10]) - self.last_vmstat.speculative_pgfault,
        )

        self.last_vmstat = Vmstats(
            pgpgin          = int(stats[4]),
            pgpgout         = int(stats[5]),
            pswpin          = int(stats[6]),
            pswpout         = int(stats[7]),
            pgalloc_normal  = int(stats[8]),
            pageoutrun      = int(stats[9]),
            speculative_pgfault = int(stats[10]),
        )

    def reset(self):
        # Reset env state & reward
        self.state = np.array([0.0] * MobileConfig.nr_state, dtype=np.float32)
        self.reward = 0
        self.done = False
        self.info = {}

        self.replay_buf = ReplayBuffer.read()

        return self.state


    def step(self, action):
        # self.replay_buf = ReplayBuffer.read()
        # print(f"replay buf: {self.replay_buf}")
        print(f"[STEP 1] state {self.state} action {action}")

        if self.replay_buf:
            data = random.sample(self.replay_buf, 1)
            # print(f"data: {data}")
            self.state = data[0][0]
            action_exp = data[0][1]
            self.reward = data[0][2]
            print(f"[STEP 2] state {self.state}, action {action_exp} reward {self.reward}")
        else:
            self.state = np.array([0.0] * MobileConfig.nr_state, dtype=np.float32)
            self.reward = 0

        return [self.state, self.reward, self.done, self.info]


    def close (self):
        pass
