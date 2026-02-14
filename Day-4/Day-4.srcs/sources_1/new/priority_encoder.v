`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 20:01:11
// Design Name: 
// Module Name: priority_encoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module priority_encoder #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] data_in,
    input  wire             enable,
    output reg  [$clog2(WIDTH)-1:0] encoded_out,
    output reg              valid
);

    integer i;

    always @(*) begin
        encoded_out = 0;
        valid = 0;

        if (enable) begin
            for (i = WIDTH-1; i >= 0; i = i - 1) begin
                if (data_in[i] && !valid) begin
                    encoded_out = i;
                    valid = 1;
                end
            end
        end
    end

endmodule


