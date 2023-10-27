`timescale 1ns/1ps

module Multi_Bank_Memory_test;
reg clk = 1'b1;
reg ren, wen;
reg [11-1:0] waddr;
reg [11-1:0] raddr;
reg [8-1:0] din;
wire [8-1:0] dout;

Multi_Bank_Memory M1(clk, ren, wen, waddr, raddr, din, dout);

parameter cyc = 10;

always#(cyc/2)clk = !clk;

initial begin
        @(negedge clk)
        ren = 0;
        wen = 0;
        waddr = 11'd60;
        raddr = 11'd60;    
        
        @(negedge clk)
        wen = 1'b1;
        din = 8'd66;

        @(negedge clk)
        // Test read operation
        ren = 1'b1;

        @(negedge clk)
        ren = 1'b0;

        @(negedge clk)
        waddr = 11'd100;
        raddr = 11'd100;
        din = 8'd120;
        wen = 1'b1;

        @(negedge clk)
        wen = 1'b0;
        ren = 1'b1;

        @(negedge clk)


        $finish;
    end



endmodule