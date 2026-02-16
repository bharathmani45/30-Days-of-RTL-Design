`timescale 1ns/1ps
module hamming_7_4_encoder(
    input  wire [3:0] data_in,
    output wire [6:0] code_out
);

    wire p1, p2, p3;

    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3];
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3];
    assign p3 = data_in[1] ^ data_in[2] ^ data_in[3];

    assign code_out = {data_in[3], data_in[2], data_in[1], p3,
                       data_in[0], p2, p1};

endmodule