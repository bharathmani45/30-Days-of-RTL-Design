`timescale 1ns/1ps

module johnson_counter #(
    parameter WIDTH = 4
)(
    input  wire clk,
    input  wire rst,
    output reg  [WIDTH-1:0] count
);

    always @(posedge clk) begin
        if (rst)
            count <= 0;
        else
            count <= {~count[0], count[WIDTH-1:1]};
    end

endmodule
