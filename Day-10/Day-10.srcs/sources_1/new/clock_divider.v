`timescale 1ns/1ps

module clock_divider #(
    parameter DIVISOR = 4   // Must be even for 50% duty
)(
    input  wire clk,
    input  wire rst,
    output reg  clk_out
);

    localparam WIDTH = $clog2(DIVISOR);
    reg [WIDTH-1:0] count;

    always @(posedge clk) begin
        if (rst) begin
            count   <= 0;
            clk_out <= 0;
        end else begin
            if (count == (DIVISOR/2 - 1)) begin
                clk_out <= ~clk_out;
                count   <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule
