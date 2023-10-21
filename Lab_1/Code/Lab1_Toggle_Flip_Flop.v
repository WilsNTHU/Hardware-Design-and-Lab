`timescale 1ns/1ps

module D_Latch(e, d, q);
input e;
input d;
output q;

wire n1, w1, w2, w3;

not(n1, d);
nand(w1, d, e);
nand(w2, e, n1);
nand(w3, q, w2);
nand(q, w1, w3);

endmodule

module D_Flip_Flop(clk, d, q);
input clk;
input d;
output q;

wire w1, nclk;

not(nclk, clk);
D_Latch d1(nclk, d, w1);
D_Latch d2(clk, w1, q);


endmodule

module XOR_module(in1, in2, out);
input in1, in2;
output out;

wire n_in1, n_in2, w1, w2;

not (n_in1, in1);
not (n_in2, in2);
and (w1, n_in1, in2);
and (w2, in1, n_in2);
or (out, w1, w2);

endmodule

module Toggle_Flip_Flop(clk, q, t, rst_n);
input clk;
input t;
input rst_n;
output q;

wire w1, w2;

XOR_module x1(q, t, w1);
and(w2, w1, rst_n);
D_Flip_Flop d1(clk, w2, q);


endmodule