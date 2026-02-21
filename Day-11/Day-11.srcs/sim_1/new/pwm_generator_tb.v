`timescale 1ns/1ps

module pwm_generator_tb;

    reg clk;
    reg rst;
    reg [7:0] duty_cycle;
    wire pwm_out;

    pwm_generator DUT (
        .clk(clk),
        .rst(rst),
        .duty_cycle(duty_cycle),
        .pwm_out(pwm_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        duty_cycle = 8'd64;  // 25% duty

        #10 rst = 0;

        #200;

        duty_cycle = 8'd128; // 50% duty
        #200;

        duty_cycle = 8'd192; // 75% duty
        #200;

        $stop;
    end

endmodule