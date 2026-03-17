`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 22:40:28
// Design Name: 
// Module Name: register_file_tb
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

module register_file_tb;

reg clk, rst, we;
reg [1:0] wr_addr, rd_addr1, rd_addr2;
reg [7:0] wr_data;

wire [7:0] rd_data1, rd_data2;

register_file DUT(
    .clk(clk),
    .rst(rst),
    .we(we),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .rd_data1(rd_data1),
    .rd_data2(rd_data2)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 1;
we = 0;

#20 rst = 0;

#10 we = 1; wr_addr = 2'b00; wr_data = 8'h0A;
#10 we = 1; wr_addr = 2'b01; wr_data = 8'h05;

#10 we = 0;

rd_addr1 = 2'b00;
rd_addr2 = 2'b01;

#50 $stop;
end

endmodule