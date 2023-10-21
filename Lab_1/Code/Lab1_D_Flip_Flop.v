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


