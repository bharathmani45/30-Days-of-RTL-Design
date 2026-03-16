`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 14:44:05
// Design Name: 
// Module Name: axi_lite_slave
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

module axi_lite_slave(

input clk,
input rst,

/* write channel */

input [3:0] awaddr,
input awvalid,
output reg awready,

input [31:0] wdata,
input wvalid,
output reg wready,

output reg bvalid,
input bready,

/* read channel */

input [3:0] araddr,
input arvalid,
output reg arready,

output reg [31:0] rdata,
output reg rvalid,
input rready

);

reg [31:0] reg0;
reg [31:0] reg1;
reg [31:0] reg2;
reg [31:0] reg3;


/* WRITE LOGIC */

always @(posedge clk) begin

if(rst) begin
awready <= 0;
wready <= 0;
bvalid <= 0;

reg0 <= 0;
reg1 <= 0;
reg2 <= 0;
reg3 <= 0;
end

else begin

awready <= awvalid;
wready <= wvalid;

if(awvalid && wvalid) begin

case(awaddr)

4'h0: reg0 <= wdata;
4'h4: reg1 <= wdata;
4'h8: reg2 <= wdata;
4'hC: reg3 <= wdata;

endcase

bvalid <= 1;

end

if(bvalid && bready)
bvalid <= 0;

end

end


/* READ LOGIC */

always @(posedge clk) begin

if(rst) begin
arready <= 0;
rvalid <= 0;
rdata <= 0;
end

else begin

arready <= arvalid;

if(arvalid) begin

case(araddr)

4'h0: rdata <= reg0;
4'h4: rdata <= reg1;
4'h8: rdata <= reg2;
4'hC: rdata <= reg3;

endcase

rvalid <= 1;

end

if(rvalid && rready)
rvalid <= 0;

end

end

endmodule