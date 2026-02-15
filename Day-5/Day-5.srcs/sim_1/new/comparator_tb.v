`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2026 13:13:05
// Design Name: 
// Module Name: comparator_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module comparator_tb;

    reg  [7:0] A;
    reg  [7:0] B;
    reg        signed_mode;
    wire       greater;
    wire       equal;
    wire       less;

    comparator DUT (
        .A(A),
        .B(B),
        .signed_mode(signed_mode),
        .greater(greater),
        .equal(equal),
        .less(less)
    );

    initial begin

        // Unsigned comparison
        signed_mode = 0;
        A = 8'd200; B = 8'd100; #10;
        A = 8'd10;  B = 8'd50;  #10;

        // Signed comparison
        signed_mode = 1;
        A = -5; B = 5; #10;
        A = -10; B = -20; #10;
        A = 8'd25; B = 8'd25; #10;

        $stop;
    end

endmodule

