// 用verilog语言写一个(7,4)汉明码的编码器，输入为4位数据，输出为7位编码后的数据。
module hamming_encode (
    input wire [3:0] data_i,
    output wire [6:0] data_o
);
    /* 生成矩阵 G = [
        1 0 0 0 1 1 1; 
        0 1 0 0 1 0 1;
        0 0 1 0 1 1 0; 
        0 0 0 1 0 1 1 ]
    */
    assign data_o[0] = data_i[0];
    assign data_o[1] = data_i[1];
    assign data_o[2] = data_i[2];
    assign data_o[3] = data_i[3];
    assign data_o[4] = data_i[0] ^ data_i[1] ^ data_i[2];
    assign data_o[5] = data_i[0] ^ data_i[2] ^ data_i[3];
    assign data_o[6] = data_i[0] ^ data_i[1] ^ data_i[3];

endmodule