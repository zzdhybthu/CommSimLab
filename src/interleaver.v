module interleaver # (
    parameter n = 7, // (n,k) Hamming code
    parameter symbol_num = 5 // data_length = n * symbol_num
) (
    input wire clk,
    input wire rst,
    input wire en,
    input wire [n*symbol_num-1:0] data_i,
    output reg eno,
    output reg [n*symbol_num-1:0] data_o
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_o <= 0;
            eno <= 0;
        end
        else if (en) begin
            data_o[0] <= data_i[0];
            data_o[1] <= data_i[7];
            data_o[2] <= data_i[14];
            data_o[3] <= data_i[21];
            data_o[4] <= data_i[28];
            data_o[5] <= data_i[1];
            data_o[6] <= data_i[8];
            data_o[7] <= data_i[15];
            data_o[8] <= data_i[22];
            data_o[9] <= data_i[29];
            data_o[10] <= data_i[2];
            data_o[11] <= data_i[9];
            data_o[12] <= data_i[16];
            data_o[13] <= data_i[23];
            data_o[14] <= data_i[30];
            data_o[15] <= data_i[3];
            data_o[16] <= data_i[10];
            data_o[17] <= data_i[17];
            data_o[18] <= data_i[24];
            data_o[19] <= data_i[31];
            data_o[20] <= data_i[4];
            data_o[21] <= data_i[11];
            data_o[22] <= data_i[18];
            data_o[23] <= data_i[25];
            data_o[24] <= data_i[32];
            data_o[25] <= data_i[5];
            data_o[26] <= data_i[12];
            data_o[27] <= data_i[19];
            data_o[28] <= data_i[26];
            data_o[29] <= data_i[33];
            data_o[30] <= data_i[6];
            data_o[31] <= data_i[13];
            data_o[32] <= data_i[20];
            data_o[33] <= data_i[27];
            data_o[34] <= data_i[34];
            eno <= 1;
        end
    end

endmodule