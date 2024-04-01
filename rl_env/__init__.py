# from gymnasium.envs.registration import register
from gym.envs.registration import register

register(
    id="mobile",
    entry_point="rl_env.envs:MobileEnv",
)
