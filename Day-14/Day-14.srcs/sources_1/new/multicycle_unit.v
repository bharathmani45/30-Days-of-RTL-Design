`timescale 1ns/1ps

module multicycle_unit (
    input  wire        clk,
    input  wire        rst,
    input  wire        start,
    input  wire [7:0]  A,
    input  wire [7:0]  B,
    output reg  [15:0] result,
    output reg         done
);

    reg [7:0]  A_reg, B_reg;
    reg [15:0] stage1;
    reg        busy;

    always @(posedge clk) begin
        if (rst) begin
            A_reg  <= 0;
            B_reg  <= 0;
            stage1 <= 0;
            result <= 0;
            done   <= 0;
            busy   <= 0;
        end else begin
            done <= 0;  // default

            // Start operation
            if (start && !busy) begin
                A_reg <= A;
                B_reg <= B;
                busy  <= 1;
            end

            // Cycle 1: heavy logic
            if (busy && stage1 == 0) begin
                stage1 <= A_reg * B_reg;   // Example heavy logic
            end

            // Cycle 2: register output
            else if (busy) begin
                result <= stage1;
                stage1 <= 0;
                busy   <= 0;
                done   <= 1;
            end
        end
    end

endmodule