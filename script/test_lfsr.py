import numpy as np
import matplotlib.pyplot as plt

def lfsr(input: list, taps: list):
    output = input[:-1].copy()
    newbit = 0
    for tap in taps:
        newbit ^= input[tap]
    output.insert(0, newbit)
    return output

def state2int(state: list):
    return int(''.join(map(str, state)), 2)

def generate_random_uniform(n: int, num_samples: int, seed: int):
    assert seed < 2**n and seed > 0, f"Seed should be in range [1, 2^{n})"
    
    state = [1] + [0] * (n - 1)
    if n == 8:
        taps = [7, 5, 4, 3] if seed % 2 == 0 else [7, 5, 4, 1]
    elif n == 16:
        taps = [15, 13, 12, 10] if seed % 2 == 0 else [15, 14, 12, 3]
    else:
        raise ValueError(f"Unsupported n: {n}")
    
    states = []
    state = [int(x) for x in bin(seed)[2:]] + [0] * (n - len(bin(seed)[2:]))
    for _ in range(num_samples):
        state = lfsr(state, taps)
        states.append(state2int(state))
    
    # print(len(set(states)), num_samples, 2**n-1)
    
    norm_states = np.array(states) / (2**n - 1)
    return norm_states

def generate_random_gaussian_normal(n: int, num_samples: int, seed: int):
    u1 = generate_random_uniform(n, num_samples, seed)
    u2 = generate_random_uniform(n, num_samples, seed + 1)
    z1 = np.sqrt(-2 * np.log(u1)) * np.cos(2 * np.pi * u2)
    z2 = np.sqrt(-2 * np.log(u1)) * np.sin(2 * np.pi * u2)
    return z1, z2

def generate_random_gaussian(n: int, num_samples: int, seed: int, mean: float=0, std: float=1):
    z1, z2 = generate_random_gaussian_normal(n, num_samples, seed)
    return z1 * std + mean, z2 * std + mean

n = 16
num_samples = 100000
seed = 0b101

# s = generate_random_uniform(n, num_samples, seed)
# plt.hist(s, bins=100, density=True)
# plt.show()

# z1, z2 = generate_random_gaussian_normal(n, num_samples, seed)
# plt.hist(z1, bins=100, density=True)
# plt.show()
# plt.hist(z2, bins=100, density=True)
# plt.show()

z1, z2 = generate_random_gaussian(n, num_samples, seed, 2, 2)
plt.hist(z1, bins=100, density=True)
plt.show()
plt.hist(z2, bins=100, density=True)
plt.show()

print(z1.mean(), z1.std())
print(z2.mean(), z2.std())