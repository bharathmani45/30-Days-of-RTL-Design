`timescale 1ns/1ps

module spi_master #(
    parameter CLK_DIV = 4
)(
    input  wire clk,
    input  wire rst,
    input  wire start,
    input  wire [7:0] data_in,
    input  wire miso,
    output reg  mosi,
    output reg  sclk,
    output reg  cs,
    output reg  busy,
    output reg  done,
    output reg  [7:0] data_out
);

    // State encoding
    parameter IDLE     = 2'b00;
    parameter TRANSFER = 2'b01;
    parameter FINISH   = 2'b10;

    reg [1:0] state;
    reg [7:0] tx_shift;
    reg [7:0] rx_shift;
    reg [2:0] bit_cnt;
    reg [15:0] clk_cnt;

    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            sclk      <= 0;
            cs        <= 1;
            busy      <= 0;
            done      <= 0;
            clk_cnt   <= 0;
            bit_cnt   <= 0;
            tx_shift  <= 0;
            rx_shift  <= 0;
            data_out  <= 0;
            mosi      <= 0;
        end
        else begin

            done <= 0;  // default each cycle

            case (state)

                IDLE: begin
                    sclk <= 0;
                    cs   <= 1;
                    busy <= 0;
                    clk_cnt <= 0;

                    if (start) begin
                        cs       <= 0;
                        busy     <= 1;
                        tx_shift <= data_in;
                        rx_shift <= 0;
                        bit_cnt  <= 0;
                        state    <= TRANSFER;
                    end
                end

                TRANSFER: begin
                    clk_cnt <= clk_cnt + 1;

                    if (clk_cnt == CLK_DIV-1) begin
                        clk_cnt <= 0;
                        sclk    <= ~sclk;

                        // Mode 0 behavior
                        if (sclk == 0) begin
                            // Falling edge: shift out MSB
                            mosi     <= tx_shift[7];
                            tx_shift <= tx_shift << 1;
                        end
                        else begin
                            // Rising edge: sample MISO
                            rx_shift <= {rx_shift[6:0], miso};
                            bit_cnt  <= bit_cnt + 1;

                            if (bit_cnt == 3'd7)
                                state <= FINISH;
                        end
                    end
                end

                FINISH: begin
                    cs       <= 1;
                    busy     <= 0;
                    data_out <= rx_shift;
                    done     <= 1;
                    state    <= IDLE;
                end

            endcase
        end
    end

endmodule