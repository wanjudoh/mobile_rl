from rl_env.envs.mobile import MobileEnv
from mobile_config import MobileConfig
import shutil
import ray
from ray.tune.registry import register_env
from ray.rllib.agents import ppo

class RL_Config:
    """Set rllib configurations and algorithm"""

    def __init__(self):
        pass

    def rllib_init(self, select_env):
        """
        Initialize rllib.
        Checkpoint & ray_results paths are set.
        Environment is registered

        :param select_env: environment id
        """

        shutil.rmtree(MobileConfig.chkpt_root, ignore_errors=True, onerror=None)

        # ray_results = "./ray_results/"
        # shutil.rmtree(ray_results, ignore_errors=True, onerror=None)

        # start Ray -- add `local_mode=True` here for debugging
        ray.init(ignore_reinit_error=True, logging_level="ERROR", num_cpus=4)

        # register the custom environment
        register_env(select_env, lambda config: MobileEnv())

    def rllib_agent_config(self, num_workers, select_env):
        """
        Configure agent and training parameters.

        :param num_workers: number of workers to be used (ideally, align to batch size)
        :param select_env: environment id

        :return: configured agent
        """

        config = ppo.DEFAULT_CONFIG.copy()

        config["framework"] = "tf2"
        config["model"]["fcnet_hiddens"] = [16, 32]
        config["lr"] = 0.01
        config["gamma"] = 0.9
        config["explore"] = True
        config["horizon"] = 1
        config["train_batch_size"] = 1
        config["sgd_minibatch_size"] = 1
        config["num_workers"] = num_workers
        config["batch_mode"] = "complete_episodes"
        config["disable_env_checking"] = True

        agent = ppo.PPOTrainer(config, env=select_env)

        return agent