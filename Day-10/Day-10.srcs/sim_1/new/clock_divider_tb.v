`timescale 1ns/1ps

module clock_divider_tb;

    reg clk;
    reg rst;
    wire clk_out;

    clock_divider #(.DIVISOR(4)) DUT (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    always #5 clk = ~clk;  // 100 MHz equivalent

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        #200;
        $stop;
    end

endmodule