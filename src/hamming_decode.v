// 用verilog语言写一个(7,4)汉明码的解码器，输入为7位数据，输出为4位解码后的数据，能纠一位错。
module hamming_dncode (
    input wire [6:0] data_i,
    output wire [3:0] data_o
);
    /* 生成矩阵 G = [
        1 0 0 0 1 1 1; 
        0 1 0 0 1 0 1;
        0 0 1 0 1 1 0; 
        0 0 0 1 0 1 1 ]
        矩阵左上角标为(0,0)
    */
    // 先计算校正子
    wire [2:0] parity;
    assign parity[0] = data_i[4] ^ data_i[0] ^ data_i[1] ^ data_i[2];
    assign parity[1] = data_i[5] ^ data_i[0] ^ data_i[2] ^ data_i[3];
    assign parity[2] = data_i[6] ^ data_i[0] ^ data_i[1] ^ data_i[3];
    // 比较校正子和校验矩阵
    assign data_o = (parity==3'b111) ? data_i[3:0]^4'b0001 : 
                    (parity==3'b101) ? data_i[3:0]^4'b0010 :
                    (parity==3'b011) ? data_i[3:0]^4'b0100 :
                    (parity==3'b110) ? data_i[3:0]^4'b1000 :
                    data_i[3:0];

endmodule