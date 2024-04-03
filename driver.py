from train import *
from infer import *
from utils import *
import subprocess
import os

def run_infer(infer, n_infer, chkpt, timer):
    """Driver for running infer.

    :param infer: Infer class instance
    :param chkpt: checkpoint to be restored
    :param timer: Timer class instance
    """

    logging.info("Infer start.") 
    timer.start()
    infer.reset(chkpt)

    infer.infer(True)

    for itr in range(n_infer-1):
        infer.infer(False)

    Experience.write()
    Experience.reset()

    timer.end()
    timer.print()
    logging.info("Infer end.") 


def run_train(train, timer):
    """Driver for running train.

    :param train: Train class instance
    :param timer: Timer class instance
    :return: saved checkpoint file
    """

    logging.info("Train start.")

    timer.start()
    chkpt = train.train()

    logging.info("Train end.")
    timer.end()
    timer.print()

    return chkpt


def driver(n_iter):
    """
    Driver.
    Invoke this method to run.
    Infer and train is invoked repeatedly.

    :param n_iter: Number of iterations to be runned.
    """

    chkpt = "./pre-trained/checkpoint"

    swappiness = 0
    while True:
        result = subprocess.run(['adb', 'shell', 'cat', '/sdcard/wjdoh/swappiness.txt'], stdout=subprocess.PIPE, text=True)
        if result.stdout == "":
            logging.info("Failed to read /sdcard/wjdoh/swappiness.txt!")
            time.sleep(1)
            continue
        swappiness = int(result.stdout)
        os.system("adb shell rm /sdcard/wjdoh/swappiness.txt")
        break

    logging.info(f"Initial swappiness: {swappiness}")
    Action.__init__(int(swappiness))
    State.__init__()
    time.sleep(MobileConfig.apply_wait)

    # infer = Infer(chkpt)
    infer = Infer()
    train = Train()
    timer = Timer()

    n_infer = MobileConfig.train_batch_size

    for itr in range(n_iter):
        State.get_state()
        while State.delta_state.pageoutrun == 0:
            logging.info(f"pageoutrun == 0! sleep {MobileConfig.apply_wait}")
            time.sleep(MobileConfig.apply_wait)
            State.get_state()

        run_infer(infer, n_infer, chkpt, timer)
        chkpt = run_train(train, timer)

    del train
    del infer


if __name__ == "__main__":
    logging.info("Driver start.\n")

    driver(n_iter=16384)

    logging.info("Driver end.\n")
