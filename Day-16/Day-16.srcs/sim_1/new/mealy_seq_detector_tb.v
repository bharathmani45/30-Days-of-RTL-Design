`timescale 1ns/1ps

module mealy_seq_detector_tb;

    reg clk;
    reg rst;
    reg din;
    wire dout;

    mealy_seq_detector DUT (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        din = 0;

        #10 rst = 0;

        // Input: 1 0 1 0 1
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;

        #50;

        $stop;
    end

endmodule