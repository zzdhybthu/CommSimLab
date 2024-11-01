`timescale 1ns/1ps
`define PERIOD 10

module hamming_tb();

    reg [3:0] data_i;
    wire [6:0] data_enc;
    wire [3:0] data_dec;

    hamming_encode hamming_encode_0 (
        .data_i(data_i),
        .data_o(data_enc)
    );

    hamming_decode hamming_decode_0 (
        .data_i(data_enc),
        .data_o(data_dec)
    );

    integer i;
    initial begin
        for (i = 0; i < 16; i=i+1) begin
            data_i = i;
            #(`PERIOD)
            if (data_dec != data_i) begin
                $display("[Error]: %b -> %b -> %b", data_i, data_enc, data_dec);
            end 
            else begin
                $display("Correct: %b -> %b -> %b", data_i, data_enc, data_dec);
            end
        end
    end

endmodule