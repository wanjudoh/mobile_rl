import logging
import coloredlogs
from datetime import datetime
import subprocess
from dataclasses import dataclass

coloredlogs.install()
logging.basicConfig(
    format = '%(asctime)s [%(module)s:%(funcName)s]:%(levelname)s: %(message)s',
    datefmt = '%Y/%m/%d %H:%M:%S',
    level = logging.INFO
)

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
    pgsteal_kswapd: int = 0
    speculative_pgfault:    int = 0

class Timer:
    """Timer used for an experiment"""

    def __init__ (self):
        pass


    def start (self):
        """Start timer"""

        self.start_t = datetime.now()


    def end (self):
        """End timer"""

        self.end_t = datetime.now()


    def print (self):
        """Print elapsed time"""

        self.delta_t = self.end_t - self.start_t
        logging.info(f"Elapsed time: {self.delta_t}\n")


def read_meminfo():
    try:
        result = subprocess.run(["adb", "shell", "grep", "-E", "'MemTotal|MemFree'", "/proc/meminfo", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
    except:
        logging.info("read /proc/meminfo failed.")
        exit()

    stats = result.stdout.split('\n')
    free_mem = (int(stats[1])/int(stats[0]))*100
    # logging.info(f"[MEMINFO] {free_mem}")
    return free_mem

def print_state(vmstat):
    logging.info(f"[STATE] {vmstat.pgpgin} {vmstat.pgpgout} {vmstat.pswpin} {vmstat.pswpout} {vmstat.inactive_anon} {vmstat.active_anon} {vmstat.inactive_file} {vmstat.active_file}")

def read_vmstat(raw_vmstat):
    try:
        result = subprocess.run(["adb", "shell", "grep", "-E", "'pgsteal_kswapd|pgpgin|pgpgout|pswpin|pswpout|pgalloc_normal|pageoutrun|speculative_pgfault |nr_active|nr_inactive'", \
                                 "/proc/vmstat", "|", "awk", "'{print $2}'"], stdout=subprocess.PIPE, text=True)
    except:
        logging.info("read /proc/vmstat failed.")
        exit()

    stats = result.stdout.split('\n')
    delta_vmstat = Vmstats(
            inactive_anon   = int(stats[0]),
            active_anon     = int(stats[1]),
            inactive_file   = int(stats[2]),
            active_file     = int(stats[3]),
            pgpgin          = int(stats[4]) - raw_vmstat.pgpgin,
            pgpgout         = int(stats[5]) - raw_vmstat.pgpgout,
            pswpin          = int(stats[6]) - raw_vmstat.pswpin,
            pswpout         = int(stats[7]) - raw_vmstat.pswpout,
            pgalloc_normal  = int(stats[8]) - raw_vmstat.pgalloc_normal,
            pgsteal_kswapd  = int(stats[9]) - raw_vmstat.pgsteal_kswapd,
            pageoutrun      = int(stats[10]) - raw_vmstat.pageoutrun,
            speculative_pgfault = int(stats[11]) - raw_vmstat.speculative_pgfault,
    )
    raw_vmstat = Vmstats(
            pgpgin          = int(stats[4]),
            pgpgout         = int(stats[5]),
            pswpin          = int(stats[6]),
            pswpout         = int(stats[7]),
            pgalloc_normal  = int(stats[8]),
            pgsteal_kswapd  = int(stats[9]),
            pageoutrun      = int(stats[10]),
            speculative_pgfault = int(stats[11]),
    )
    print_state(delta_vmstat)
    return raw_vmstat, delta_vmstat