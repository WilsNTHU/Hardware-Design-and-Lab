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

module Ripple_Carry_Adder(a, b, cin, cout, sum);
input [8-1:0] a, b;
input cin;
output cout;
output [8-1:0] sum;

wire c1, c2, c3, c4 ,c5, c6, c7;

Full_Adder f1(a[0], b[0], cin, c1, sum[0]);
Full_Adder f2(a[1], b[1], c1, c2, sum[1]);
Full_Adder f3(a[2], b[2], c2, c3, sum[2]);
Full_Adder f4(a[3], b[3], c3, c4, sum[3]);
Full_Adder f5(a[4], b[4], c4, c5, sum[4]);
Full_Adder f6(a[5], b[5], c5, c6, sum[5]);
Full_Adder f7(a[6], b[6], c6, c7, sum[6]);
Full_Adder f8(a[7], b[7], c7, cout, sum[7]);
    
endmodule
