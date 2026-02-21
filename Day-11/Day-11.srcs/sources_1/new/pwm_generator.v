`timescale 1ns/1ps

module pwm_generator #(
    parameter WIDTH = 8
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     duty_cycle,   // 0 to 2^WIDTH-1
    output reg                  pwm_out
);

    reg [WIDTH-1:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            counter <= counter + 1;

            if (counter < duty_cycle)
                pwm_out <= 1;
            else
                pwm_out <= 0;
        end
    end

endmodule