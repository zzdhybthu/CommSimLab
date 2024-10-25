module qpsk_modulator (
    input wire clk,
    input wire rst,
    input wire [1:0] data_i,
    output reg signed [15:0] data_o_i,
    output reg signed [15:0] data_o_q  // 2^7 量化
);

    localparam signed [15:0] CONST_VAL = 16'b0101_1011;  // 1/sqrt(2)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_o_i <= 16'b0;
            data_o_q <= 16'b0;
        end else begin
            case (data_i)
                2'b00: begin
                    data_o_i <= CONST_VAL;
                    data_o_q <= CONST_VAL;
                end
                2'b01: begin
                    data_o_i <= -CONST_VAL;
                    data_o_q <= CONST_VAL;
                end
                2'b10: begin
                    data_o_i <= CONST_VAL;
                    data_o_q <= -CONST_VAL;
                end
                2'b11: begin
                    data_o_i <= -CONST_VAL;
                    data_o_q <= -CONST_VAL;
                end
                default: begin
                    data_o_i <= 16'b0;
                    data_o_q <= 16'b0;
                end
            endcase
        end
    end
    
endmodule