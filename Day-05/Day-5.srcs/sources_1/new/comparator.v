`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2026 13:12:47
// Design Name: 
// Module Name: comparator
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
module comparator #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire             signed_mode,  // 0 = unsigned, 1 = signed
    output reg              greater,
    output reg              equal,
    output reg              less
);

    always @(*) begin
        // Default assignments (avoid latches)
        greater = 0;
        equal   = 0;
        less    = 0;

        if (signed_mode) begin
            // Signed comparison
            if ($signed(A) > $signed(B))
                greater = 1;
            else if ($signed(A) < $signed(B))
                less = 1;
            else
                equal = 1;
        end
        else begin
            // Unsigned comparison
            if (A > B)
                greater = 1;
            else if (A < B)
                less = 1;
            else
                equal = 1;
        end
    end

endmodule

