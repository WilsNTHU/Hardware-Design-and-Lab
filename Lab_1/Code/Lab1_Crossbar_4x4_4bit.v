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

module Crossbar_2x2_4bit(in1, in2, control, out1, out2);
input [4-1:0] in1, in2;
input control;
output [4-1:0] out1, out2;

wire [3:0] w1, w2, w3, w4;
wire not_c;

not(not_c, control);
Dmux_1x2_4bit d1(in1, w1, w2, control);
Dmux_1x2_4bit d2(in2, w3, w4, not_c);
Mux_2x1_4bit m1(w1, w3, control, out1);
Mux_2x1_4bit m2(w2, w4, not_c, out2);

endmodule

module Crossbar_4x4_4bit(in1, in2, in3, in4, out1, out2, out3, out4, control);
input [4-1:0] in1, in2, in3, in4;
input [5-1:0] control;
output [4-1:0] out1, out2, out3, out4;

wire [3:0] w1, w2, w3, w4, w5, w6;

Crossbar_2x2_4bit c1(in1, in2, control[0], w1, w2);
Crossbar_2x2_4bit c2(in3, in4, control[3], w3, w4);
Crossbar_2x2_4bit c3(w2, w3, control[2], w5, w6);
Crossbar_2x2_4bit c4(w1, w5, control[1], out1, out2);
Crossbar_2x2_4bit c5(w6, w4, control[4], out3, out4);

endmodule
