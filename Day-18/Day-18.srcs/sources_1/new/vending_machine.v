`timescale 1ns/1ps

module vending_machine (
    input  wire clk,
    input  wire rst,
    input  wire coin_5,
    input  wire coin_10,
    output reg  dispense,
    output reg  change_return
);

    // State encoding
    parameter S0  = 2'b00;  // ?0
    parameter S5  = 2'b01;  // ?5
    parameter S10 = 2'b10;  // ?10

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

            S0: begin
                if (coin_5)
                    next_state = S5;
                else if (coin_10)
                    next_state = S10;
                else
                    next_state = S0;
            end

            S5: begin
                if (coin_5)
                    next_state = S10;
                else if (coin_10)
                    next_state = S10;
                else
                    next_state = S5;
            end

            S10: begin
                next_state = S0;  // After dispense, return to idle
            end

            default: next_state = S0;

        endcase
    end

    // 3?? Output Logic (Moore-style pulse)
    always @(*) begin
        dispense      = 0;
        change_return = 0;

        if (current_state == S10) begin
            dispense = 1;

            if (coin_5)  // ?15 total
                change_return = 1;
        end
    end

endmodule