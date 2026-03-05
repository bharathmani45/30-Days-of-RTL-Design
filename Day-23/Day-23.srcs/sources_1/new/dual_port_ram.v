`timescale 1ns/1ps

module dual_port_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input clk_a,
    input clk_b,
    input rst,

    input we_a,
    input we_b,

    input [ADDR_WIDTH-1:0] addr_a,
    input [ADDR_WIDTH-1:0] addr_b,

    input [DATA_WIDTH-1:0] din_a,
    input [DATA_WIDTH-1:0] din_b,

    output reg [DATA_WIDTH-1:0] dout_a,
    output reg [DATA_WIDTH-1:0] dout_b
);

localparam DEPTH = 1 << ADDR_WIDTH;

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
integer i;

initial begin
    for (i = 0; i < DEPTH; i = i + 1)
        mem[i] = 0;
end


always @(posedge clk_a) begin
    if (rst)
        dout_a <= 0;
    else begin
        if (we_a)
            mem[addr_a] <= din_a;

        dout_a <= mem[addr_a];
    end
end


always @(posedge clk_b) begin
    if (rst)
        dout_b <= 0;
    else begin
        if (we_b)
            mem[addr_b] <= din_b;

        dout_b <= mem[addr_b];
    end
end

endmodule