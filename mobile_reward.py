import time
import subprocess

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
    last = RewardStats()
    delta = RewardStats()

    @staticmethod
    def wait_for_reward():
        try:
            result = subprocess.run(["adb", "shell", "cat", "/proc/vmstat", "|", "grep", "-E", "'pgpgin|pgalloc_normal|speculative_pgfault '", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
        except:
            logging.info("read /proc/vmstat failed.")
            exit()

        stats = result.stdout.split('\n')
        Reward.last.pgpgin = int(stats[0])
        Reward.last.pgalloc_normal = int(stats[1])
        Reward.last.speculative_pgfault = int(stats[2])

        time.sleep(MobileConfig.apply_wait)

        try:
            result = subprocess.run(["adb", "shell", "cat", "/proc/vmstat", "|", "grep", "-E", "'pgpgin|pgalloc_normal|speculative_pgfault '", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
        except:
            logging.info("read /proc/vmstat failed.")
            exit()

        stats = result.stdout.split('\n')
        Reward.delta.pgpgin = int(stats[0]) - Reward.last.pgpgin
        Reward.delta.pgalloc_normal = int(stats[1]) - Reward.last.pgalloc_normal
        Reward.delta.speculative_pgfault = int(stats[2]) - Reward.last.speculative_pgfault

    @staticmethod
    def get_reward():
        return -(Reward.delta.pgpgin + Reward.delta.pgalloc_normal*0.1 + Reward.delta.speculative_pgfault)

