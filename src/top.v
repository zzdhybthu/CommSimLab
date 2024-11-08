module top(
    input wire clk,
    input wire rst
);
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
        .data_o(hamming_enc[6:0])
    );
    hamming_encode hamming_encode_1 (
        .data_i(source[7:4]),
        .data_o(hamming_enc[13:7])
    );
    hamming_encode hamming_encode_2 (
        .data_i(source[11:8]),
        .data_o(hamming_enc[20:14])
    );
    hamming_encode hamming_encode_3 (
        .data_i(source[15:12]),
        .data_o(hamming_enc[27:21])
    );

    reg inter_en;
    wire inter_eno;
    interleaver interleaver_0 (
        .clk(clk),
        .rst(rst),
        .en(inter_en),
        .data_i(hamming_enc),
        .eno(inter_eno),
        .data_o(inter_res)
    );

    qpsk_modulator qpsk_modulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i(qpsk_in),
        .data_o_i(quantized_i),
        .data_o_q(quantized_q)
    );

    gaussian_noise_channel gaussian_noise_channel_0 (
        .clk(clk),
        .rst(rst),
        .i_in(quantized_i),
        .q_in(quantized_q),
        .i_out(guassian_i),
        .q_out(guassian_q)
    );

//    assign guassian_i = quantized_i;
//    assign guassian_q = quantized_q;

    qpsk_demodulator qpsk_demodulator_0 (
        .clk(clk),
        .rst(rst),
        .data_i_i(guassian_i),
        .data_i_q(guassian_q),
        .data_o(qpsk_out)
    );

    reg deinter_en;
    wire deinter_eno;
    deinterleaver deinterleaver_0 (
        .clk(clk),
        .rst(rst),
        .r_en(deinter_en),
        .r_data_i(deinter_in),
        .r_eno(deinter_eno),
        .r_data_o(deinter_out)
    );

    hamming_decode hamming_decode_0 (
        .data_i(deinter_out[6:0]),
        .data_o(hamming_dec[3:0])
    );
    hamming_decode hamming_decode_1 (
        .data_i(deinter_out[13:7]),
        .data_o(hamming_dec[7:4])
    );
    hamming_decode hamming_decode_2 (
        .data_i(deinter_out[20:14]),
        .data_o(hamming_dec[11:8])
    );
    hamming_decode hamming_decode_3 (
        .data_i(deinter_out[27:21]),
        .data_o(hamming_dec[15:12])
    );

    reg [4:0] qp_cnt;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            source <= 16'b0001_0100_0111_1100;
            inter_en <= 1;
            deinter_en <= 0;
            qp_cnt <= 0;
        end else if (inter_eno && !qp_cnt) begin
            inter_en <= 0;
            qp_cnt <= 1;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            source <= 16'b0001_0100_0111_1100;
            inter_en <= 1;
            deinter_en <= 0;
            qp_cnt <= 0;
        end else if (qp_cnt >= 1 && qp_cnt <= 14) begin
            case (qp_cnt)
                1: qpsk_in <= inter_res[1:0];
                2: qpsk_in <= inter_res[3:2];
                3: qpsk_in <= inter_res[5:4];
                4: qpsk_in <= inter_res[7:6];
                5: qpsk_in <= inter_res[9:8];
                6: qpsk_in <= inter_res[11:10];
                7: qpsk_in <= inter_res[13:12];
                8: qpsk_in <= inter_res[15:14];
                9: qpsk_in <= inter_res[17:16];
                10: qpsk_in <= inter_res[19:18];
                11: qpsk_in <= inter_res[21:20];
                12: qpsk_in <= inter_res[23:22];
                13: qpsk_in <= inter_res[25:24];
                14: qpsk_in <= inter_res[27:26];
            endcase
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            source <= 16'b0001_0100_0111_1100;
            inter_en <= 1;
            deinter_en <= 0;
            qp_cnt <= 0;
        end else if (qp_cnt >= 4 && qp_cnt <= 17) begin
            case (qp_cnt)
                4: deinter_in[1:0] <= qpsk_out;
                5: deinter_in[3:2] <= qpsk_out;
                6: deinter_in[5:4] <= qpsk_out;
                7: deinter_in[7:6] <= qpsk_out;
                8: deinter_in[9:8] <= qpsk_out;
                9: deinter_in[11:10] <= qpsk_out;
                10: deinter_in[13:12] <= qpsk_out;
                11: deinter_in[15:14] <= qpsk_out;
                12: deinter_in[17:16] <= qpsk_out;
                13: deinter_in[19:18] <= qpsk_out;
                14: deinter_in[21:20] <= qpsk_out;
                15: deinter_in[23:22] <= qpsk_out;
                16: deinter_in[25:24] <= qpsk_out;
                17: deinter_in[27:26] <= qpsk_out;
            endcase
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            source <= 16'b0001_0100_0111_1100;
            inter_en <= 1;
            deinter_en <= 0;
            qp_cnt <= 0;
        end else if(qp_cnt == 17) begin
            deinter_en <= 1;
        end
    end
        
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            source <= 16'b0001_0100_0111_1100;
            inter_en <= 1;
            deinter_en <= 0;
            qp_cnt <= 0;
        end else if(qp_cnt >= 1 && qp_cnt <= 17) begin
            qp_cnt <= qp_cnt + 1;
        end
    end
endmodule
