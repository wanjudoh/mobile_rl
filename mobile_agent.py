import random

from mobile_action import *
from mobile_config import *
from rl_config import *
from utils import *
from replay_buffer import *
from ray.tune.logger import pretty_print

@dataclass
class Vmstats:
    pgpgin:         int = 0
    pgpgout:        int = 0
    pswpin:         int = 0
    pswpout:        int = 0
    inactive_anon:  int = 0
    active_anon:    int = 0
    inactive_file:  int = 0
    active_file:    int = 0
    pageoutrun:     int = 0
    pgalloc_normal: int = 0
    speculative_pgfault:    int = 0

class MobileAgent:
    def __init__(self, select_env="mobile"):
        logging.info("Agent initializing.")

        self.interval_s = MobileConfig.interval_s
        self.epsilon = MobileConfig.epsilon

        self.last_vmstat = Vmstats()
        self.cur_vmstat = Vmstats()
        self.state = np.array([0.0] * MobileConfig.nr_state, dtype=np.float32)
        self.action = -1

        self.batch_size = MobileConfig.batch_size
        self.buffer_size = MobileConfig.buffer_size
        self.replay_buffer = ReplayBuffer(self.buffer_size)

        rl_config = RL_Config()
        rl_config.rllib_init(select_env)
        self.agent = rl_config.rllib_agent_config(1, select_env)

        self.last_infer = (self.state, self.action)

        logging.info("Agent initialize complete.")

    def read_vmstat(self):
        try:
            result = subprocess.run(["adb", "shell", "cat", "/proc/vmstat", "|", "grep", "-E", "'pgpgin|pgpgout|pswpin|pswpout|pgalloc_normal|pageoutrun|speculative_pgfault |nr_active|nr_inactive'", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
        except:
            logging.info("read /proc/vmstat failed.")
            exit()

        stats = result.stdout.split('\n')

        self.cur_vmstat = Vmstats(
            inactive_anon   = int(stats[0]),
            active_anon     = int(stats[1]),
            inactive_file   = int(stats[2]),
            active_file     = int(stats[3]),
            pgpgin          = int(stats[4]) - self.last_vmstat.pgpgin,
            pgpgout         = int(stats[5]) - self.last_vmstat.pgpgout,
            pswpin          = int(stats[6]) - self.last_vmstat.pswpin,
            pswpout         = int(stats[7]) - self.last_vmstat.pswpout,
            pgalloc_normal  = int(stats[8]) - self.last_vmstat.pgalloc_normal,
            pageoutrun      = int(stats[9]) - self.last_vmstat.pageoutrun,
            speculative_pgfault = int(stats[10]) - self.last_vmstat.speculative_pgfault,
        )

        self.last_vmstat = Vmstats(
            pgpgin          = int(stats[4]),
            pgpgout         = int(stats[5]),
            pswpin          = int(stats[6]),
            pswpout         = int(stats[7]),
            pgalloc_normal  = int(stats[8]),
            pageoutrun      = int(stats[9]),
            speculative_pgfault = int(stats[10]),
        )


    def get_state(self):
        return np.array([
            self.cur_vmstat.pgpgin,
            self.cur_vmstat.pgpgout,
            self.cur_vmstat.pswpin,
            self.cur_vmstat.pswpout,
            self.cur_vmstat.inactive_anon,
            self.cur_vmstat.active_anon,
            self.cur_vmstat.inactive_file,
            self.cur_vmstat.active_file
        ], dtype=np.float32)


    def get_reward(self):
        return -(self.cur_vmstat.pgpgin + self.cur_vmstat.pgalloc_normal/2 + self.cur_vmstat.speculative_pgfault)/1000


    def __infer(self, timer, state):
        if random.random() < MobileConfig.epsilon:
            action = Action.random_action()
            Action.apply_action(action)
            self.last_infer = (state, action)
        else:
            logging.info("Infer start")
            timer.start()
            action = self.agent.compute_single_action(observation=state)
            timer.end()
            timer.print()
            logging.info("Infer finish\n")

            action = int(action)
            Action.apply_action(action)
            self.last_infer = (state, action)


    def infer(self, timer):
        self.read_vmstat()  # update state & reward
        print(self.agent.get_policy().get_weights())
        

        if self.cur_vmstat.pageoutrun:
            self.state = self.last_infer[0]
            self.action = self.last_infer[1]

        reward = self.get_reward()
        cur_state = self.get_state()  # current state

        if self.action >= 0:
            self.replay_buffer.add(self.state, self.action, reward, cur_state)
            logging.info(f"[INFER] {self.state}, {self.action}, {reward}")

        # infer next swappiness using current state
        self.__infer(timer, cur_state)

        time.sleep(MobileConfig.interval_s)


    def train(self):
        if len(self.replay_buffer) < self.batch_size:
            return
        res = self.agent.train()
        print(pretty_print(res))

        print(self.agent.get_policy().get_weights())

