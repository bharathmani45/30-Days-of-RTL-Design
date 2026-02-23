`timescale 1ns/1ps

module watchdog_timer_tb;

    reg clk;
    reg rst;
    reg kick;
    wire wdt_reset;

    watchdog_timer #(.WIDTH(4)) DUT (
        .clk(clk),
        .rst(rst),
        .kick(kick),
        .wdt_reset(wdt_reset)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        kick = 0;

        #10 rst = 0;

        // Kick periodically
        #20 kick = 1;
        #10 kick = 0;

        #20 kick = 1;
        #10 kick = 0;

        // Stop kicking ? expect reset
        #200;

        $stop;
    end

endmodule
