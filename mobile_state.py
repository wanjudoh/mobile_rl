import numpy as np
from dataclasses import dataclass

from mobile_config import *
from mobile_action import *
from mobile_reward import *
from utils import *
import subprocess
import copy

@dataclass
class MobileStats:
    pgpgin:         int = 0
    pgpgout:        int = 0
    pswpin:         int = 0
    pswpout:        int = 0
    pageoutrun:     int = 0

class State:
    last_state = MobileStats()
    delta_state = MobileStats()
    inactive_anon = 0
    active_anon = 0
    inactive_file = 0
    active_file = 0
    state_num = 8

    @staticmethod
    def __init__():
        State.read_vmstat()

    @staticmethod
    def read_vmstat():
        """
        Get current state.

        :return: np array state
        """
        try:
            result = subprocess.run(["adb", "shell", "cat", "/proc/vmstat", "|", "grep", "-E", "'pgpgin|pgpgout|pswpin|pswpout|pgalloc_normal|pageoutrun|speculative_pgfault |nr_active|nr_inactive'", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
        except:
            logging.info("read /proc/vmstat failed.")
            exit()

        stats = result.stdout.split('\n')

        State.inactive_anon = int(stats[0])
        State.active_anon = int(stats[1])
        State.inactive_file = int(stats[2])
        State.active_file = int(stats[3])

        Reward.delta_reward.pgpgin = int(stats[4]) - Reward.last_reward.pgpgin
        State.delta_state.pgpgin = int(stats[4]) - State.last_state.pgpgin
        State.delta_state.pgpgout = int(stats[5]) - State.last_state.pgpgout
        State.delta_state.pswpin = int(stats[6]) - State.last_state.pswpin
        State.delta_state.pswpout = int(stats[7]) - State.last_state.pswpout
        Reward.delta_reward.pgalloc_normal = int(stats[8]) - Reward.last_reward.pgalloc_normal
        State.delta_state.pageoutrun = int(stats[9]) - State.last_state.pageoutrun
        Reward.delta_reward.speculative_pgfault = int(stats[10]) - Reward.last_reward.speculative_pgfault

        State.last_state = MobileStats(int(stats[4]), int(stats[5]), int(stats[6]), int(stats[7]), int(stats[9]))
        Reward.last_reward = RewardStats(int(stats[4]), int(stats[8]), int(stats[10]))

        # State.print()
        Reward.print()

    @staticmethod
    def read_state():
        return np.array([State.delta_state.pgpgin, State.delta_state.pgpgout, State.delta_state.pswpin, State.delta_state.pswpout, State.inactive_anon, State.active_anon, State.inactive_file, State.active_file], dtype=np.float32)

    @staticmethod
    def print():
        """Print current state."""

        logging.info(f"[State] {State.delta_state.pgpgin} {State.delta_state.pgpgout} {State.delta_state.pswpin} {State.delta_state.pswpout} {State.delta_state.pageoutrun}")
