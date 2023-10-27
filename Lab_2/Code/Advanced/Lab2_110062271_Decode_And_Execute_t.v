`timescale 1ns/1ps
module test_Decode_And_Execute;
reg [3:0] rs, rt;
reg [2:0] sel;
wire [3:0] rd;

Decode_And_Execute D1(rs, rt, sel, rd);

initial begin
    rs = 4'b0101;
    rt = 4'b0010;
    
    sel = 3'b000;
    #10
    $display("%b SUB %b = %b, sel = %b", rs, rt, rd, sel);

    sel = 3'b001;
    #10
    $display("%b ADD %b = %b, sel = %b", rs, rt, rd, sel);

    sel = 3'b010;
    #10
    $display("%b BITWISE OR %b = %b, sel = %b", rs, rt, rd, sel);

    sel = 3'b011;
    #10
    $display("%b BITWISE AND %b = %b, sel = %b", rs, rt, rd, sel);

    sel = 3'b100;
    #10
    $display("%b RT ARI. RIGHT SHIFT = %b, sel = %b", rt, rd, sel);

    sel = 3'b101;
    #10
    $display("%b RS CIR. LEFT SHIFT = %b, sel = %b", rs, rd, sel);

    sel = 3'b110;
    #10
    $display("%b COMPARE LT %b = %b, sel = %b.....(case 1)", rs, rt, rd, sel);

    rs = 4'b0000;
    rt = 4'b1000;
    #10
    $display("%b COMPARE LT %b = %b, sel = %b.....(case 2)", rs, rt, rd, sel);

    sel = 3'b111;
    #10
    $display("%b COMPARE EQ %b = %b, sel = %b.....(case 1)", rs, rt, rd, sel);

    rs = 4'b0110;
    rt = 4'b0110;
    #10
    $display("%b COMPARE EQ %b = %b, sel = %b.....(case 2)", rs, rt, rd, sel);

end

endmodule