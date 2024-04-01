import setuptools
from rl_env.envs.mobile import MobileEnv
from ray.tune.registry import register_env
import shutil
import gym
# import gymnasium as gym
import ray
from ray import tune
# from ray.rllib.algorithms.ppo import PPOConfig
# from ray.rllib.algorithms.ppo import ppo
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

        self.chkpt_root = "./chkpt"
        self.ray_results = "./ray_results/"

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

        # config = ppo.PPOConfig()
        config = ppo.DEFAULT_CONFIG.copy()

        # config.framework("tf2")
        config["framework"] = "tf2"
        # config["log_level"] = "ERROR" # DEBUG,INFO, ERROR
        # config.training(gamma=0.9, lr=0.01, sgd_minibatch_size=4)
        # config.rollouts(num_rollout_workers=1)
        config["horizon"] = 32
        config["num_workers"] = num_workers
        #config["train_batch_size"] = 32
        config["train_batch_size"] = 4
        config["batch_mode"] = "complete_episodes"
        config["lr"] = 0.01
        config["gamma"] = 0.9
        #config["sgd_minibatch_size"] = 32
        config["sgd_minibatch_size"] = 4
        config["model"]["fcnet_hiddens"] = [16, 32]
        config["explore"] = True
        config["disable_env_checking"] = True
        config["simple_optimizer"] = True

        # config.environment(disable_env_checking=True)
        # agent = config.build(env=select_env)
        agent = ppo.PPOTrainer(config, env=select_env)

        return agent
