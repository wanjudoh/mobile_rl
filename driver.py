from train import *
from infer import *
from utils import *

def run_infer(infer, n_infer, chkpt, timer):
    """Driver for running infer.

    :param infer: Infer class instance
    :param chkpt: checkpoint to be restored
    :param timer: Timer class instance
    """

    logging.info("Infer start.") 
    timer.start()
    infer.reset(chkpt)

    for itr in range(n_infer):
        infer.infer()

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

    Action.__init__()
    State.__init__()

    # infer = Infer(chkpt)
    infer = Infer()
    train = Train()
    timer = Timer()

    #n_infer = 32
    n_infer = MobileConfig.train_batch_size

    for itr in range(n_iter):
        run_infer(infer, n_infer, chkpt, timer)
        chkpt = run_train(train, timer)

    del train
    del infer


if __name__ == "__main__":
    logging.info("Driver start.\n")

    driver(n_iter=16384)

    logging.info("Driver end.\n")
