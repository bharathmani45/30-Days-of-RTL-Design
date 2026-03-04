`timescale 1ns/1ps

module fifo_sync_tb;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] data_in;

wire [7:0] data_out;
wire full;
wire empty;

fifo_sync #(
    .DATA_WIDTH(8),
    .DEPTH(8)
) DUT (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    #20;
    rst = 0;

    repeat (5) begin
        #10;
        wr_en = 1;
        data_in = data_in + 1;
    end

    #10;
    wr_en = 0;

    repeat (5) begin
        #10;
        rd_en = 1;
    end

    #10;
    rd_en = 0;

    #50;
    $stop;
end

endmodule