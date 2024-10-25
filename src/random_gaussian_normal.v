module random_gaussian_normal # (
    parameter SEED = 16'b101
) (
    input wire clk,
    input wire rst,
    output wire signed [15:0] gaussian_normal_o  // 2^7 量化
);
    wire [15:0] uniform_o_0;
    random_uniform # (
        .SEED(SEED),
        .O_MAX(1024)
    ) random_uniform_0 (
        .clk(clk),
        .rst(rst),
        .uniform_o(uniform_o_0)
    );

    wire cos_sign;
    assign cos_sign = (uniform_o_0 <= 256) ? 0 :
                      (uniform_o_0 <= 768) ? 1 :
                      0;
    wire [15:0] cos_addr;
    assign cos_addr = (uniform_o_0 <= 256) ? (uniform_o_0 - 1) :
                      (uniform_o_0 <= 512) ? (512 - uniform_o_0) :
                      (uniform_o_0 <= 768) ? (uniform_o_0 - 513) :
                      (1024 - uniform_o_0);
    wire signed [7:0] cos_lut_o;
    cos_lut cos_lut_0 (
        .addr(cos_addr),
        .cos_out(cos_lut_o)
    );

    wire signed [7:0] cos_o;
    assign cos_o = cos_sign ? -cos_lut_o : cos_lut_o;


    wire [15:0] uniform_o_1;
    random_uniform # (
        .SEED(SEED + 1),
        .O_MAX(1024)
    ) random_uniform_1 (
        .clk(clk),
        .rst(rst),
        .uniform_o(uniform_o_1)
    );

    wire [15:0] log_sqrt_addr;
    assign log_sqrt_addr = uniform_o_1 - 1;
    wire signed [7:0] log_sqrt_lut_o;
    log_sqrt_lut log_sqrt_lut_0 (
        .addr(log_sqrt_addr),
        .log_sqrt_out(log_sqrt_lut_o)
    );

    wire signed [7:0] log_sqrt_o;
    assign log_sqrt_o = log_sqrt_lut_o;
    
    assign gaussian_normal_o = (cos_o * log_sqrt_o) >>> 5;

endmodule