`timescale 1ns/1ps

module cdc_metastability_demo(

    input clk_a,
    input clk_b,
    input rst,

    output reg unsafe_out,
    output safe_out

);

reg async_signal;

/* Generate signal in clock domain A */

always @(posedge clk_a) begin
    if (rst)
        async_signal <= 0;
    else
        async_signal <= ~async_signal;
end


/* Unsafe sampling directly in clk_b domain */

always @(posedge clk_b) begin
    if (rst)
        unsafe_out <= 0;
    else
        unsafe_out <= async_signal;
end


/* Safe synchronizer */

reg sync_ff1;
reg sync_ff2;

always @(posedge clk_b) begin
    if (rst) begin
        sync_ff1 <= 0;
        sync_ff2 <= 0;
    end
    else begin
        sync_ff1 <= async_signal;
        sync_ff2 <= sync_ff1;
    end
end

assign safe_out = sync_ff2;

endmodule