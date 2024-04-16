from mobile_agent import MobileAgent
from mobile_config import MobileConfig
from state_buffer import StateBuffer
from utils import *
import time
import signal
import sys
import logging

agent = None

def signal_handler(sig, frame):
    global agent
    logging.info("Interrupt occurred! Save the checkpoint. \n")
    saved_chkpt = agent.agent.save(MobileConfig.chkpt_root)
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

def driver(n_iter):
    """
    Driver.
    Invoke this method to run.
    Infer and train is invoked repeatedly.

    :param n_iter: Number of iterations to be runned.
    """
    global agent
    timer = Timer()
    agent = MobileAgent()
    
    # initialize state & reward
    raw_vmstat, _ = read_vmstat(Vmstats())
    time.sleep(MobileConfig.interval_s)
    raw_vmstat, delta_vmstat = read_vmstat(raw_vmstat)
    while read_meminfo() >= MobileConfig.wmark:
        time.sleep(MobileConfig.interval_s)
        raw_vmstat, delta_vmstat = read_vmstat(raw_vmstat)

    StateBuffer.write(delta_vmstat)
    for itr in range(4):
        agent.agent.train()

    #saved_chkpt = agent.agent.save(MobileConfig.chkpt_root)

    del agent
    del timer


if __name__ == "__main__":
    logging.info("Driver start.\n")

    driver(n_iter=16384)

    logging.info("Driver end.\n")
