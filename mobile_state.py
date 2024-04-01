import numpy as np
from dataclasses import dataclass

from mobile_config import *
from utils import *

@dataclass
class MobileStats:
    pgpgin:         int = 0
    pgpgout:        int = 0
    pswpin:         int = 0
    pswpout:        int = 0

class State:
    last_state = MobileStats()
    delta_state = MobileStats()

    proc_vmstat_file = None

    state_num = 4

    @staticmethod
    def __init__():
        try:
            State.proc_vmstat_file = open("/proc/vmstat", "r")
        except IOError:
            print("OS error occurred trying to open /proc/vmstat")
            exit()
        
        State.read()
   
    @staticmethod
    def read():
        # Read /proc/vmstat and update state.
        pgpgin = 0
        pgpgout = 0
        pswpin = 0
        pswpout = 0


        lines = None
        while lines is None:
            try:
                lines = State.proc_vmstat_file.readlines()
            except:
                State.proc_vmstat_file = open("/proc/vmstat", "r")

        for line in lines:
            if line.split()[0] == "pgpgin":
                pgpgin = int(line.split()[1])
            elif line.split()[0] == "pgpgout":
                pgpgout = int(line.split()[1])
            elif line.split()[0] == "pswpin":
                pswpin = int(line.split()[1])
            elif line.split()[0] == "pswpout":
                pswpout = int(line.split()[1])

        State.delta_state.pgpgin = pgpgin - State.last_state.pgpgin
        State.delta_state.pgpgout = pgpgout - State.last_state.pgpgout
        State.delta_state.pswpin = pswpin - State.last_state.pswpin
        State.delta_state.pswpout = pswpout - State.last_state.pswpout

        State.last_state = MobileStats(pgpgin, pgpgout, pswpin, pswpout)

        State.proc_vmstat_file.seek(0)

        # logging.info(f"[State] current state: {pgpgin} {pgpgout} {pswpin} {pswpout}")
        # State.print()

    @staticmethod
    def get_state():
        """
        Get current state.

        :return: np array state
        """
        State.read()
        return np.array([State.delta_state.pgpgin, State.delta_state.pgpgout, State.delta_state.pswpin, State.delta_state.pswpout], dtype=np.float32)

    @staticmethod
    def print():
        """Print current state."""

        logging.info(f"[State] delta state: {State.delta_state.pgpgin} {State.delta_state.pgpgout} {State.delta_state.pswpin} {State.delta_state.pswpout}\n")
