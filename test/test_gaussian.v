`timescale 1ns / 1ps

module test();
    parameter clk_period_100M = 10; // f=100MHz <=> T=10ns
    
    reg rst;
    reg clk;
    
    reg [1023:0] datas = 1024'b0010110110011101110101000101001101000111001101101101000011011110010111111100010011000011011001100101011100000001101001001001101100000010011011100111100010000101011111111001001001101110101101001000101011100101100111000111011001000001111110110011010011101111101000001001101100001110110001011101011100001110100010000000001100000010110110011101110101100001100000110010000111100011111101111110011111000111100100001101010100101100100000101010010001011111100100011100011001111000100000010111110010001100101011001001000000101100101111101110100011010110100000101101000000110001110011011110110101000000100011011110001010000101101001001101101111101000001111000111111010011101101000001101111000110000110001110100010010011111111000010110101110001101110110110000110010110000011110011110010000101100110110111001100011100011001000100101110110111010110001000111001110010110011000011000010110110010110100110010100101000000011101000010010111100110100011110011001010010010001010100001000111001110010110001010001000101110111011010100101001111011;

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
    
    
    wire signed [15:0] data_i_i;
    wire signed [15:0] data_i_q;
    
    gaussian_noise_channel # (
        .MEAN(0),
        .STD(0.5)
    ) gaussian_noise_channel_0 (
        .clk(clk),
        .rst(rst),
        .i_in(data_o_i),
        .q_in(data_o_q),
        .i_out(data_i_i),
        .q_out(data_i_q)
    );
    

    wire [1:0] data_o;
    qpsk_demodulator qpsk_demodulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i_i(data_i_i),
        .data_i_q(data_i_q),
        .data_o(data_o)
    );

    initial begin
        rst <= 1;
        clk <= 1;
        #(clk_period_100M/2) rst <= 0;
        #(clk_period_100M/2)
        while (datas > 0) begin
            datas <= datas >> 2;
            #(clk_period_100M) ;
        end
    end

    always #(clk_period_100M/2) clk <= ~clk;
    
    
    // simulation log
    integer log_file;
    initial begin
        log_file = $fopen("simulation_log.txt", "w");
    end
    
    always @(posedge clk) begin
        $fwrite(log_file, "%d\n", gaussian_noise_channel_0.gaussian_o_0);
        $fflush(log_file);
    end

endmodule