module qpsk_demodulator (
    input wire clk,
    input wire rst,
    input wire signed [15:0] data_i_i, // 2^7 量化
    input wire signed [15:0] data_i_q, // 2^7 量化
    output reg [1:0] data_o
);

    localparam signed [15:0] THRESHOLD = 16'b0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_o <= 2'b00;
        end else begin
            if (data_i_i > THRESHOLD) begin
                if (data_i_q > THRESHOLD) begin
                    data_o <= 2'b00;
                end else begin
                    data_o <= 2'b10;
                end
            end else begin
                if (data_i_q > THRESHOLD) begin
                    data_o <= 2'b01;
                end else begin
                    data_o <= 2'b11;
                end
            end
        end
    end

endmodule
