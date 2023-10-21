module Universal_Gate(out, a, b);
input a, b;
output out;
wire not_b;

not n1(not_b, b);
and a1(out, a, not_b);
endmodule