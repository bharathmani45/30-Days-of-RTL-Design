`timescale 1ns/1ps

module uart_tx #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600
)(
    input  wire clk,
    input  wire rst,
    input  wire tx_start,
    input  wire [7:0] tx_data,
    output reg  tx,
    output reg  tx_busy
);

    localparam BAUD_DIV = CLK_FREQ / BAUD_RATE;

    // Baud counter
    reg [15:0] baud_cnt;
    reg        baud_tick;

    // FSM states
    parameter IDLE  = 3'b000;
    parameter START = 3'b001;
    parameter DATA  = 3'b010;
    parameter STOP  = 3'b011;

    reg [2:0] state;
    reg [3:0] bit_index;
    reg [7:0] shift_reg;

    // Baud generator
    always @(posedge clk) begin
        if (rst) begin
            baud_cnt  <= 0;
            baud_tick <= 0;
        end else begin
            if (baud_cnt == BAUD_DIV-1) begin
                baud_cnt  <= 0;
                baud_tick <= 1;
            end else begin
                baud_cnt  <= baud_cnt + 1;
                baud_tick <= 0;
            end
        end
    end

    // UART FSM
    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            tx        <= 1;     // idle high
            tx_busy   <= 0;
            bit_index <= 0;
            shift_reg <= 0;
        end else begin
            case (state)

                IDLE: begin
                    tx <= 1;
                    tx_busy <= 0;
                    if (tx_start) begin
                        shift_reg <= tx_data;
                        tx_busy <= 1;
                        state <= START;
                    end
                end

                START: begin
                    if (baud_tick) begin
                        tx <= 0;       // start bit
                        bit_index <= 0;
                        state <= DATA;
                    end
                end

                DATA: begin
                    if (baud_tick) begin
                        tx <= shift_reg[0];
                        shift_reg <= shift_reg >> 1;
                        if (bit_index == 7)
                            state <= STOP;
                        else
                            bit_index <= bit_index + 1;
                    end
                end

                STOP: begin
                    if (baud_tick) begin
                        tx <= 1;      // stop bit
                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule