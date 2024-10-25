import math

N = 1024

lut_values = [int(32 * math.sqrt(-2 * math.log((i + 1) / N))) for i in range(N)]
print([math.sqrt(-2 * math.log((i + 1) / N)) for i in range(N)])
print(lut_values)


num_bit = math.ceil(math.log2(max(lut_values))) + 1
print(f"module log_sqrt_lut (\n\
    input wire [15:0] addr,\n\
    output wire signed [{num_bit-1}:0] log_sqrt_out\n\
);")
print(f"    reg [{num_bit-1}:0] log_sqrt[0:{N-1}];")
print(f"    initial begin")
for i, value in enumerate(lut_values):
    print(f"        log_sqrt[{i}] = {num_bit}'d{value};")
print(f"    end")
print(f"    assign log_sqrt_out = log_sqrt[addr[{int(math.log2(N)-1)}:0]];")
print(f"endmodule")