`timescale 1ns/1ps

module traffic_light_controller #(
    parameter GREEN_TIME  = 5,
    parameter YELLOW_TIME = 2,
    parameter RED_TIME    = 5
)(
    input  wire clk,
    input  wire rst,
    input  wire emergency,
    output reg  green,
    output reg  yellow,
    output reg  red
);

    // State encoding
    parameter S_GREEN  = 2'b00;
    parameter S_YELLOW = 2'b01;
    parameter S_RED    = 2'b10;

    reg [1:0] current_state, next_state;
    reg [3:0] timer;

    // 1?? State Register
    always @(posedge clk) begin
        if (rst)
            current_state <= S_RED;
        else
            current_state <= next_state;
    end

    // 2?? Timer Logic
    always @(posedge clk) begin
        if (rst)
            timer <= 0;
        else if (current_state != next_state)
            timer <= 0;
        else
            timer <= timer + 1;
    end

    // 3?? Next-State Logic
    always @(*) begin
        if (emergency)
            next_state = S_RED;
        else begin
            case (current_state)

                S_GREEN:
                    next_state = (timer >= GREEN_TIME) ? S_YELLOW : S_GREEN;

                S_YELLOW:
                    next_state = (timer >= YELLOW_TIME) ? S_RED : S_YELLOW;

                S_RED:
                    next_state = (timer >= RED_TIME) ? S_GREEN : S_RED;

                default:
                    next_state = S_RED;
            endcase
        end
    end

    // 4?? Output Logic (Moore style)
    always @(*) begin
        green  = (current_state == S_GREEN);
        yellow = (current_state == S_YELLOW);
        red    = (current_state == S_RED);
    end

endmodule