from dataclasses import dataclass

@dataclass
class MobileConfig:
    # Wait seconds after applying action
    apply_wait:     int = 10

    # probability of choosing random action instead of using trained model
    exploration:    float = 0.05

    startup_file_path:  str = "/home/wjdoh/rl_m3/startup.txt"
