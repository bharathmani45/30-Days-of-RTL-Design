`timescale 1ns/1ps

module cdc_synchronizer_tb;

reg clk;
reg rst;
reg async_in;

wire sync_out;

cdc_synchronizer DUT(
    .clk(clk),
    .rst(rst),
    .async_in(async_in),
    .sync_out(sync_out)
);

always #5 clk = ~clk;

initial begin

clk = 0;
rst = 1;
async_in = 0;

#20 rst = 0;

#13 async_in = 1;
#17 async_in = 0;
#11 async_in = 1;
#19 async_in = 0;

#50 $stop;

end

endmodule
