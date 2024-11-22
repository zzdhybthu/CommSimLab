module top(
    input wire clk_origin,
    input wire rst,
    input wire [15:0] button,
    output wire [15:0] hamming_dec,
    output reg hamming_wave,
    output reg interres_wave
);
    reg [15:0] source;
	// assign source = 16'b0001_0100_0111_1100;
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
    // wire [15:0] hamming_dec;

    wire clk;
    clk_gen #(.CNT(5400)) clk_gen_1 (
        .clk(clk_origin),
        .reset(rst),
        .clk_1K(clk)
    );

    wire clk_fast;
    clk_gen #(.CNT(100)) clk_gen_0 (
        .clk(clk_origin),
        .reset(rst),
        .clk_1K(clk_fast)
    );

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
    
    wire [27:0] inter_res_error;
    assign inter_res_error = {!inter_res[27],!inter_res[26],!inter_res[25],!inter_res[24],inter_res[23:0]};
    
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

    //assign guassian_i = quantized_i;
    //assign guassian_q = quantized_q;

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
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            inter_en <= 1;
            qp_cnt <= 0;
            source <= button;
        end else if (inter_eno && !qp_cnt) begin
            inter_en <= 0;
            qp_cnt <= 1;
        end else if(qp_cnt >= 1 && qp_cnt <= 17) begin
            qp_cnt <= qp_cnt + 1;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
        end else if (qp_cnt >= 1 && qp_cnt <= 14) begin
            case (qp_cnt)
                1: qpsk_in <= inter_res_error[1:0];
                2: qpsk_in <= inter_res_error[3:2];
                3: qpsk_in <= inter_res_error[5:4];
                4: qpsk_in <= inter_res_error[7:6];
                5: qpsk_in <= inter_res_error[9:8];
                6: qpsk_in <= inter_res_error[11:10];
                7: qpsk_in <= inter_res_error[13:12];
                8: qpsk_in <= inter_res_error[15:14];
                9: qpsk_in <= inter_res_error[17:16];
                10: qpsk_in <= inter_res_error[19:18];
                11: qpsk_in <= inter_res_error[21:20];
                12: qpsk_in <= inter_res_error[23:22];
                13: qpsk_in <= inter_res_error[25:24];
            endcase
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
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
    
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
		    deinter_en <= 0;
        end else if(qp_cnt == 17) begin
            deinter_en <= 1;
        end
    end

    reg [4:0] hamming_wave_cnt;
    always @(posedge clk_fast or negedge rst) begin
        if (~rst) begin
            hamming_wave <= 0;
            hamming_wave_cnt <= 0;
        end
        else begin
            case (hamming_wave_cnt)
                0: hamming_wave <= deinter_in[0];
                1: hamming_wave <= deinter_in[1];
                2: hamming_wave <= deinter_in[2];
                3: hamming_wave <= deinter_in[3];
                4: hamming_wave <= deinter_in[4];
                5: hamming_wave <= deinter_in[5];
                6: hamming_wave <= deinter_in[6];
                7: hamming_wave <= deinter_in[7];
                8: hamming_wave <= deinter_in[8];
                9: hamming_wave <= deinter_in[9];
                10: hamming_wave <= deinter_in[10];
                11: hamming_wave <= deinter_in[11];
                12: hamming_wave <= deinter_in[12];
                13: hamming_wave <= deinter_in[13];
                14: hamming_wave <= deinter_in[14];
                15: hamming_wave <= deinter_in[15];
                16: hamming_wave <= deinter_in[16];
                17: hamming_wave <= deinter_in[17];
                18: hamming_wave <= deinter_in[18];
                19: hamming_wave <= deinter_in[19];
                20: hamming_wave <= deinter_in[20];
                21: hamming_wave <= deinter_in[21];
                22: hamming_wave <= deinter_in[22];
                23: hamming_wave <= deinter_in[23];
                24: hamming_wave <= deinter_in[24];
                25: hamming_wave <= deinter_in[25];
                26: hamming_wave <= deinter_in[26];
                27: hamming_wave <= deinter_in[27];
            endcase
            hamming_wave_cnt <= (hamming_wave_cnt < 5'd27) ? hamming_wave_cnt + 5'd1 : 5'd0;
        end
    end

    reg [4:0] interres_wave_cnt;
    always @(posedge clk_fast or negedge rst) begin
        if (~rst) begin
            interres_wave <= 0;
            interres_wave_cnt <= 0;
        end
        else begin
            case (interres_wave_cnt)
                0: interres_wave <= deinter_out[0];
                1: interres_wave <= deinter_out[1];
                2: interres_wave <= deinter_out[2];
                3: interres_wave <= deinter_out[3];
                4: interres_wave <= deinter_out[4];
                5: interres_wave <= deinter_out[5];
                6: interres_wave <= deinter_out[6];
                7: interres_wave <= deinter_out[7];
                8: interres_wave <= deinter_out[8];
                9: interres_wave <= deinter_out[9];
                10: interres_wave <= deinter_out[10];
                11: interres_wave <= deinter_out[11];
                12: interres_wave <= deinter_out[12];
                13: interres_wave <= deinter_out[13];
                14: interres_wave <= deinter_out[14];
                15: interres_wave <= deinter_out[15];
                16: interres_wave <= deinter_out[16];
                17: interres_wave <= deinter_out[17];
                18: interres_wave <= deinter_out[18];
                19: interres_wave <= deinter_out[19];
                20: interres_wave <= deinter_out[20];
                21: interres_wave <= deinter_out[21];
                22: interres_wave <= deinter_out[22];
                23: interres_wave <= deinter_out[23];
                24: interres_wave <= deinter_out[24];
                25: interres_wave <= deinter_out[25];
                26: interres_wave <= deinter_out[26];
                27: interres_wave <= deinter_out[27];
            endcase
            interres_wave_cnt <= (interres_wave_cnt < 5'd27) ? interres_wave_cnt + 5'd1 : 5'd0;
        end
    end
endmodule
