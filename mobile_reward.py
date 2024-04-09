import time
import subprocess

import math

from mobile_config import *
from mobile_action import *
from mobile_state import *
from utils import *

@dataclass
class RewardStats:
    pgpgin:                 int = 0
    pgalloc_normal:         int = 0
    speculative_pgfault:    int = 0

class Reward:
    last_reward = RewardStats()
    delta_reward = RewardStats()

    @staticmethod
    def read_reward():
        if Reward.delta_reward.pgpgin == 0 or Reward.delta_reward.pgalloc_normal == 0 or Reward.delta_reward.speculative_pgfault == 0:
            return None
        return -(Reward.delta_reward.pgpgin + Reward.delta_reward.pgalloc_normal/2 + Reward.delta_reward.speculative_pgfault)/1000
        # return -((Reward.delta_reward.pgpgin + Reward.delta_reward.pgalloc_normal/2 + Reward.delta_reward.speculative_pgfault))

    def print():
        logging.info(f"[Reward] {Reward.delta_reward.pgpgin} {Reward.delta_reward.pgalloc_normal} {Reward.delta_reward.speculative_pgfault} {Reward.read_reward()}")
