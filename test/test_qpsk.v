`timescale 1ns / 1ps

module test();
    parameter clk_period_100M = 10; // f=100MHz <=> T=10ns
    
    reg rst;
    reg clk;
    
    reg [15:0] datas = 16'b1110110110001101;

    wire [1:0] data_i;
    assign data_i = datas[1:0];

    wire signed [15:0] data_o_i;
    wire signed [15:0] data_o_q;
    qpsk_modulator qpsk_modulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i(data_i),
        .data_o_i(data_o_i),
        .data_o_q(data_o_q)
    );

    wire [1:0] data_o;
    qpsk_demodulator qpsk_demodulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i_i(data_o_i),
        .data_i_q(data_o_q),
        .data_o(data_o)
    );

    initial begin
        rst <= 0;
        clk <= 1;
        #(clk_period_100M) rst <= 1;
        #(clk_period_100M/2)
        while (datas > 0) begin
            datas <= datas >> 2;
            #(clk_period_100M) ;
        end
    end

    always #(clk_period_100M/2) clk <= ~clk;

endmodule