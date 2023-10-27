`timescale 1ns/1ps

module Ping_Pong_Counter_t;
reg clk = 1'b1;
reg rst_n, enable;
wire direction;
wire [3:0] out;


// specify duration of a clock cycle.
parameter cyc = 10;
integer  i;

// generate clock.
always#(cyc/2)clk = !clk;

// Ping_Pong_Counter (clk, rst_n, enable, direction, out);
Ping_Pong_Counter P1(clk, rst_n, enable, direction, out);

initial begin
	@(negedge clk)
        enable = 1'b0;
        $display("out : %d, direction: %b", out, direction);
    @(negedge clk)
        rst_n = 1'b0;
        $display("out : %d, direction: %b", out, direction);
    @(negedge clk)
        rst_n = 1'b1;
        $display("out : %d, direction: %b", out, direction);
    @(negedge clk)
        $display("out : %d, direction: %b", out, direction);
        enable = 1'b1;
    @(negedge clk)
        enable = 1'b0;
        $display("out : %d, direction: %b", out, direction);
    @(negedge clk)
        enable = 1'b0;
        $display("out : %d, direction: %b", out, direction);
    @(negedge clk)
        enable = 1'b0;
        $display("out : %d, direction: %b", out, direction);
    @(negedge clk)
        enable = 1'b1;
        $display("out : %d, direction: %b", out, direction);
    
    for (i = 0; i <= 30; i = i+1) begin
        @(negedge clk)
            $display("out : %d, direction: %b", out, direction);
    end
end

endmodule
