`timescale 1ns/1ps

module fifo_sync #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

localparam ADDR_WIDTH = $clog2(DEPTH);

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

reg [ADDR_WIDTH:0] w_ptr;
reg [ADDR_WIDTH:0] r_ptr;


// WRITE LOGIC
always @(posedge clk) begin
    if (rst)
        w_ptr <= 0;
    else if (wr_en && !full) begin
        mem[w_ptr[ADDR_WIDTH-1:0]] <= data_in;
        w_ptr <= w_ptr + 1;
    end
end


// READ LOGIC
always @(posedge clk) begin
    if (rst) begin
        r_ptr <= 0;
        data_out <= 0;
    end
    else if (rd_en && !empty) begin
        data_out <= mem[r_ptr[ADDR_WIDTH-1:0]];
        r_ptr <= r_ptr + 1;
    end
end


// STATUS FLAGS
assign empty = (w_ptr == r_ptr);

assign full =
    (w_ptr[ADDR_WIDTH] != r_ptr[ADDR_WIDTH]) &&
    (w_ptr[ADDR_WIDTH-1:0] == r_ptr[ADDR_WIDTH-1:0]);

endmodule