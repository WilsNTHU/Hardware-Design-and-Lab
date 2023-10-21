`timescale 1ns/1ps

module AND(a, b, out);
input a, b;
output out;
wire temp;

nand n1(temp, a, b);
nand n2(out, temp, temp);
endmodule

module OR(a, b, out);
input a, b;
output out;
wire temp1, temp2;

nand n1(temp1, a, a);
nand n2(temp2, b, b);
nand n3(out, temp1, temp2);
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

module Full_Adder (a, b, cin, sum, p, g);
input a, b, cin;
output sum, p, g;
wire w1, w2, w3;
wire not_cin, not_cout;

OR T1(a, b, p);
AND T2(a, b, g);

Majority m1(a, b, cin, w1);
AND a1(w1, 1'b1, cout);
NOT n1(cin, not_cin);
NOT n2(w1, not_cout);
Majority m2(a, b, not_cin, w2);
Majority m3(not_cout, cin, w2, sum);

endmodule

module Carry_Look_Ahead_Generator_4bit(p0, p1, p2, p3, g0, g1, g2, g3, c0, c1, c2, c3, PG, GG);
input p0, p1, p2, p3, g0, g1, g2, g3, c0;
output c1, c2, c3, PG, GG;

// calculate c1~c3

wire w1,w2,w3,w4,w5,w6;
AND T1(p0, c0, w1);
OR T2(w1, g0, c1);
AND T3(p1, c1, w2);
OR T4(w2, g1, c2);
AND T5(p2, c2, w3);
OR T6(w3, g2, c3);

// calculate PG, GG

wire t1,t2,t3,t4,t5,t6,t7,t8;
AND A1(g0, p1, t1);
AND A2(t1, p2, t2);
AND A3(t2, p3, t3);
OR A4(t3, g1, t4);
AND A5(t4, p2, t5);
AND A6(t5, p3, t6);
OR A7(t6, g2, t7);
AND A8(t7, p3, t8);
OR A9(t8, g3, GG);

wire t9, t10;
AND B1(p0, p1, t9);
AND B2(t9, p2, t10);
AND B3(t10, p3, PG);

endmodule

module Carry_Look_Ahead_Generator_2bit(PG1, PG2, GG0, GG1, cin, c4, c8);
input PG1, PG2, GG0, GG1, cin;
output c4, c8;

wire temp;
wire t1,t2,t3,t4,t5,t6;

AND a1(PG1, cin, t1);
OR o1(t1, GG0, temp);
AND a2(temp, 1'b1, c4);
AND a3(PG2, temp, t2);
OR o2(t2, GG1, c8);

endmodule

module Carry_Look_Ahead_Adder_8bit(a, b, c0, s, c8);
input [8-1:0] a, b;
input c0;
output [8-1:0] s;
output c8;

wire p0, p1, p2, p3, p4, p5, p6, p7;
wire g0, g1, g2, g3, g4, g5, g6, g7;
wire PG0, PG1, GG0, GG1;

Full_Adder A0(a[0], b[0], c0, s[0], p0, g0);
Full_Adder A1(a[1], b[1], c1, s[1], p1, g1);
Full_Adder A2(a[2], b[2], c2, s[2], p2, g2);
Full_Adder A3(a[3], b[3], c3, s[3], p3, g3);
Carry_Look_Ahead_Generator_4bit T1(p0,p1,p2,p3,g0,g1,g2,g3,c0,c1,c2,c3,PG0,GG0);

Full_Adder A4(a[4], b[4], c4, s[4], p4, g4);
Full_Adder A5(a[5], b[5], c5, s[5], p5, g5);
Full_Adder A6(a[6], b[6], c6, s[6], p6, g6);
Full_Adder A7(a[7], b[7], c7, s[7], p7, g7);
Carry_Look_Ahead_Generator_4bit T2(p4,p5,p6,p7,g4,g5,g6,g7,c4,c5,c6,c7,PG1,GG1);

Carry_Look_Ahead_Generator_2bit T3(PG0,PG1,GG0,GG1,c0,c4,c8);


endmodule
