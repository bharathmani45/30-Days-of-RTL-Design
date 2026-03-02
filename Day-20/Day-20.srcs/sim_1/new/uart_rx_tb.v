`timescale 1ns/1ps

module uart_loopback_tb;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;

    wire tx;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_done;

    // Instantiate TX
    uart_tx #(
        .CLK_FREQ(1000000),
        .BAUD_RATE(1000)
    ) TX (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Instantiate RX
    uart_rx #(
        .CLK_FREQ(1000000),
        .BAUD_RATE(1000)
    ) RX (
        .clk(clk),
        .rst(rst),
        .rx(tx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h3C;

        #20 rst = 0;

        #20 tx_start = 1;
        #10 tx_start = 0;

        #100000;

        $stop;
    end

endmodule