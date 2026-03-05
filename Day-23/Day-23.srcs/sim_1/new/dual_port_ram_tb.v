`timescale 1ns/1ps

module dual_port_ram_tb;

reg clk_a;
reg clk_b;
reg rst;

reg we_a;
reg we_b;

reg [3:0] addr_a;
reg [3:0] addr_b;

reg [7:0] din_a;
reg [7:0] din_b;

wire [7:0] dout_a;
wire [7:0] dout_b;

dual_port_ram DUT(
    .clk_a(clk_a),
    .clk_b(clk_b),
    .rst(rst),
    .we_a(we_a),
    .we_b(we_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .din_a(din_a),
    .din_b(din_b),
    .dout_a(dout_a),
    .dout_b(dout_b)
);

always #5 clk_a = ~clk_a;
always #7 clk_b = ~clk_b;

initial begin

clk_a = 0;
clk_b = 0;
rst = 1;
we_a = 0;
we_b = 0;

addr_a = 0;
addr_b = 0;

din_a = 0;
din_b = 0;

#20 rst = 0;

#10
we_a = 1;
addr_a = 4'h3;
din_a = 8'hAA;

#10
we_a = 0;

#20
addr_b = 4'h3;

#40
we_b = 1;
addr_b = 4'h5;
din_b = 8'h55;

#10
we_b = 0;

#20
addr_a = 4'h5;

#60
$stop;

end

endmodule