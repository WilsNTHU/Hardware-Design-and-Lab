`timescale 1ns/1ps

module FIFO_test_module;
reg clk = 1'b1;
reg rst_n, wen, ren;
reg [7:0] din;
wire [7:0] dout;
wire error;

// specify duration of a clock cycle.
parameter cyc = 10;

// generate clock.
always#(cyc/2)clk = !clk;

// FIFO_8(clk, rst_n, wen, ren, din, dout, error);
FIFO_8 F1(clk, rst_n, wen, ren, din, dout, error);

initial begin
    @(negedge clk)
        rst_n = 1'b0;
    @(negedge clk)
        rst_n = 1'b1;
        wen = 1'b1;
        ren = 1'b0;
        din = 8'b00001111;
    @(negedge clk)
        din = 8'b11111111;
    @(negedge clk)
        din = 8'b00000011;
    @(negedge clk)
        din = 8'b00000101;
    @(negedge clk)
        din = 8'b11000001;
    @(negedge clk)
        din = 8'b00010001;
    @(negedge clk)
        din = 8'b01110001;
    @(negedge clk)
        din = 8'b00001101;
    @(negedge clk)
        wen = 1'b0;
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b0;
        wen = 1'b1;
        din = 8'b11110001;
    @(negedge clk)
        din = 8'b01111101;
    @(negedge clk)
        wen = 1'b0;
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b1;
    @(negedge clk)
        ren = 1'b1;

end

endmodule
