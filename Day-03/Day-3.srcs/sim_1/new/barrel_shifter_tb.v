`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2026 21:26:33
// Design Name: 
// Module Name: barrel_shifter_tb
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
module barrel_shifter_tb;

    reg  [7:0] data_in;
    reg  [2:0] shift_amt;
    reg  [1:0] mode;
    wire [7:0] data_out;

    barrel_shifter DUT (
        .data_in(data_in),
        .shift_amt(shift_amt),
        .mode(mode),
        .data_out(data_out)
    );

    initial begin

        // Logical Left
        data_in = 8'b10110011;
        shift_amt = 3'd2;
        mode = 2'b00;
        #10;

        // Logical Right
        shift_amt = 3'd3;
        mode = 2'b01;
        #10;

        // Arithmetic Right
        data_in = 8'b11110000; // negative number
        shift_amt = 3'd2;
        mode = 2'b10;
        #10;

        $stop;
    end

endmodule

