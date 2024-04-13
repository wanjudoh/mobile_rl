from mobile_agent import *
from utils import *
import subprocess
import os

def run_infer(agent, timer):
    """Driver for running infer.

    :param infer: Infer class instance
    :param chkpt: checkpoint to be restored
    :param timer: Timer class instance
    """
    for itr in range(agent.batch_size):
        agent.infer(timer)

    agent.replay_buffer.write()

def run_train(agent, timer):
    """Driver for running train.

    :param train: Train class instance
    :param timer: Timer class instance
    :return: saved checkpoint file
    """
    logging.info("Train start")
    timer.start()
    agent.train()
    timer.end()
    timer.print()
    logging.info("Train end")

def driver(n_iter):
    """
    Driver.
    Invoke this method to run.
    Infer and train is invoked repeatedly.

    :param n_iter: Number of iterations to be runned.
    """

    # initialize action
    swappiness = 0
    while True:
        result = subprocess.run(['adb', 'shell', 'cat', '/sdcard/wjdoh/swappiness.txt'], stdout=subprocess.PIPE, text=True)
        if result.stdout == "":
            time.sleep(1)
            continue
        swappiness = int(result.stdout)
        os.system("adb shell rm /sdcard/wjdoh/swappiness.txt")
        break
    logging.info(f"Initial swappiness: {swappiness}")
    Action.__init__(swappiness)

    timer = Timer()

    agent = MobileAgent()

    # initialize state & reward
    agent.read_vmstat()
    time.sleep(MobileConfig.interval_s)

    for itr in range(n_iter):
        run_infer(agent, timer)
        run_train(agent, timer)

    del agent
    del timer


if __name__ == "__main__":
    logging.info("Driver start.\n")

    driver(n_iter=16384)

    logging.info("Driver end.\n")
