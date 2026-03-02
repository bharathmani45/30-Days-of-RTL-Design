`timescale 1ns/1ps

module pipelined_adder #(
    parameter WIDTH = 8
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     A,
    input  wire [WIDTH-1:0]     B,
    output wire [WIDTH-1:0]     Sum
);

    // Stage 1 registers
    reg [WIDTH-1:0] A_reg, B_reg;
    reg [WIDTH-1:0] partial_sum;

    // Stage 2 register
    reg [WIDTH-1:0] Sum_reg;

    // Stage 1
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A_reg <= 0;
            B_reg <= 0;
            partial_sum <= 0;
        end else begin
            A_reg <= A;
            B_reg <= B;
            partial_sum <= A_reg + B_reg;
        end
    end

    // Stage 2
    always @(posedge clk or posedge rst) begin
        if (rst)
            Sum_reg <= 0;
        else
            Sum_reg <= partial_sum;
    end

    assign Sum = Sum_reg;

endmodule

