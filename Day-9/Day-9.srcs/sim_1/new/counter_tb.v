`timescale 1ns/1ps

module counter_tb;

    reg clk;
    reg rst;

    wire [3:0] ring_out;
    wire [3:0] johnson_out;

    ring_counter RC (
        .clk(clk),
        .rst(rst),
        .count(ring_out)
    );

    johnson_counter JC (
        .clk(clk),
        .rst(rst),
        .count(johnson_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        #200;
        $stop;
    end

endmodule

