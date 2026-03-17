`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 22:55:41
// Design Name: 
// Module Name: alu_system
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

`timescale 1ns/1ps

module alu_system(

input clk,
input rst,

input we,
input [1:0] wr_addr,
input [7:0] wr_data,

input [1:0] rd_addr1,
input [1:0] rd_addr2,

input [2:0] alu_op,

input exec,   // trigger operation

output reg [7:0] result

);

/* wires */

wire [7:0] op_a;
wire [7:0] op_b;
reg  [7:0] alu_out;

/* Register File */

register_file RF(
    .clk(clk),
    .rst(rst),
    .we(we),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .rd_data1(op_a),
    .rd_data2(op_b)
);

/* ALU Logic */

always @(*) begin
    case(alu_op)
        3'b000: alu_out = op_a + op_b;
        3'b001: alu_out = op_a - op_b;
        3'b010: alu_out = op_a & op_b;
        3'b011: alu_out = op_a | op_b;
        3'b100: alu_out = op_a ^ op_b;
        default: alu_out = 0;
    endcase
end

/* Output Register */

always @(posedge clk) begin
    if(rst)
        result <= 0;
    else if(exec)
        result <= alu_out;
end

endmodule
