import random
import math

num_samples = 1024

for _ in range(num_samples):
    print(int(random.random() < 0.5), end="")