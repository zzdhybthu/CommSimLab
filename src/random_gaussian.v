module random_gaussian # (
    parameter MEAN = 0,
    parameter STD = 0,
    parameter SEED = 16'b101
) (
    input wire clk,
    input wire rst,
    output wire signed [15:0] gaussian_o  // 2^7 量化
);
    wire signed [15:0] gaussian_normal_o;
    random_gaussian_normal # (
        .SEED(SEED)
    ) random_gaussian_normal_0 (
        .clk(clk),
        .rst(rst),
        .gaussian_normal_o(gaussian_normal_o)
    );

    assign gaussian_o = gaussian_normal_o * STD + MEAN;

endmodule