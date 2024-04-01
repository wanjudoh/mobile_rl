import time
import os

from mobile_config import *
from mobile_action import *
from mobile_state import *
from utils import *
import numpy as np

class Reward:
    """
    reward로는 우선 app startup time을 사용함.
    """
    avg_startup = 0
    startup_file = None

    @staticmethod
    def read_reward():
        if not os.path.exists(MobileConfig.startup_file_path):
            return -1

        with open(MobileConfig.startup_file_path, "r") as startup_file:
            startup_array = []
            lines = startup_file.readlines()
            if len(lines) == 0:
                return -1

            for line in lines:
                startup_array.append(int(line))
            
            Reward.avg_startup = np.exp(np.log(startup_array).mean())

            os.remove(MobileConfig.startup_file_path)

        return Reward.avg_startup

    @staticmethod
    def wait_for_reward():
        """
        app startup time이 하나라도 기록되면 wait을 종료
        """

        print(f"wait {MobileConfig.apply_wait} sec...")
        time.sleep(MobileConfig.apply_wait)
        while (Reward.read_reward() < 0):
            print(f"wait {MobileConfig.apply_wait} sec...")
            time.sleep(MobileConfig.apply_wait)

        print("Done!")

    @staticmethod
    def get_reward():
        """Get reward when action is applied.
        Always call wait_for_reward before invoking.

        Step 1. Wait by invoking `__wait()`.
        Step 2. Calculate reward function.

        :param nid: node id to get reward
        :return: reward; return None if no demoted and promoted pages
        """

        inverse_startup_time = 1/Reward.avg_startup
        return inverse_startup_time

