import numpy as np
from dataclasses import dataclass

from mobile_config import *
from utils import *
import subprocess

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

    proc_vmstat_file = None

    state_num = 4

    @staticmethod
    def __init__():
        State.get_state()

    @staticmethod
    def get_state():
        """
        Get current state.

        :return: np array state
        """
        try:
            result = subprocess.run(["adb", "shell", "cat", "/proc/vmstat", "|", "grep", "-E", "'pgpgin|pgpgout|pswpin|pswpout|pageoutrun'", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
        except:
            logging.info("read /proc/vmstat failed.")
            exit()

        stats = result.stdout.split('\n')

        State.delta_state.pgpgin = int(stats[0]) - State.last_state.pgpgin
        State.delta_state.pgpgout = int(stats[1]) - State.last_state.pgpgout
        State.delta_state.pswpin = int(stats[2]) - State.last_state.pswpin
        State.delta_state.pswpout = int(stats[3]) - State.last_state.pswpout
        State.delta_state.pageoutrun = int(stats[4]) - State.last_state.pageoutrun

        State.last_state.pgpgin = int(stats[0])
        State.last_state.pgpgout = int(stats[1])
        State.last_state.pswpin = int(stats[2])
        State.last_state.pswpout = int(stats[3])
        State.last_state.pageoutrun = int(stats[4])

        State.print()

        return np.array([State.delta_state.pgpgin, State.delta_state.pgpgout, State.delta_state.pswpin, State.delta_state.pswpout], dtype=np.float32)

    @staticmethod
    def print():
        """Print current state."""

        logging.info(f"[State] delta state: {State.delta_state.pgpgin} {State.delta_state.pgpgout} {State.delta_state.pswpin} {State.delta_state.pswpout} {State.delta_state.pageoutrun}")
