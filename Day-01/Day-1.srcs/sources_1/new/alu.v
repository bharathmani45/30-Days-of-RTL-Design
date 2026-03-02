`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2026 14:38:54
// Design Name: 
// Module Name: alu
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
module alu #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [2:0]       ALU_Sel,
    output reg  [WIDTH-1:0] Result,
    output reg              Overflow
);

    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND_OP = 3'b010;
    localparam OR_OP  = 3'b011;
    localparam XOR_OP = 3'b100;
    localparam SLT = 3'b101;

    wire [WIDTH-1:0] add_result;
    wire [WIDTH-1:0] sub_result;

    assign add_result = A + B;
    assign sub_result = A - B;

    always @(*) begin
        Overflow = 1'b0;

        case (ALU_Sel)

            ADD: begin
                Result = add_result;
                // Signed overflow detection
                Overflow = (A[WIDTH-1] == B[WIDTH-1]) &&
                           (Result[WIDTH-1] != A[WIDTH-1]);
            end

            SUB: begin
                Result = sub_result;
                // Signed overflow detection for subtraction
                Overflow = (A[WIDTH-1] != B[WIDTH-1]) &&
                           (Result[WIDTH-1] != A[WIDTH-1]);
            end

            AND_OP: begin
                Result = A & B;
            end

            OR_OP: begin
                Result = A | B;
            end

            XOR_OP: begin
                Result = A ^ B;
            end

            SLT: begin
                // Signed comparison
                Result = ($signed(A) < $signed(B)) ? 1 : 0;
            end

            default: begin
                Result = {WIDTH{1'b0}};
            end
        endcase
    end

endmodule
