module deinterleaver # (
    parameter n = 7, // (n,k) Hamming code
    parameter symbol_num = 4 // data_length = n * symbol_num
) (
    input wire clk,
    input wire rst,
    input wire r_en,
    input wire [n*symbol_num-1:0] r_data_i,
    output reg r_eno,
    output reg [n*symbol_num-1:0] r_data_o
);
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            r_data_o <= 0;
            r_eno <= 0;
        end
        else if (r_en) begin
            r_data_o[0] <= r_data_i[0];
            r_data_o[1] <= r_data_i[4];
            r_data_o[2] <= r_data_i[8];
            r_data_o[3] <= r_data_i[12];
            r_data_o[4] <= r_data_i[16];
            r_data_o[5] <= r_data_i[20];
            r_data_o[6] <= r_data_i[24];
            r_data_o[7] <= r_data_i[1];
            r_data_o[8] <= r_data_i[5];
            r_data_o[9] <= r_data_i[9];
            r_data_o[10] <= r_data_i[13];
            r_data_o[11] <= r_data_i[17];
            r_data_o[12] <= r_data_i[21];
            r_data_o[13] <= r_data_i[25];
            r_data_o[14] <= r_data_i[2];
            r_data_o[15] <= r_data_i[6];
            r_data_o[16] <= r_data_i[10];
            r_data_o[17] <= r_data_i[14];
            r_data_o[18] <= r_data_i[18];
            r_data_o[19] <= r_data_i[22];
            r_data_o[20] <= r_data_i[26];
            r_data_o[21] <= r_data_i[3];
            r_data_o[22] <= r_data_i[7];
            r_data_o[23] <= r_data_i[11];
            r_data_o[24] <= r_data_i[15];
            r_data_o[25] <= r_data_i[19];
            r_data_o[26] <= r_data_i[23];
            r_data_o[27] <= r_data_i[27];
            r_eno <= 1;
        end
    end

endmodule