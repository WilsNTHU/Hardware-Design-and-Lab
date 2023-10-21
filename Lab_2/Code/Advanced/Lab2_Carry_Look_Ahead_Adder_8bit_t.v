`timescale 1ns/1ps
module test_Carry_Look_Ahead_Adder;
reg [7:0] a, b;
reg cin;
wire [7:0] sum;
wire cout;

Carry_Look_Ahead_Adder_8bit M1(a, b, cin, sum, cout);

initial begin

    a = 8'b000101;
    b = 8'b00000010;
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