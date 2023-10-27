`timescale 1ns/1ps

// basic module

module Universal_Gate(out, a, b);
input a, b;
output out;
wire not_b;

not n1(not_b, b);
and a1(out, a, not_b);
endmodule

module AND(a, b, out);
input a, b;
output out;
wire temp;

Universal_Gate u1(temp, a, b);
Universal_Gate u2(out, a, temp);
endmodule

module NOT(a, out);
input a;
output out;

Universal_Gate u1(out, 1'b1, a);
endmodule

module NAND(a, b, out);
input a, b;
output out;
wire temp;

AND u1(a, b, temp);
NOT u2(temp, out);
endmodule

module OR(a, b, out);
input a, b;
output out;
wire temp1, temp2;

NAND n1(a, a, temp1);
NAND n2(b, b, temp2);
NAND n3(temp1, temp2, out);
endmodule

module NOR(a, b, out);
input a, b;
output out;
wire temp1, temp2, temp3;

NAND n1(a, a, temp1);
NAND n2(b, b, temp2);
NAND n3(temp1, temp2, temp3);
NAND n4(temp3, temp3, out);
endmodule

module XOR(a, b, out);
input a, b;
output out;
wire temp1, temp2, temp3;

NAND n1(a, b, temp1);
NAND n2(temp1, a ,temp2);
NAND n3(temp1, b ,temp3);
NAND n4(temp2, temp3, out);
endmodule

module XNOR(a, b, out);
input a, b;
output out;
wire temp1, temp2, temp3, temp4;

NAND n1(a, a, temp1);
NAND n2(b, b, temp2);
NAND n3(temp1, temp2, temp3);
NAND n4(a, b, temp4);
NAND n5(temp3, temp4, out);
endmodule


// MUX, and main modules

module Mux_2x1_4bit(in1, in2, sel, f);
input [3:0] in1, in2;
input sel;
output [3:0] f;

wire nsel, w1, w2, w3, w4, w5, w6, w7, w8;
NOT n1(sel, nsel);
AND a1(nsel, in1[0], w1);
AND a2(sel, in2[0], w2);
OR o1(w2, w1, f[0]);

AND a3(nsel, in1[1], w3);
AND a4(sel, in2[1], w4);
OR o2(w4, w3, f[1]);

AND a5(nsel, in1[2], w5);
AND a6(sel, in2[2], w6);
OR o3(w6, w5, f[2]);

AND a7(nsel, in1[3], w7);
AND a8(sel, in2[3], w8);
OR o4(w8, w7, f[3]);

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

module MUX_8x1_4bit(t1, t2, t3, t4, t5, t6, t7, t8, sel, rd);
input [3:0] t1, t2, t3, t4, t5, t6, t7, t8;
input [2:0] sel;
output [3:0] rd;

wire [3:0] w1, w2;

Mux_4x1_4bit u1(t1, t2, t3, t4, sel[1:0], w1);
Mux_4x1_4bit u2(t5, t6, t7, t8, sel[1:0], w2);
Mux_2x1_4bit u3(w1, w2, sel[2], rd);
endmodule

module Decode_And_Execute(rs, rt, sel, rd);
input [4-1:0] rs, rt;
input [3-1:0] sel;
output [4-1:0] rd;

wire [3:0] t1, t2, t3, t4, t5, t6, t7, t8;

SUB m1(rs, rt, t1);
ADD m2(rs, rt, t2);
BW_OR m3(rs, rt, t3);
BW_AND m4(rs, rt, t4);
R_Shift m5(rt, t5);
L_Shift m6(rs, t6);
Compare_LS m7(rs, rt, t7);
Compare_EQ m8(rs, rt, t8);

MUX_8x1_4bit D1(t1, t2, t3, t4, t5, t6, t7, t8, sel, rd);

endmodule


// Functional mudule

module BW_OR(rs, rt, rd);
input [3:0] rs, rt;
output [3:0] rd;

OR o1(rs[0], rt[0], rd[0]);
OR o2(rs[1], rt[1], rd[1]);
OR o3(rs[2], rt[2], rd[2]);
OR o4(rs[3], rt[3], rd[3]);
endmodule

module BW_AND(rs, rt, rd);
input [3:0] rs, rt;
output [3:0] rd;

AND a1(rs[0], rt[0], rd[0]);
AND a2(rs[1], rt[1], rd[1]);
AND a3(rs[2], rt[2], rd[2]);
AND a4(rs[3], rt[3], rd[3]);
endmodule

module R_Shift(rt, rd);
input [3:0] rt;
output [3:0] rd;

AND a1(rt[1], 1'b1, rd[0]);
AND a2(rt[2], 1'b1, rd[1]);
AND a3(rt[3], 1'b1, rd[2]);
AND a4(rt[3], 1'b1, rd[3]);
endmodule

module L_Shift(rs, rd);
input [3:0] rs;
output [3:0] rd;

AND a1(rs[3], 1'b1, rd[0]);
AND a2(rs[0], 1'b1, rd[1]);
AND a3(rs[1], 1'b1, rd[2]);
AND a4(rs[2], 1'b1, rd[3]);
endmodule

module Majority(a, b, c, out);
input a, b, c;
output out;
wire w1, w2, w3, w4;

AND a1(a, b, w1);
AND a2(a, c, w2);
AND a3(b, c, w3);
OR o1(w1, w2, w4);
OR o2(w3, w4, out);

endmodule

module Full_Adder (a, b, cin, cout, sum);
input a, b, cin;
output cout, sum;
wire w1, w2, w3;
wire not_cin, not_cout;

Majority m1(a, b, cin, w1);
AND a1(w1, 1'b1, cout);
NOT n1(cin, not_cin);
NOT n2(w1, not_cout);
Majority m2(a, b, not_cin, w2);
Majority m3(not_cout, cin, w2, sum);

endmodule

module Ripple_Carry_Adder_4bit(a, b, cin, cout, sum);
input [3:0] a, b;
input cin;
output cout;
output [3:0] sum;

wire c1, c2, c3, c4;

Full_Adder f1(a[0], b[0], cin, c1, sum[0]);
Full_Adder f2(a[1], b[1], c1, c2, sum[1]);
Full_Adder f3(a[2], b[2], c2, c3, sum[2]);
Full_Adder f4(a[3], b[3], c3, c4, sum[3]);
    
endmodule

module ADD(rs, rt, rd);
input [3:0] rs, rt;
output [3:0] rd;
wire cout;

Ripple_Carry_Adder_4bit r1(rs, rt, 1'b0, cout, rd);
endmodule

module SUB(rs, rt, rd);
input [3:0] rs, rt;
output [3:0] rd;
wire [3:0] temp1, temp2;
wire t1, t2, t3, t4;

NOT n1(rt[0], temp1[0]);
NOT n2(rt[1], temp1[1]);
NOT n3(rt[2], temp1[2]);
NOT n4(rt[3], temp1[3]);
ADD a1(temp1, 4'b0001, temp2);

ADD a2(rs, temp2, rd);
endmodule

module Compare_EQ(rs, rt, rd);
input [3:0] rs, rt;
output [3:0] rd;

wire n_s0, n_s1, n_s2, n_s3;
wire n_t0, n_t1, n_t2, n_t3;
wire w1, w2, w3, w4, w5, w6, w7, w8;
wire t1,t2,t3,t4,t5,t6,t7;

NOT n1(rs[0], n_s0);
NOT n2(rs[1], n_s1);
NOT n3(rs[2], n_s2);
NOT n4(rs[3], n_s3);
NOT n5(rt[0], n_t0);
NOT n6(rt[1], n_t1);
NOT n7(rt[2], n_t2);
NOT n8(rt[3], n_t3);

// calculate XNOR
AND T1(rs[0], rt[0], w1);
AND T2(n_s0, n_t0, w2);
OR T3(w1, w2, t1);
AND T4(rs[1], rt[1], w3);
AND T5(n_s1, n_t1, w4);
OR T6(w3, w4, t2);
AND T7(rs[2], rt[2], w5);
AND T8(n_s2, n_t2, w6);
OR T9(w5, w6, t3);
AND T10(rs[3], rt[3], w7);
AND T11(n_s3, n_t3, w8);
OR T12(w7, w8, t4);


AND a1(t1, t2, t5);
AND a2(t3, t4, t6);
AND a3(t5, t6, rd[0]);

AND a4(1'b1, 1'b1, rd[1]);
AND a5(1'b1, 1'b1, rd[2]);
AND a6(1'b1, 1'b1, rd[3]);
endmodule

module Compare_LS(rs, rt, rd);
input [3:0] rs, rt;
output [3:0] rd;

wire not_a0, not_a1, not_a2, not_a3;
wire a1_xnor_b1, a2_xnor_b2, a3_xnor_b3;
wire t1, t2, t3, t4, t5, t6, t7;
wire w3, w4, w5, w6, w7, w8;
wire n_s1, n_s2, n_s3, n_t1, n_t2, n_t3;
wire temp1, temp2, temp3, temp4, temp5, temp6;

NOT n1(rs[0], not_a0);
NOT n2(rs[1], not_a1);
NOT n3(rs[2], not_a2);
NOT n4(rs[3], not_a3);

NOT n5(rs[1], n_s1);
NOT n6(rs[2], n_s2);
NOT n7(rs[3], n_s3);
NOT n8(rt[1], n_t1);
NOT n9(rt[2], n_t2);
NOT n10(rt[3], n_t3);

AND T4(rs[1], rt[1], w3);
AND T5(n_s1, n_t1, w4);
OR T6(w3, w4, a1_xnor_b1);
AND T7(rs[2], rt[2], w5);
AND T8(n_s2, n_t2, w6);
OR T9(w5, w6, a2_xnor_b2);
AND T10(rs[3], rt[3], w7);
AND T11(n_s3, n_t3, w8);
OR T12(w7, w8, a3_xnor_b3);

AND a1(not_a3, rt[3], temp1);
AND a2(not_a2, rt[2], t1);
AND a3(a3_xnor_b3, t1, temp2);
AND a4(not_a1, rt[1], t2);
AND a5(t2, a3_xnor_b3, t3);
AND a6(t3, a2_xnor_b2, temp3);
AND a7(not_a0, rt[0], t4);
AND a8(t4, a3_xnor_b3, t5);
AND a9(t5, a2_xnor_b2, t6);
AND a10(t6, a1_xnor_b1, temp4);

OR o1(temp1, temp2, temp5);
OR o2(temp3, temp4, temp6);
OR o3(temp5, temp6, rd[0]);

AND a11(1'b1, 1'b1, rd[1]);
AND a12(1'b0, 1'b0, rd[2]);
AND a13(1'b1, 1'b1, rd[3]);

endmodule
