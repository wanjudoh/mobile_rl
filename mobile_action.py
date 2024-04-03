import numpy as np
import random

import os
import subprocess
import time

from mobile_config import *
from mobile_state import *
from utils import *

class Action:
    """
    Change swappiness by action.
    INC:    swappiness += 10
    DEC:    swappiness -= 10
    STAY:   pass
    RESET:  swappiness = 100
    """

    INC     = 0
    DEC     = 1
    STAY    = 2
    RESET   = 3
    action_num = 4

    swappiness = -1

    @staticmethod
    def __init__(swappiness):
        Action.swappiness = swappiness

    @staticmethod
    def write(swappiness):
        """
        Write /proc/sys/vm/swappiness file

        @swappiness: swappiness value
        """

        try:
            os.system(f"adb shell 'echo {swappiness} > /sdcard/wjdoh/swappiness.txt'")
        except:
            logging.info("write /sdcard/wjdoh/swappiness.txt failed.")
            exit()

        while True:
            result = subprocess.run(["adb", "shell", "test", "-f", "/sdcard/wjdoh/swappiness.txt", "&&", "echo", "True"], stdout=subprocess.PIPE, text=True)
            if len(result.stdout.split()):
                logging.info("action does not applied yet.")
                time.sleep(1)
            else:
                break

    @staticmethod
    def nn_to_action(nn_out):
        """
        NN output to action.
        Find argmax of NN output node.
        NN output node corresponds to [inc, dec, stay, reset]
        apply_action shoulb be called to actually 'apply' action.

        :return: action [inc|dec|stay|reset]
        """

        return np.argmax(nn_out)

    @staticmethod
    def random_action():
        """
        Select random action.
        apply_action shoulb be called to actually 'apply' action.

        :return: randomly select action.
        """

        return random.randint(0, 3)

    @staticmethod
    def apply_action(action):
        """
        Apply action and update & apply swappiness.
        When using NN output, call nn_to_action before invoking.
    
        @action: action to be applied
        """

        if action == Action.INC:
            Action.swappiness = min(199, Action.swappiness + 10)
        elif action == Action.DEC:
            Action.swappiness = max(1, Action.swappiness - 10)
        elif action == Action.RESET:
            Action.swappiness = 100

        if action != Action.STAY:
            Action.write(Action.swappiness)

    @staticmethod
    def print(action):
        """Print current action of nid."""

        action_msg = ["Inc", "Dec", "Stay", "Reset"]
        logging.info(f"[Action] action index: {action_msg[action]} swappiness: {Action.swappiness}\n")
