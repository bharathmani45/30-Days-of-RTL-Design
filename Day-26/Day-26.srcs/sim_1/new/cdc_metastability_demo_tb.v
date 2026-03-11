`timescale 1ns/1ps

module cdc_metastability_demo_tb;

reg clk_a;
reg clk_b;
reg rst;

wire unsafe_out;
wire safe_out;

cdc_metastability_demo DUT(
    .clk_a(clk_a),
    .clk_b(clk_b),
    .rst(rst),
    .unsafe_out(unsafe_out),
    .safe_out(safe_out)
);


/* Two different clock domains */

always #5 clk_a = ~clk_a;   // 100 MHz
always #7 clk_b = ~clk_b;   // ~71 MHz


initial begin

clk_a = 0;
clk_b = 0;
rst = 1;

#20 rst = 0;

#300 $stop;

end

endmodule