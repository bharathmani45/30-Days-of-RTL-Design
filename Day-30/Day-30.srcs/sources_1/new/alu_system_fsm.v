`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:06:56
// Design Name: 
// Module Name: alu_system_fsm
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

`timescale 1ns/1ps

module alu_system_fsm(

input clk,
input rst,
input start,

input [7:0] data_a,
input [7:0] data_b,
input [2:0] alu_op,

output reg done,
output reg [7:0] result

);

/* internal control */

reg we;
reg exec;

reg [1:0] wr_addr;
reg [1:0] rd_addr1;
reg [1:0] rd_addr2;

/* datapath wires */

wire [7:0] op_a;
wire [7:0] op_b;
reg  [7:0] alu_out;

/* FSM states */

reg [1:0] state;

parameter IDLE = 2'b00;
parameter LOAD = 2'b01;
parameter EXEC = 2'b10;
parameter DONE = 2'b11;

/* Register File */

register_file RF(
    .clk(clk),
    .rst(rst),
    .we(we),
    .wr_addr(wr_addr),
    .wr_data((wr_addr==0)?data_a:data_b),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .rd_data1(op_a),
    .rd_data2(op_b)
);

/* ALU */

always @(*) begin
    case(alu_op)
        3'b000: alu_out = op_a + op_b;
        3'b001: alu_out = op_a - op_b;
        3'b010: alu_out = op_a & op_b;
        3'b011: alu_out = op_a | op_b;
        3'b100: alu_out = op_a ^ op_b;
        default: alu_out = 0;
    endcase
end

/* FSM */

always @(posedge clk) begin
    if(rst) begin
        state <= IDLE;
        done <= 0;
        we <= 0;
        exec <= 0;
    end

    else begin

        case(state)

        IDLE: begin
            done <= 0;
            if(start)
                state <= LOAD;
        end

        LOAD: begin
            we <= 1;
            wr_addr <= 0;
            state <= EXEC;
        end

        EXEC: begin
            we <= 1;
            wr_addr <= 1;

            rd_addr1 <= 0;
            rd_addr2 <= 1;

            exec <= 1;
            result <= alu_out;

            state <= DONE;
        end

        DONE: begin
            we <= 0;
            exec <= 0;
            done <= 1;
            state <= IDLE;
        end

        endcase

    end
end

endmodule
