`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 22:59:55
// Design Name: 
// Module Name: register_file
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

module register_file(

input clk,
input rst,

input we,
input [1:0] wr_addr,
input [7:0] wr_data,

input [1:0] rd_addr1,
input [1:0] rd_addr2,

output reg [7:0] rd_data1,
output reg [7:0] rd_data2

);

reg [7:0] reg_file [0:3];
integer i;

always @(posedge clk) begin
    if (rst) begin
        for(i = 0; i < 4; i = i + 1)
            reg_file[i] <= 0;
    end
    else if (we) begin
        reg_file[wr_addr] <= wr_data;
    end
end

always @(*) begin
    rd_data1 = reg_file[rd_addr1];
    rd_data2 = reg_file[rd_addr2];
end

endmodule
