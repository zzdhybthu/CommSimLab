module gaussian_noise_channel # (
    parameter MEAN = 0,
    parameter STD = 1
) (
    input wire clk,
    input wire rst,
    input wire signed [15:0] i_in,
    input wire signed [15:0] q_in,
    output wire signed [15:0] i_out,
    output wire signed [15:0] q_out
);

    wire signed [15:0] gaussian_o_0;
    random_gaussian # (
        .MEAN(MEAN),
        .STD(STD),
        .SEED(16'b101)
    ) random_gaussian_0 (
        .clk(clk),
        .rst(rst),
        .gaussian_o(gaussian_o_0)
    );
    assign i_out = i_in + gaussian_o_0;

    wire signed [15:0] gaussian_o_1;
    random_gaussian # (
        .MEAN(MEAN),
        .STD(STD),
        .SEED(16'b1110111)
    ) random_gaussian_1 (
        .clk(clk),
        .rst(rst),
        .gaussian_o(gaussian_o_1)
    );
    assign q_out = q_in + gaussian_o_1;
    

    // // Optional: hardcode
    // reg [15:0] addr1;
    // reg [15:0] addr2;
    // always @(posedge clk or negedge rst) begin
    //     if (~rst) begin
    //         addr1 <= 0;
    //         addr2 <= 512;
    //     end else begin
    //         if (addr1 == 511) begin
    //             addr1 <= 0;
    //         end else begin
    //             addr1 <= addr1 + 1;
    //         end
    //         if (addr2 == 1023) begin
    //             addr2 <= 512;
    //         end else begin
    //             addr2 <= addr2 + 1;
    //         end
    //     end
    // end
    // wire signed [15:0] random_gaussian_normal_o1;
    // wire signed [15:0] random_gaussian_normal_o2;
    // random_gaussian_normal_lut random_gaussian_normal_lut_0 (
    //     .addr1(addr1),
    //     .addr2(addr2),
    //     .random_gaussian_normal_o1(random_gaussian_normal_o1),
    //     .random_gaussian_normal_o2(random_gaussian_normal_o2)
    // );
    // assign i_out = i_in + random_gaussian_normal_o1 * STD + MEAN;
    // assign q_out = q_in + random_gaussian_normal_o2 * STD + MEAN;

endmodule