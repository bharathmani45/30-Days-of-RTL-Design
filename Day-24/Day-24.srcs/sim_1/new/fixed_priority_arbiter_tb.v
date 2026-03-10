`timescale 1ns/1ps

module fixed_priority_arbiter_tb;

reg [2:0] req;
wire [2:0] grant;

fixed_priority_arbiter DUT(
    .req(req),
    .grant(grant)
);

initial begin

req = 3'b000;

#10 req = 3'b001;
#10 req = 3'b010;
#10 req = 3'b100;

#10 req = 3'b011;
#10 req = 3'b110;
#10 req = 3'b111;

#20 $stop;

end

endmodule