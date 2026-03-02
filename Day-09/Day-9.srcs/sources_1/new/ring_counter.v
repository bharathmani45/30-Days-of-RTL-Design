`timescale 1ns/1ps

module ring_counter #(
    parameter WIDTH = 4
)(
    input  wire clk,
    input  wire rst,
    output reg  [WIDTH-1:0] count
);

    always @(posedge clk) begin
        if (rst)
            count <= 4'b0001;   // One-hot initialization
        else
            count <= {count[WIDTH-2:0], count[WIDTH-1]};
    end

endmodule

