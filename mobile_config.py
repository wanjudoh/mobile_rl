from dataclasses import dataclass

@dataclass
class MobileConfig:
    # Wait seconds after applying action
    interval_s:     int = 10

    # probability of choosing random action instead of using trained model
    epsilon:        float = 0.05

    # startup_file_path:  str = "/home/wjdoh/rl_m3/startup.txt"

    batch_size:     int = 4

    buffer_size:    int = 500

    nr_state:       int = 8
