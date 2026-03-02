`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 15:46:36
// Design Name: 
// Module Name: cla_4bit
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
module cla_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       Cin,
    output wire [3:0] Sum,
    output wire       Cout
);

    wire [3:0] G;   // Generate
    wire [3:0] P;   // Propagate
    wire [4:0] C;   // Carry

    assign C[0] = Cin;

    // Generate and Propagate
    assign G = A & B;
    assign P = A ^ B;

    // Carry Lookahead Logic
    assign C[1] = G[0] | (P[0] & C[0]);

    assign C[2] = G[1] | 
                 (P[1] & G[0]) | 
                 (P[1] & P[0] & C[0]);

    assign C[3] = G[2] |
                 (P[2] & G[1]) |
                 (P[2] & P[1] & G[0]) |
                 (P[2] & P[1] & P[0] & C[0]);

    assign C[4] = G[3] |
                 (P[3] & G[2]) |
                 (P[3] & P[2] & G[1]) |
                 (P[3] & P[2] & P[1] & G[0]) |
                 (P[3] & P[2] & P[1] & P[0] & C[0]);

    // Sum
    assign Sum = P ^ C[3:0];

    assign Cout = C[4];

endmodule
