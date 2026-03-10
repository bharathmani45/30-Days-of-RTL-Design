`timescale 1ns/1ps

module fixed_priority_arbiter(
    input [2:0] req,
    output reg [2:0] grant
);

always @(*) begin
    grant = 3'b000;

    if (req[0])
        grant = 3'b001;
    else if (req[1])
        grant = 3'b010;
    else if (req[2])
        grant = 3'b100;
end

endmodule
