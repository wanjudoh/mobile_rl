from mobile_agent import MobileAgent
from mobile_config import MobileConfig
from state_buffer import StateBuffer
from utils import *
import time

def driver(n_iter):
    """
    Driver.
    Invoke this method to run.
    Infer and train is invoked repeatedly.

    :param n_iter: Number of iterations to be runned.
    """

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
    for itr in range(n_iter):
        agent.agent.train()

    del agent
    del timer


if __name__ == "__main__":
    logging.info("Driver start.\n")

    driver(n_iter=16384)

    logging.info("Driver end.\n")
