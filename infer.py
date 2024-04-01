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
    """Infer using trained RL model.

    Infer by the trained RL model. Infer module collects the state and applies action online. (Recall that training utilizes experience buffer data) 
    Step 1. Collect current state.
    Step 2. Use trained model to determine action for current state.
    Step 3. Apply action.
    Step 4. Wait for Action.action_apply_wait seconds. This is to wait for action to be 'fully' applied.
    Step 5. Calculate reward.
    Step 6. Save to state, action, reward to the experience buffer.
    Step 7. Later, train module trains from the experience buffer.
    """

    def __init__(self, chkpt_file="./pre-trained/checkpoint", select_env="mobile"):
        logging.info("Infer initializing.")

        rl_config = RL_Config()
        rl_config.rllib_init(select_env)
        self.agent = rl_config.rllib_agent_config(1, select_env)
        # self.agent.restore(chkpt_file)

        # self.policy = self.agent.get_policy()
        # self.model = self.policy.model

        Action.__init__()
        State.__init__()

        logging.info("Infer initialize complete.")


    def __infer(self):
        """Infer by using trained model or randomly selecting action for node nid.

        Step 1. Get state.
        Step 2. For p < 0.1, choose random action and get reward by Reward.get_reward.
        Step 3. Apply action by RL model.
        Step 4. Get reward by actually write action to /proc/idt_action and calculate reward function by Reward.get_reward.
        Step 5. Save to the expereince buffer.

        :param nid: node id to be inferred
        """

        timer = Timer()
        timer.start()

        state = State.get_state()
        State.print()

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

        return (state, action)


    def infer(self):
        logging.info("Infer start\n")

        state, action = self.__infer()

        Reward.wait_for_reward()

        reward = Reward.get_reward()

        Experience.save(state, reward, action)

        logging.info("Infer finish\n\n")


    def reset(self, chkpt_file):
        """Reset by loading the newly trained model and reset the experience buffer.

        :param chkpt_file: model to be restored
        """

        # logging.info(f"Model restored from {chkpt_file}.")
        # self.agent.restore(chkpt_file)
        Experience.reset()

if __name__ == "__main__":
    infer = Infer()

    infer.infer()
