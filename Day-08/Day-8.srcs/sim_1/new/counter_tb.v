`timescale 1ns/1ps
module counter_tb;

    reg clk;
    reg rst;
    reg enable;
    reg up_down;
    reg load;
    reg [7:0] load_data;
    wire [7:0] count;

    counter DUT (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .up_down(up_down),
        .load(load),
        .load_data(load_data),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        load = 0;
        up_down = 1;

        #10 rst = 0;

        // Count up
        enable = 1;
        #40;

        // Count down
        up_down = 0;
        #40;

        // Load value
        enable = 0;
        load = 1;
        load_data = 8'd100;
        #10 load = 0;

        // Count up again
        enable = 1;
        up_down = 1;
        #40;

        $stop;
    end

endmodule