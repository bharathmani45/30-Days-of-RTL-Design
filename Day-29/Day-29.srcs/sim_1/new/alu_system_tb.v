`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 22:56:01
// Design Name: 
// Module Name: alu_system_tb
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

module alu_system_tb;

reg clk, rst;
reg we;
reg exec;

reg [1:0] wr_addr;
reg [7:0] wr_data;

reg [1:0] rd_addr1, rd_addr2;
reg [2:0] alu_op;

wire [7:0] result;

alu_system DUT(
    .clk(clk),
    .rst(rst),
    .we(we),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .alu_op(alu_op),
    .exec(exec),
    .result(result)
);

always #5 clk = ~clk;

initial begin

clk = 0;
rst = 1;
we = 0;
exec = 0;

#20 rst = 0;

/* Load values */

#10 we = 1; wr_addr = 2'b00; wr_data = 8'd10;
#10 we = 1; wr_addr = 2'b01; wr_data = 8'd5;

#10 we = 0;

/* ADD */

rd_addr1 = 2'b00;
rd_addr2 = 2'b01;
alu_op = 3'b000;

#10 exec = 1;
#10 exec = 0;

/* SUB */

#20 alu_op = 3'b001;

#10 exec = 1;
#10 exec = 0;

#50 $stop;

end

endmodule
