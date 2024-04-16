from dataclasses import dataclass

@dataclass
class MobileConfig:
    # Wait seconds after applying action
    interval_s:     int = 5

    # number of components in the state
    # nr_state:       int = 8  # mobile_v0
    nr_state:       int = 6  # mobile_v1

    # infer swappiness when the free memory is below the wmark
    wmark:          int = 5

    chkpt_root:     str = "./chkpt"

    environment:    str = "mobile_v1"

    nr_action:      int = 21