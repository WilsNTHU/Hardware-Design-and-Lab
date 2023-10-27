`timescale 1ns/1ps

module Parameterized_Ping_Pong_Counter_test;
reg clk, rst_n, enable, flip;
reg [3:0] max, min;
wire direction;
wire [3:0] out;

always #5 clk = !clk;

// Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
Parameterized_Ping_Pong_Counter P1(clk, rst_n, enable, flip, max, min, direction, out);

/* testcase 1 An example waveform where flip is set to 1'b0 
    and enable is set to 1'b1 
    In this example min = 4'd0 and max = 4'd4 */

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    enable = 1'b1;
    flip = 1'b0;
    min = 4'd0;
    max = 4'd4;

    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
end  


/*testcase 2 An example waveform where there is one flip and enable is set  to 1'b1 
In this example min = 4’d0 and max = 4'd4 */
/*
initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    enable = 1'b1;
    flip = 1'b0;
    min = 4'd0;
    max = 4'd4;

    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        flip = 1'b1;
    @(negedge clk)
        flip = 1'b0;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
end */

/* testcase 3 An example waveform where there are two flips and enable is 
set to 1'b1 
In this example min = 4’d0 and max = 4'd4 */
/*
initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    enable = 1'b1;
    flip = 1'b0;
    min = 4'd0;
    max = 4'd4;

    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        flip = 1'b1;
    @(negedge clk)
        flip = 1'b0;
    @(negedge clk)
        flip = 1'b1;
    @(negedge clk)
        flip = 1'b0;
    @(negedge clk)
        rst_n = 1'b1;
    @(negedge clk)
        rst_n = 1'b1;
end */
endmodule



