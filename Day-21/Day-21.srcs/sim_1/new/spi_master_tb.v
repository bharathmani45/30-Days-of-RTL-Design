`timescale 1ns/1ps

module spi_master_tb;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] data_in;
    wire mosi;
    wire sclk;
    wire cs;
    wire busy;
    wire done;
    wire [7:0] data_out;

    // Loopback
    wire miso = mosi;

    spi_master #(.CLK_DIV(4)) DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .miso(miso),
        .mosi(mosi),
        .sclk(sclk),
        .cs(cs),
        .busy(busy),
        .done(done),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        data_in = 8'hA5;

        #20 rst = 0;

        #20 start = 1;
        #10 start = 0;

        #1000;

        $stop;
    end

endmodule