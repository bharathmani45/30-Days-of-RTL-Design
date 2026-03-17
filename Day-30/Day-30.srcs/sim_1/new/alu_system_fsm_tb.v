`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:07:15
// Design Name: 
// Module Name: alu_system_fsm_tb
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

module alu_system_fsm_tb;

reg clk, rst, start;
reg [7:0] data_a, data_b;
reg [2:0] alu_op;

wire done;
wire [7:0] result;

alu_system_fsm DUT(
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_a(data_a),
    .data_b(data_b),
    .alu_op(alu_op),
    .done(done),
    .result(result)
);

always #5 clk = ~clk;

initial begin

clk = 0;
rst = 1;
start = 0;

data_a = 10;
data_b = 5;
alu_op = 3'b000;

#20 rst = 0;

#10 start = 1;
#10 start = 0;

#100 $stop;

end

endmodule