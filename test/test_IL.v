`timescale 1ns / 1ps

module test_IL();
    
    reg clk;
    reg rst;

    reg en;
    reg [28 -1:0] data = 28'b0011111000011110110111100101;
    wire en_IL;
    wire [28 -1:0] data_IL;
    interleaver il(clk, rst, en, data, en_IL, data_IL);

    wire [28 -1:0] data_DIL;
    wire en_DIL;
    deinterleaver dil(clk, rst, en_IL, data_IL, en_DIL, data_DIL);

    initial begin
        clk <= 1;
        rst <= 1;
        en <= 0;
        #10 en <= 1;
        rst <= 0;
    end
    always #5 clk = ~clk;
    
endmodule
