`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 20:01:30
// Design Name: 
// Module Name: priority_encoder_tb
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
module priority_encoder_tb;

    reg  [7:0] data_in;
    reg        enable;
    wire [2:0] encoded_out;
    wire       valid;

    priority_encoder DUT (
        .data_in(data_in),
        .enable(enable),
        .encoded_out(encoded_out),
        .valid(valid)
    );

    initial begin

        enable = 1;

        data_in = 8'b00000000; #10;
        data_in = 8'b00010000; #10;
        data_in = 8'b00101000; #10; // multiple 1s
        data_in = 8'b10000001; #10;

        enable = 0;
        data_in = 8'b11111111; #10;

        $stop;
    end

endmodule
