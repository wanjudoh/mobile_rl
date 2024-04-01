import logging
import coloredlogs
# import time
# import os
# import subprocess
# import re

from datetime import datetime

coloredlogs.install()
logging.basicConfig(
    format = '%(asctime)s [%(module)s:%(funcName)s]:%(levelname)s: %(message)s',
    datefmt = '%Y/%m/%d %H:%M:%S',
    level = logging.INFO
)

class Timer:
    """Timer used for an experiment"""

    def __init__ (self):
        pass


    def start (self):
        """Start timer"""

        self.start_t = datetime.now()


    def end (self):
        """End timer"""

        self.end_t = datetime.now()


    def print (self):
        """Print elapsed time"""

        self.delta_t = self.end_t - self.start_t
        logging.info(f"Elapsed time: {self.delta_t}\n")
