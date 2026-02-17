`timescale 1ns/1ps

module pipelined_adder_tb;

    reg clk;
    reg rst;
    reg [7:0] A, B;
    wire [7:0] Sum;

    pipelined_adder DUT (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .Sum(Sum)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10;
        rst = 0;

        A = 10; B = 20;
        #10;
        A = 5; B = 6;
        #10;
        A = 15; B = 5;
        #50;

        $stop;
    end

endmodule