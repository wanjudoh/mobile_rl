import pickle

class StateBuffer:
    @staticmethod
    def write(vmstat):
        vmstat_dict = {
            "pgpgin": vmstat.pgpgin,
            "pgpgout": vmstat.pgpgout,
            "pswpin": vmstat.pswpin,
            "pswpout": vmstat.pswpout,
            "inactive_anon": vmstat.inactive_anon,
            "active_anon": vmstat.active_anon,
            "inactive_file": vmstat.inactive_file,
            "active_file": vmstat.active_file,
            "pageoutrun": vmstat.pageoutrun,
            "pgalloc_normal": vmstat.pgalloc_normal,
            "pgsteal_kswapd": vmstat.pgsteal_kswapd,
            "speculative_pgfault": vmstat.speculative_pgfault,
        }
        with open("./state.buf", "wb") as _buf_file:
            pickle.dump(vmstat_dict, _buf_file)

    @staticmethod
    def read():
        try:
            _buf_file = open("./state.buf", "rb")
            return pickle.load(_buf_file)
        except IOError:
            return None
