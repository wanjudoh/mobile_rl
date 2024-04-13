import numpy as np
import random

import os
import subprocess
import time

from mobile_config import *
from utils import *

class Action:
    applied_swappiness = -1
    swappiness_log_file = None

    @staticmethod
    def __init__(swappiness):
        # save current swappiness
        Action.applied_swappiness = swappiness
        cur_time = time.time()

        try:
            Action.swappiness_log_file = open("swappiness.log", "w")
            Action.swappiness_log_file.write(f"{cur_time} {swappiness} Initial swappiness\n")
            Action.swappiness_log_file.close()
        except:
            print("Failed to open swappiness log")
            exit()

    @staticmethod
    def write(swappiness):
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
    def random_action():
        return random.randint(0, 200)

    @staticmethod
    def apply_action(action):
        try:
            Action.swappiness_log_file = open("swappiness.log", "a")
        except:
            print("Failed to open swappiness log")
            exit()

        cur_time = time.time()

        Action.applied_swappiness = action
        Action.swappiness_log_file.write(f"{cur_time} {action}\n")
        Action.swappiness_log_file.close()
        Action.write(action)

    @staticmethod
    def print(action):
        logging.info(f"[Action] swappiness: {action}\n")