from dataclasses import dataclass

@dataclass
class MobileConfig:
    # Wait seconds after applying action
    interval_s:     int = 10

    # number of components in the state
    nr_state:       int = 8

    # infer swappiness when the free memory is below the wmark
    wmark:          int = 5

    chkpt_root:     str = "./chkpt"
