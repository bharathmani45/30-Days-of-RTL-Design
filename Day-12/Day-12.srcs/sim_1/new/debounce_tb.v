`timescale 1ns/1ps

module debounce_tb;

    reg clk;
    reg rst;
    reg button_in;
    wire button_out;

    debounce #(.WIDTH(4)) DUT (
        .clk(clk),
        .rst(rst),
        .button_in(button_in),
        .button_out(button_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        button_in = 0;

        #10 rst = 0;

        // Simulated bounce
        #20 button_in = 1;
        #5  button_in = 0;
        #5  button_in = 1;
        #5  button_in = 0;
        #5  button_in = 1;

        #200;

        $stop;
    end

endmodule