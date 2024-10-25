import random
import math

num_samples = 1024

random_numbers = [abs(random.gauss(0, 1)) for _ in range(num_samples)]
random_numbers = [int(x * 128) for x in random_numbers]

random_numbers = [x * 2 + int(random.random() < 0.5) for x in random_numbers]

assert max(random_numbers) < 2**16, f"Max value: {max(random_numbers)}"

# a = [r for r in random_numbers if r % 2 == 0]
# b = [r for r in random_numbers if r % 2 == 1]
# print(len(a), len(b))

# print(f"module random_gaussian_normal_lut (\n\
#     input wire [15:0] addr,\n\
#     output wire signed [15:0] random_gaussian_normal_o\n\
# );")
# print(f"    reg [15:0] random_gaussian_normal[0:{num_samples-1}];")
print(f"    initial begin")
for i, value in enumerate(random_numbers):
    print(f"        random_gaussian_normal[{i}] = 16'd{value};")
print(f"    end")
# print(f"    wire signed [15:0] random_gaussian_normal_ori;")
# print(f"    assign random_gaussian_normal_ori = random_gaussian_normal[addr[{int(math.log2(num_samples)-1)}:0]];")
# print(f"    assign random_gaussian_normal_o = (random_gaussian_normal_ori[0] == 1'b1) ? -random_gaussian_normal_ori[15:1] : random_gaussian_normal_ori[15:1];")
# print(f"endmodule")