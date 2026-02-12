`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 15:47:02
// Design Name: 
// Module Name: cla_block
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
module cla_block #(
    parameter WIDTH = 4
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire             Cin,
    output wire [WIDTH-1:0] Sum,
    output wire             Cout
);

    wire [WIDTH-1:0] G;
    wire [WIDTH-1:0] P;
    wire [WIDTH:0]   C;

    assign C[0] = Cin;

    assign G = A & B;
    assign P = A ^ B;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin
            assign C[i+1] = G[i] | (P[i] & C[i]);
            assign Sum[i] = P[i] ^ C[i];
        end
    endgenerate

    assign Cout = C[WIDTH];

endmodule

