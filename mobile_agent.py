from rl_config import RL_Config
from mobile_config import MobileConfig
from state_buffer import StateBuffer
from utils import *
import numpy as np

class MobileAgent:
    def __init__(self, select_env="mobile", chkpt=None):
        logging.info("Agent initializing.")

        self.interval_s = MobileConfig.interval_s

        StateBuffer.write(Vmstats())
        self.state = np.array([0.0] * MobileConfig.nr_state, dtype=np.float32)
        self.action = -1

        rl_config = RL_Config()
        rl_config.rllib_init(select_env)
        self.agent = rl_config.rllib_agent_config(1, select_env)
        if chkpt:
            self.agent.restore(chkpt)

        logging.info("Agent initialize complete.")
