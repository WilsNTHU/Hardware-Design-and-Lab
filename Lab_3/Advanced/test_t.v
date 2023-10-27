`timescale 1ns/1ps

module clk_diviver_test;
reg clk = 1'b0;
reg rst_n = 1'b1;
wire dclk;

always #5 clk = !clk;

clk_divider c1(clk, rst_n, dclk);

initial begin
    @(negedge clk) rst_n = 1'b0;
    @(negedge clk) rst_n = 1'b1;
end



endmodule