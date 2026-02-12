`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2026 14:39:28
// Design Name: 
// Module Name: alu_tb
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
module alu_tb;

    parameter WIDTH = 8;

    reg  [WIDTH-1:0] A;
    reg  [WIDTH-1:0] B;
    reg  [2:0]       ALU_Sel;
    wire [WIDTH-1:0] Result;
    wire             Overflow;

    alu #(WIDTH) DUT (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .Result(Result),
        .Overflow(Overflow)
    );

    task check_result;
        input [WIDTH-1:0] exp_result;
        input exp_overflow;
        begin
            #1;
            if (Result !== exp_result || Overflow !== exp_overflow) begin
                $display("? ERROR: A=%0d B=%0d Sel=%b | Got=%0d Ov=%b | Exp=%0d Ov=%b",
                         A, B, ALU_Sel, Result, Overflow, exp_result, exp_overflow);
            end else begin
                $display("? PASS: A=%0d B=%0d Sel=%b | Result=%0d Ov=%b",
                         A, B, ALU_Sel, Result, Overflow);
            end
        end
    endtask

    initial begin

        // ADD
        A = 8'd10; B = 8'd20; ALU_Sel = 3'b000;
        check_result(8'd30, 0);

        // ADD overflow (signed)
        A = 8'd127; B = 8'd1; ALU_Sel = 3'b000;
        check_result(8'd128, 1);

        // SUB
        A = 8'd50; B = 8'd20; ALU_Sel = 3'b001;
        check_result(8'd30, 0);

        // SUB overflow (signed)
        A = -128; B = 1; ALU_Sel = 3'b001;
        check_result(127, 1);

        // AND
        A = 8'b10101010; B = 8'b11001100; ALU_Sel = 3'b010;
        check_result(8'b10001000, 0);

        // OR
        ALU_Sel = 3'b011;
        check_result(8'b11101110, 0);

        // XOR
        ALU_Sel = 3'b100;
        check_result(8'b01100110, 0);

        // SLT (signed)
        A = -5; B = 3; ALU_Sel = 3'b101;
        check_result(1, 0);

        A = 5; B = -3; ALU_Sel = 3'b101;
        check_result(0, 0);

        $display("Simulation Finished");
        $stop;
    end

endmodule
