import random

from mobile_state import *
from mobile_action import *
from mobile_reward import *
from mobile_config import *
from rl_config import *
from utils import *
from experience import *
from train import *

class Infer:
    state = MobileStats()
    action = -1

    def __init__(self, chkpt_file="./pre-trained/checkpoint", select_env="mobile"):
        logging.info("Infer initializing.")

        rl_config = RL_Config()
        rl_config.rllib_init(select_env)
        self.agent = rl_config.rllib_agent_config(1, select_env)

        logging.info("Infer initialize complete.")


    def __infer(self):
        timer = Timer()
        timer.start()

        state = State.read_state()

        # random action
        if random.random() < MobileConfig.exploration:
            action = Action.random_action()
            Action.apply_action(action)
        else:
            nn_out = self.agent.compute_single_action(state)
            action = Action.nn_to_action(nn_out)
            Action.apply_action(action)

        Action.print(action)

        timer.end()
        timer.print()

        Infer.state = state
        Infer.action = action


    def infer(self):
        logging.info("Infer start")

        state = self.state
        action = self.action

        reward = Reward.read_reward()

        self.__infer()

        if action >= Action.INC:
            Experience.save(state, reward, action)

        logging.info("Infer finish\n\n")


    def reset(self, chkpt_file):
        Experience.reset()

if __name__ == "__main__":
    infer = Infer()

    infer.infer()
