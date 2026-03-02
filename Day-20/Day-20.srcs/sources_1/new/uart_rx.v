`timescale 1ns/1ps

module uart_rx(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600
)(
    input  wire clk,
    input  wire rst,
    input  wire rx,
    output reg  [7:0] rx_data,
    output reg  rx_done
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

    // UART RX FSM
    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            bit_index <= 0;
            shift_reg <= 0;
            rx_done   <= 0;
            rx_data   <= 0;
        end else begin
            rx_done <= 0;

            case (state)

                IDLE: begin
                    if (rx == 0) begin  // Detect start bit
                        state <= START;
                        baud_cnt <= BAUD_DIV/2; // sample mid-bit
                    end
                end

                START: begin
                    if (baud_tick) begin
                        if (rx == 0)
                            state <= DATA;
                        else
                            state <= IDLE; // false start
                    end
                end

                DATA: begin
                    if (baud_tick) begin
                        shift_reg <= {rx, shift_reg[7:1]};
                        if (bit_index == 7) begin
                            bit_index <= 0;
                            state <= STOP;
                        end else
                            bit_index <= bit_index + 1;
                    end
                end

                STOP: begin
                    if (baud_tick) begin
                        rx_data <= shift_reg;
                        rx_done <= 1;
                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule