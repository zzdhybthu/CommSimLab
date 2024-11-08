module top(
    input wire clk,
    input wire rst,
)
    reg [15:0] source;
    wire [27:0] hamming_enc;
    wire [27:0] inter_res;
    reg [1:0] qpsk_in;
    wire [15:0] quantized_i;
    wire [15:0] quantized_q;
    wire [15:0] guassian_i;
    wire [15:0] guassian_q;
    wire [1:0] qpsk_out;
    reg [27:0] deinter_in;
    wire [27:0] deinter_out;
    wire [15:0] hamming_dec;

    hamming_encode hamming_encode_0 (
        .data_i(source[3:0]),
        .data_o(hamming_enc[6:0]);
    );
    hamming_encode hamming_encode_1 (
        .data_i(source[7:4]),
        .data_o(hamming_enc[13:7]);
    );
    hamming_encode hamming_encode_2 (
        .data_i(source[11:8]),
        .data_o(hamming_enc[20:14]);
    );
    hamming_encode hamming_encode_3 (
        .data_i(source[15:12]),
        .data_o(hamming_enc[27:21]);
    );

    reg inter_en;
    reg inter_eno;
    interleaver interleaver_0 (
        .clk(clk),
        .rst(rst),
        .en(inter_en),
        .data_i(hamming_enc),
        .eno(inter_eno),
        .data_o(inter_res);
    );

    qpsk_modulator qpsk_modulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i(qpsk_in),
        .data_o_i(quantized_i),
        .data_o_q(quantized_q);
    );

    gaussian_noise_channel gaussian_noise_channel_0 (
        .clk(clk),
        .rst(rst),
        .i_in(quantized_i),
        .q_in(quantized_q),
        .i_out(guassian_i),
        .q_out(guassian_q);
    );

    qpsk_demodulator qpsk_demodulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i_i(guassian_i),
        .data_i_q(guassian_q),
        .data_o(qpsk_out);
    );

    reg deinter_en, deinter_eno;
    deinterleaver deinterleaver_0 (
        .clk(clk),
        .rst(rst),
        .r_en(deinter_en),
        .r_data_i(deinter_in),
        .r_eno(deinter_eno),
        .r_data_o(deinter_out);
    );

    hamming_decode hamming_decode_0 (
        .data_i(deinter_out[6:0]),
        .data_o(hamming_dec[3:0]);
    );
    hamming_decode hamming_decode_1 (
        .data_i(deinter_out[13:7]),
        .data_o(hamming_dec[7:4]);
    );
    hamming_decode hamming_decode_2 (
        .data_i(deinter_out[20:14]),
        .data_o(hamming_dec[11:8]);
    );
    hamming_decode hamming_decode_3 (
        .data_i(deinter_out[27:21]),
        .data_o(hamming_dec[15:12]);
    );

    reg [4:0] qp_cnt;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            source <= 16'b0001_0100_0111_1100;
            inter_en <= 1;
            deinter_en <= 0;
            qp_cnt <= 0;
        end else begin
            if (inter_eno) begin
                inter_en <= 0;
                qp_cnt <= 1;
            end
            if (qp_cnt >= 1 and qp_cnt <= 16) begin
                if (qp_cnt <= 14) begin
                    qpsk_in <= inter_res[(qp_cnt<<1)-1:(qp_cnt-1)<<1];
                end
                if (qp_cnt >= 3) begin
                    deinter_in[((qp_cnt-2)<<1)-1:(qp_cnt-3)<<1] <= qpsk_out;
                end
                if (qp_cnt == 16) begin
                    deinter_en <= 1;
                end
                qp_cnt <= qp_cnt + 1;
            end
        end
    end

endmodule


