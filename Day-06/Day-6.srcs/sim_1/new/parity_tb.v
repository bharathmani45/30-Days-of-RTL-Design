`timescale 1ns/1ps
module parity_tb;

    reg  [7:0] data_in;
    reg        parity_bit;
    wire       generated_parity;
    wire       error;

    parity DUT (
        .data_in(data_in),
        .parity_bit(parity_bit),
        .generated_parity(generated_parity),
        .error(error)
    );
initial begin

    // Case 1: No error
    data_in = 8'b10101010;
    #5;
    parity_bit = generated_parity;   // Match parity
    #10;

    // Case 2: Inject single-bit error
    data_in = 8'b10101011;   // Flip 1 bit
    #10;

    $stop;
end
endmodule