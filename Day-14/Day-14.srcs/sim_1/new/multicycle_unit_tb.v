`timescale 1ns/1ps

module multicycle_unit_tb;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] A, B;
    wire [15:0] result;
    wire done;

    multicycle_unit DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .result(result),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        A = 0;
        B = 0;

        #10 rst = 0;

        // First operation
        #10;
        A = 8'd10;
        B = 8'd5;
        start = 1;
        #10 start = 0;

        #40;

        // Second operation
        A = 8'd7;
        B = 8'd3;
        start = 1;
        #10 start = 0;

        #50;

        $stop;
    end

endmodule