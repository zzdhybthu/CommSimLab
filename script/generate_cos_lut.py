import math

N = 1024

lut_values = [int(128 * math.cos(2 * math.pi * (i + 1) / N)) for i in range(N // 4)]
print(lut_values)


num_bit = math.ceil(math.log2(max(lut_values))) + 1
print(f"module cos_lut (\n\
    input wire [15:0] addr,\n\
    output wire signed [{num_bit-1}:0] cos_out\n\
);")
print(f"    reg [{num_bit-1}:0] cos[0:{N//4-1}];")
print(f"    initial begin")
for i, value in enumerate(lut_values):
    print(f"        cos[{i}] = {num_bit}'d{value};")
print(f"    end")
print(f"    assign cos_out = cos[addr[{int(math.log2(N)-3)}:0]];")
print(f"endmodule")