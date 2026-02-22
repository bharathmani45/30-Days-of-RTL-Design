`timescale 1ns/1ps

module debounce #(
    parameter WIDTH = 20   // Adjust for debounce time
)(
    input  wire clk,
    input  wire rst,
    input  wire button_in,     // Asynchronous input
    output reg  button_out     // Clean output
);

    // 2-flop synchronizer
    reg sync_0, sync_1;

    // Stability counter
    reg [WIDTH-1:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            sync_0 <= 0;
            sync_1 <= 0;
        end else begin
            sync_0 <= button_in;
            sync_1 <= sync_0;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            counter    <= 0;
            button_out <= 0;
        end else begin
            if (sync_1 == button_out) begin
                counter <= 0;  // No change
            end else begin
                counter <= counter + 1;

                if (&counter) begin
                    button_out <= sync_1;
                    counter <= 0;
                end
            end
        end
    end

endmodule
