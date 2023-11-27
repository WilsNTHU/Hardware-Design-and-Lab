`timescale 1ns/1ps

module GCD_Test;

reg clk, rst_n, start;
reg [15:0] a, b;
wire done;
wire [15:0] gcd;

Greatest_Common_Divisor g1(clk, rst_n, start, a, b, done, gcd);

always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    a = 16'd20;
    b = 16'd15;

    #10
    rst_n = 1'b1;

    #10
    start = 1'b1;

    #100;
    start = 1'b0;
    #10
    a = 16'd100;
    b = 16'd25;
    start = 1'b1;
    #200;
end
endmodule