from collections import deque
import random
import pickle
import numpy as np

class ReplayBuffer:
    buf_file = "./replay.buf"
    buffer = deque()

    def __init__(self, buffer_size):
        ReplayBuffer.buffer = deque(maxlen=buffer_size)

    def add(self, state, action, reward, next_state):
        data = (state, action, reward, next_state)
        ReplayBuffer.buffer.append(data)

    def write(self):
        with open(ReplayBuffer.buf_file, "wb") as _buf_file:
            pickle.dump(ReplayBuffer.buffer, _buf_file)

    def read():
        try:
            _buf_file = open(ReplayBuffer.buf_file, "rb")
            return pickle.load(_buf_file)
        except IOError:
            return None

    def __len__(self):
        return len(ReplayBuffer.buffer)


