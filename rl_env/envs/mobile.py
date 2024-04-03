# import gymnasium as gym
import gym
import numpy as np
import random

from mobile_action import *
from mobile_state import *
from mobile_reward import *
from experience import *

class MobileEnv(gym.Env):
    """
    Environment for RL training. Set 'select_env="mobile"' to use.

    MobileEnv gets state and reward from the experience buffer.
    The values are calculated when storing in the experience buffer.
    """

    metadata = { "render.modes": ["human"] }

    def __init__ (self):
        # Action [inc, dec, stay, reset]
        self.action_space = gym.spaces.Box(
                                low=0.0,
                                high=np.inf,
                                shape=(Action.action_num,),
                                dtype=np.float32)


        # Observation [pgpgin, pgpgout, pswpin, pswpout]
        self.observation_space = gym.spaces.Box(
                                    low=-0.0,
                                    high=np.inf,
                                    shape=(State.state_num,),
                                    dtype=np.float32)
        self.reset()


    def __get_state(self, experience):
        return Experience.get_state(experience)


    def __get_reward(self, experience):
        return Experience.get_reward(experience)


    def reset(self):
        # Reset env state & reward
        self.state = np.array([0.0] * State.state_num, dtype=np.float32)
        self.reward = 0
        self.done = False
        self.info = {}

        self.experience_buf = Experience.read()

        return self.state


    def step(self, action):
        if self.experience_buf:
            key, experience = self.experience_buf.popitem()
            self.state = self.__get_state(experience)
            self.reward = self.__get_reward(experience)
        else:
            self.state = np.array([0.0] * State.state_num, dtype=np.float32)
            self.reward = 0

        return [self.state, self.reward, self.done, self.info]


    def close (self):
        pass
