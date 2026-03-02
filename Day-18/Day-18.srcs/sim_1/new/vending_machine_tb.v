`timescale 1ns/1ps

module vending_machine_tb;

    reg clk;
    reg rst;
    reg coin_5;
    reg coin_10;

    wire dispense;
    wire change_return;

    vending_machine DUT (
        .clk(clk),
        .rst(rst),
        .coin_5(coin_5),
        .coin_10(coin_10),
        .dispense(dispense),
        .change_return(change_return)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        coin_5 = 0;
        coin_10 = 0;

        #10 rst = 0;

        // Insert 5 + 5
        #10 coin_5 = 1; #10 coin_5 = 0;
        #20 coin_5 = 1; #10 coin_5 = 0;

        #40;

        // Insert 10
        #10 coin_10 = 1; #10 coin_10 = 0;

        #40;

        // Insert 10 + 5
        #10 coin_10 = 1; #10 coin_10 = 0;
        #20 coin_5 = 1;  #10 coin_5 = 0;

        #100;

        $stop;
    end

endmodule