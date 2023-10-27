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

module NOT(a, out);
input a;
output out;

nand n1(out, a, a);
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

module Multiplier_4bit(a, b, p);
input [4-1:0] a, b;
output [8-1:0] p;

wire a0b0, a0b1, a0b2, a0b3, a1b0, a1b1, a1b2, a1b3, a2b0, a2b1, a2b2, 
     a2b3, a3b0, a3b1, a3b2, a3b3;

wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11;
wire t1,t2,t3,t4,t5,t6;

AND a1(a[0], b[0], p[0]);
AND a2(a[0], b[1], a0b1);
AND a3(a[0], b[2], a0b2);
AND a4(a[0], b[3], a0b3);
AND a5(a[1], b[0], a1b0);
AND a6(a[1], b[1], a1b1);
AND a7(a[1], b[2], a1b2);
AND a8(a[1], b[3], a1b3);
AND a9(a[2], b[0], a2b0);
AND a10(a[2], b[1], a2b1);
AND a11(a[2], b[2], a2b2);
AND a12(a[2], b[3], a2b3);
AND a13(a[3], b[0], a3b0);
AND a14(a[3], b[1], a3b1);
AND a15(a[3], b[2], a3b2);
AND a16(a[3], b[3], a3b3);

// Full_Adder (a, b, cin, cout, sum);

Full_Adder F1(a1b0, a0b1, 1'b0, c1, p[1]);
Full_Adder F2(a2b0, a1b1, c1, c2, t1);
Full_Adder F3(a3b0, a2b1, c2, c3, t2);
Full_Adder F4(a3b1, 1'b0, c3, c4, t3);
Full_Adder F5(t1, a0b2, 1'b0, c5, p[2]);
Full_Adder F6(t2, a1b2, c5, c6, t4);
Full_Adder F7(t3, a2b2, c6, c7, t5);
Full_Adder F8(c4, a3b2, c7, c8, t6);
Full_Adder F9(t4, a0b3, 1'b0, c9, p[3]);
Full_Adder F10(t5, a1b3, c9, c10, p[4]);
Full_Adder F11(t6, a2b3, c10, c11, p[5]);
Full_Adder F12(c8, a3b3, c11, p[7], p[6]);


endmodule
