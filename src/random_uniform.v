module random_uniform # (
    parameter SEED = 16'b101,
    parameter O_MAX = 1024,
    parameter O_MIN = 1
) (
    input wire clk,
    input wire rst,
    output wire [15:0] uniform_o  // 2^16 量化
);
    reg [15:0] lfsr_state;

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            lfsr_state <= SEED;
        end else begin
            if (SEED[0] == 1) begin
                lfsr_state <= {lfsr_state[14:0], lfsr_state[15] ^ lfsr_state[13] ^ lfsr_state[12] ^ lfsr_state[10]};
            end else begin
                lfsr_state <= {lfsr_state[14:0], lfsr_state[15] ^ lfsr_state[14] ^ lfsr_state[12] ^ lfsr_state[3]};
            end
        end
    end

    assign uniform_o = lfsr_state % (O_MAX - O_MIN + 1'b1) + O_MIN;

endmodule