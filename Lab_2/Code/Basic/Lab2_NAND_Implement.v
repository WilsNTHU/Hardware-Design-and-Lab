`timescale 1ns/1ps

module NOT(a, out);
input a;
output out;

nand n1(out, a, a);
endmodule

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

module NOR(a, b, out);
input a, b;
output out;
wire temp1, temp2, temp3;

nand n1(temp1, a, a);
nand n2(temp2, b, b);
nand n3(temp3, temp1, temp2);
nand n4(out, temp3, temp3);
endmodule

module XOR(a, b, out);
input a, b;
output out;
wire temp1, temp2, temp3;

nand n1(temp1, a, b);
nand n2(temp2, temp1, a);
nand n3(temp3, b, temp1);
nand n4(out, temp2, temp3);
endmodule

module XNOR(a, b, out);
input a, b;
output out;
wire temp1, temp2, temp3, temp4;

nand n1(temp1, a, a);
nand n2(temp2, b, b);
nand n3(temp3, temp1, temp2);
nand n4(temp4, a, b);
nand n5(out, temp3, temp4);
endmodule

module MUX_2x1(a, b, sel, out);
input a, b, sel;
output out;

wire w1, w2, w3;
nand n1(w1, sel, sel);
nand n2(w2, a, w1);
nand n3(w3, b, sel);
nand n4(out, w2, w3);
endmodule


// 8x1 MUX
module NAND_Implement (a, b, sel, out);
input a, b;
input [3-1:0] sel;
output out;

wire t1, t2, t3, t4, t5, t6, t7;
wire w1,w2,w3,w4,w5,w6;

nand m1(t1, a, b);
AND m2(a, b, t2);
OR m3(a, b, t3);
NOR m4(a, b, t4);
XOR m5(a, b, t5);
XNOR m6(a, b, t6);
NOT m7(a, t7);

MUX_2x1 s1(t1, t2, sel[0], w1);
MUX_2x1 s2(t3, t4, sel[0], w2);
MUX_2x1 s3(t5, t6, sel[0], w3);
MUX_2x1 s4(t7, t7, sel[0], w4);
MUX_2x1 s5(w1, w2, sel[1], w5);
MUX_2x1 s6(w3, w4, sel[1], w6);
MUX_2x1 s7(w5, w6, sel[2], out);

endmodule
