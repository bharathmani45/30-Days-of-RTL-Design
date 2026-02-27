`timescale 1ns/1ps

module traffic_light_controller_tb;

    reg clk;
    reg rst;
    reg emergency;

    wire green, yellow, red;

    traffic_light_controller DUT (
        .clk(clk),
        .rst(rst),
        .emergency(emergency),
        .green(green),
        .yellow(yellow),
        .red(red)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        emergency = 0;

        #10 rst = 0;

        // Let normal cycle run
        #100;

        // Trigger emergency
        emergency = 1;
        #30;

        // Clear emergency
        emergency = 0;
        #100;

        $stop;
    end

endmodule