`timescale 1ns/1ps

module Dmux_1x2_4bit(in, a, b, sel);
input [3:0] in;
input sel;
output [3:0] a, b;

wire not_sel;
not(not_sel, sel);
and(a[0], not_sel, in[0]);
and(b[0], sel, in[0]);
and(a[1], not_sel, in[1]);
and(b[1], sel, in[1]);
and(a[2], not_sel, in[2]);
and(b[2], sel, in[2]);
and(a[3], not_sel, in[3]);
and(b[3], sel, in[3]);

endmodule

module Dmux_1x4_4bit(in, a, b, c, d, sel);
input [4-1:0] in;
input [2-1:0] sel;
output [4-1:0] a, b, c, d;

wire w1, w2;

Dmux_1x2_4bit d1(in, w1, w2, sel[1]);
Dmux_1x2_4bit d2(w1, a, b, sel[0]);
Dmux_1x2_4bit d3(w2, c, d, sel[0]);

endmodule
