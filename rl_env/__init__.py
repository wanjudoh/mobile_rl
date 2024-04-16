# from gymnasium.envs.registration import register
from gym.envs.registration import register

register(
    id="mobile_v0",
    entry_point="rl_env.envs:MobileEnv_v0",
)

register(
    id="mobile_v1",
    entry_point="rl_env.envs:MobileEnv_v1",
)
