`timescale 1ns/1ps
module parity #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] data_in,
    input  wire             parity_bit,
    output wire             generated_parity,
    output wire             error
);

    // Even parity generation
    assign generated_parity = ^data_in;  
    // XOR reduction

    // Even parity checking
    assign error = (^{data_in, parity_bit});  

endmodule