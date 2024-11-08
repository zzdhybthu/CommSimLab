`timescale 1ns / 1ps

module test_top();
    
    reg clk;
    reg rst;

    initial begin
        clk <= 1;
        rst <= 1;
        #5
        rst <= 0;
    end
    always #10 clk = ~clk;

    top top_0 (
        .clk(clk),
        .rst(rst)
    );
    
endmodule
