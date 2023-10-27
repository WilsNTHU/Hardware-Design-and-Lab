`timescale 1ns/1ps
module test_Ripple_Carry_Adder;
reg [7:0] a, b;
reg cin;
wire [7:0] sum;
wire cout;

Ripple_Carry_Adder M1(a, b, cin, cout, sum);

initial begin

    a = 8'b01010101;
    b = 8'b00000001;
    cin = 1'b1;
    #10
    $display("%b ADD %b = %b, cin = %b, cout = %b", a, b, sum, cin, cout);

    
    a = 8'b11111110;
    b = 8'b00000001;
    cin = 1'b1;
    #10
    $display("%b ADD %b = %b, cin = %b, cout = %b", a, b, sum, cin, cout);
    
end

endmodule