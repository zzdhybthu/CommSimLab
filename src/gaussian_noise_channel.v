module gaussian_noise_channel (
    input wire clk,
    input wire rst,
    input wire signed [15:0] i_in,
    input wire signed [15:0] q_in,
    output wire signed [15:0] i_out,
    output wire signed [15:0] q_out
);

    wire signed [15:0] gaussian_o_0;
    random_gaussian # (
        .SEED(16'b101)
    ) random_gaussian_0 (
        .clk(clk),
        .rst(rst),
        .gaussian_o(gaussian_o_0)
    );
    assign i_out = i_in + gaussian_o_0;

    wire signed [15:0] gaussian_o_1;
    random_gaussian # (
        .SEED(16'b1110111)
    ) random_gaussian_1 (
        .clk(clk),
        .rst(rst),
        .gaussian_o(gaussian_o_1)
    );
    assign q_out = q_in + gaussian_o_1;
    

endmodule