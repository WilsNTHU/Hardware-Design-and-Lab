`timescale 1ns/1ps

module Fanout_4(in, out);
input in;
output [3:0] out;

wire in1;

not NOT1(in1, in);
not NOT2(out[0], in1);
not NOT3(out[1], in1);
not NOT4(out[2], in1);
not NOT5(out[3], in1);

endmodule