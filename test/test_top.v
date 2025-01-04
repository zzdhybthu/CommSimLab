`timescale 1ns / 1ps

module test_top();
    
    reg clk_origin;
    reg rst;
    reg [15:0] button;
    wire [15:0] hamming_dec;
    wire hamming_wave;
    wire interres_wave;

    initial begin
        clk_origin <= 1;
        button <= 16'b0001_0100_0111_1100;
        rst <= 0;
        #5
        rst <= 1;
    end
    
    always #10 clk_origin = ~clk_origin;

    top top_0 (
        .clk_origin(clk_origin),
        .rst(rst),
        .button(button),
        .hamming_dec(hamming_dec),
        .hamming_wave(hamming_wave),
        .interres_wave(interres_wave)
    );
    
endmodule
