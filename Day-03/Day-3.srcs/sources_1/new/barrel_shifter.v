`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2026 21:26:13
// Design Name: 
// Module Name: barrel_shifter
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
module barrel_shifter #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] data_in,
    input  wire [2:0]       shift_amt,
    input  wire [1:0]       mode,       
    // 00 = Logical Left
    // 01 = Logical Right
    // 10 = Arithmetic Right
    output wire [WIDTH-1:0] data_out
);

    wire [WIDTH-1:0] stage0;
    wire [WIDTH-1:0] stage1;
    wire [WIDTH-1:0] stage2;

    // -------- STAGE 0 : Shift by 1 --------
    assign stage0 = shift_amt[0] ? 
                    (mode == 2'b00) ? {data_in[WIDTH-2:0], 1'b0} :
                    (mode == 2'b01) ? {1'b0, data_in[WIDTH-1:1]} :
                                      {data_in[WIDTH-1], data_in[WIDTH-1:1]} 
                    : data_in;

    // -------- STAGE 1 : Shift by 2 --------
    assign stage1 = shift_amt[1] ?
                    (mode == 2'b00) ? {stage0[WIDTH-3:0], 2'b00} :
                    (mode == 2'b01) ? {2'b00, stage0[WIDTH-1:2]} :
                                      {{2{stage0[WIDTH-1]}}, stage0[WIDTH-1:2]}
                    : stage0;

    // -------- STAGE 2 : Shift by 4 --------
    assign stage2 = shift_amt[2] ?
                    (mode == 2'b00) ? {stage1[WIDTH-5:0], 4'b0000} :
                    (mode == 2'b01) ? {4'b0000, stage1[WIDTH-1:4]} :
                                      {{4{stage1[WIDTH-1]}}, stage1[WIDTH-1:4]}
                    : stage1;

    assign data_out = stage2;

endmodule
