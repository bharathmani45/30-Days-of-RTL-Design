`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 14:44:35
// Design Name: 
// Module Name: axi_lite_slave_tb
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

//`timescale 1ns/1ps

module axi_lite_slave_tb;

reg clk;
reg rst;

reg [3:0] awaddr;
reg awvalid;

reg [31:0] wdata;
reg wvalid;

reg bready;

reg [3:0] araddr;
reg arvalid;

reg rready;

wire awready;
wire wready;
wire bvalid;

wire arready;
wire rvalid;

wire [31:0] rdata;


axi_lite_slave DUT(

.clk(clk),
.rst(rst),

.awaddr(awaddr),
.awvalid(awvalid),
.awready(awready),

.wdata(wdata),
.wvalid(wvalid),
.wready(wready),

.bvalid(bvalid),
.bready(bready),

.araddr(araddr),
.arvalid(arvalid),
.arready(arready),

.rdata(rdata),
.rvalid(rvalid),
.rready(rready)

);


always #5 clk = ~clk;


initial begin

clk = 0;
rst = 1;

awvalid = 0;
wvalid = 0;
arvalid = 0;

bready = 1;
rready = 1;

#20 rst = 0;


/* write register */

#10
awaddr = 4'h0;
wdata = 32'hDEADBEEF;
awvalid = 1;
wvalid = 1;

#10
awvalid = 0;
wvalid = 0;


/* read register */

#20
araddr = 4'h0;
arvalid = 1;

#10
arvalid = 0;


#100 $stop;

end

endmodule