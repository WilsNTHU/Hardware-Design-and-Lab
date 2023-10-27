`timescale 1ns/1ps
module test_Multiplier_4bit;
reg [3:0] a, b;
wire [7:0] p;

Multiplier_4bit M1(a, b, p);

initial begin

    a = 8'b0101;
    b = 8'b0011;
    #10
    $display("%b MUL %b = %b", a, b, p);

    a = 8'b0010;
    b = 8'b0100;
    #10
    $display("%b MUL %b = %b", a, b, p);
    
    a = 8'b0001;
    b = 8'b1111;
    #10
    $display("%b MUl %b = %b", a, b, p);
    
end

endmodule