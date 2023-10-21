`timescale 1ns/1ps

module Mux_2x1_4bit(in1, in2, sel, f);
input [3:0] in1, in2;
input sel;
output [3:0] f;

wire nsel, w1, w2, w3, w4, w5, w6, w7, w8;
not(nsel, sel);
and(w1, in1[0], nsel);
and(w2, in2[0], sel);
or(f[0], w1, w2);

and(w3, in1[1], nsel);
and(w4, in2[1], sel);
or(f[1], w3, w4);

and(w5, in1[2], nsel);
and(w6, in2[2], sel);
or(f[2], w5, w6);

and(w7, in1[3], nsel);
and(w8, in2[3], sel);
or(f[3], w7, w8);

endmodule


module Mux_4x1_4bit(a, b, c, d, sel, f);
input [4-1:0] a, b, c, d;
input [2-1:0] sel;
output [4-1:0] f;

wire [3:0] temp1, temp2;

Mux_2x1_4bit M1(a, b, sel[0], temp1);
Mux_2x1_4bit M2(c, d, sel[0], temp2);
Mux_2x1_4bit M3(temp1, temp2, sel[1], f);

endmodule
