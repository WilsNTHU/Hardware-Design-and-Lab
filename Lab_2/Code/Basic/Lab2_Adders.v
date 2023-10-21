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

module Half_Adder(a, b, cout, sum);
input a, b;
output cout, sum;
wire not_a, not_b, w1, w2;

NOT n1(a, not_a);
NOT n2(b, not_b);
AND a1(a, not_b, w1);
AND a2(b, not_a, w2);
OR o1(w1, w2, sum);
AND a3(a, b, cout);
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

