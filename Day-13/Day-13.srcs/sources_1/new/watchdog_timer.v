`timescale 1ns/1ps

module watchdog_timer #(
    parameter WIDTH = 24   // Timeout resolution
)(
    input  wire clk,
    input  wire rst,
    input  wire kick,          // Refresh signal
    output reg  wdt_reset      // Watchdog reset output
);

    reg [WIDTH-1:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            counter   <= 0;
            wdt_reset <= 0;
        end else begin
            if (kick) begin
                counter   <= 0;      // Refresh timer
                wdt_reset <= 0;
            end else begin
                counter <= counter + 1;

                if (&counter) begin
                    wdt_reset <= 1;  // Timeout occurred
                end
            end
        end
    end

endmodule