`timescale 1ns/1ps
module test_Crossbar_2x2_4bit;
reg [3:0] in1, in2;
reg control;
wire [3:0] out1, out2;

Crossbar_2x2_4bit c1(in1, in2, control, out1, out2);

initial begin
    in1 = 4'b0000;
    in2 = 4'b1111;
    control = 1'b1;
    #10 
    $display("out1 = %b, out2 = %b, control = %b", out1, out2, control);
    if(out1 == 4'b1111 && out2 == 4'b0000)
        $display("correct!");
    else
        $display("false!");

    control = 1'b0;
    #10
    $display("out1 = %b, out2 = %b, control = %b", out1, out2, control);
    if(out1 == 4'b0000 && out2 == 4'b1111)
        $display("correct!");
    else
        $display("false!");

end

endmodule