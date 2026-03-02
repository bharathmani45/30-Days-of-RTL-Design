`timescale 1ns/1ps

module counter #(
    parameter WIDTH = 8
)(
    input  wire                 clk,
    input  wire                 rst,          // synchronous reset
    input  wire                 enable,
    input  wire                 up_down,      // 1 = up, 0 = down
    input  wire                 load,
    input  wire [WIDTH-1:0]     load_data,
    output reg  [WIDTH-1:0]     count
);

    always @(posedge clk) begin
        if (rst) begin
            count <= {WIDTH{1'b0}};
        end 
        else if (load) begin
            count <= load_data;
        end 
        else if (enable) begin
            if (up_down)
                count <= count + 1'b1;
            else
                count <= count - 1'b1;
        end
        else begin
            count <= count;  // explicit hold (optional but clear)
        end
    end

endmodule
