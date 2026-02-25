`timescale 1ns/1ps

module moore_seq_detector (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output reg  dout
);

    // State encoding
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] current_state, next_state;

    // 1?? State Register
    always @(posedge clk) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // 2?? Next-State Logic
    always @(*) begin
        case (current_state)

            S0: next_state = (din) ? S1 : S0;

            S1: next_state = (din) ? S1 : S2;

            S2: next_state = (din) ? S3 : S0;

            S3: next_state = (din) ? S1 : S2;

            default: next_state = S0;

        endcase
    end

    // 3?? Output Logic (Moore ? depends only on state)
    always @(*) begin
        case (current_state)
            S3: dout = 1'b1;
            default: dout = 1'b0;
        endcase
    end

endmodule