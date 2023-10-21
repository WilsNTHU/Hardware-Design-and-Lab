`timescale 1ns/1ps
module test_Crossbar_4x4_4bit;
reg [3:0] in1, in2, in3, in4;
reg [4:0] control;
wire [3:0] out1, out2, out3, out4;

Crossbar_4x4_4bit c1(in1, in2, in3, in4, out1, out2, out3, out4, control);

initial begin
    in1 = 4'b0001;
    in2 = 4'b0010;
    in3 = 4'b0100;
    in4 = 4'b1000;
    control = 5'b00000;

    $display("following answer using route 1!");

    //case 1 xxx00
    control = 5'b11100;
    #10 
    $display("in1 = %b, out1 = %b, control = %b", in1, out1, control);
    if(in1 == out1)
        $display("correct!");
    else
        $display("false!");

    //case 2 xx001
    control = 5'b11001;
    #10 
    $display("in1 = %b, out2 = %b, control = %b", in1, out2, control);
    if(in1 == out2)
        $display("correct!");
    else
        $display("false!");

    //case 3 0x1x1
    control = 5'b01111;
    #10 
    $display("in1 = %b, out3 = %b, control = %b", in1, out3, control);
    if(in1 == out3)
        $display("correct!");
    else
        $display("false!");

    //case 4 1x1x1
    control = 5'b11111;
    #10 
    $display("in1 = %b, out4 = %b, control = %b", in1, out4, control);
    if(in1 == out4)
        $display("correct!");
    else
        $display("false!");
    
    //case 5 xxx01
    control = 5'b11101;
    #10 
    $display("in2 = %b, out1 = %b, control = %b", in2, out1, control);
    if(in2 == out1)
        $display("correct!");
    else
        $display("false!");

    //case 6 xxx11
    control = 5'b11111;
    #10 
    $display("in2 = %b, out2 = %b, control = %b", in2, out2, control);
    if(in2 == out2)
        $display("correct!");
    else
        $display("false!");

    //case 7 0x1x0
    control = 5'b01110;
    #10 
    $display("in2 = %b, out3 = %b, control = %b", in2, out3, control);
    if(in2 == out3)
        $display("correct!");
    else
        $display("false!");

    //case 8 1x1x0
    control = 5'b11110;
    #10 
    $display("in2 = %b, out4 = %b, control = %b", in2, out4, control);
    if(in2 == out4)
        $display("correct!");
    else
        $display("false!");

    //case 9 x011x
    control = 5'b10111;
    #10 
    $display("in3 = %b, out1 = %b, control = %b", in3, out1, control);
    if(in3 == out1)
        $display("correct!");
    else
        $display("false!");

    //case 10 x010x
    control = 5'b10101;
    #10 
    $display("in3 = %b, out2 = %b, control = %b", in3, out2, control);
    if(in3 == out2)
        $display("correct!");
    else
        $display("false!");

    //case 11 000xx
    control = 5'b00011;
    #10 
    $display("in3 = %b, out3 = %b, control = %b", in3, out3, control);
    if(in3 == out3)
        $display("correct!");
    else
        $display("false!");

    //case 12 01xxx
    control = 5'b01111;
    #10 
    $display("in3 = %b, out4 = %b, control = %b", in3, out4, control);
    if(in3 == out4)
        $display("correct!");
    else
        $display("false!");

    //case 13 x111x
    control = 5'b11111;
    #10 
    $display("in4 = %b, out1 = %b, control = %b", in4, out1, control);
    if(in4 == out1)
        $display("correct!");
    else
        $display("false!");

    //case 14 x110x
    control = 5'b11101;
    #10 
    $display("in4 = %b, out2 = %b, control = %b", in4, out2, control);
    if(in4 == out2)
        $display("correct!");
    else
        $display("false!");

    //case 15 10xxx
    control = 5'b10111;
    #10 
    $display("in4 = %b, out3 = %b, control = %b", in4, out3, control);
    if(in4 == out3)
        $display("correct!");
    else
        $display("false!");

    //case 16 00xxx
    control = 5'b00111;
    #10 
    $display("in4 = %b, out4 = %b, control = %b", in4, out4, control);
    if(in4 == out4)
        $display("correct!");
    else
        $display("false!");



    $display("following using route 2!");

    //case 1 xx011
    control = 5'b11011;
    #10 
    $display("in1 = %b, out1 = %b, control = %b", in1, out1, control);
    if(in1 == out1)
        $display("correct!");
    else
        $display("false!");

    //case 2 xxx10
    control = 5'b11110;
    #10 
    $display("in1 = %b, out2 = %b, control = %b", in1, out2, control);
    if(in1 == out2)
        $display("correct!");
    else
        $display("false!");

    //case 3 xx010
    control = 5'b11010;
    #10 
    $display("in2 = %b, out1 = %b, control = %b", in2, out1, control);
    if(in2 == out1)
        $display("correct!");
    else
        $display("false!");

    //case 4 xx000 
    control = 5'b11000;
    #10 
    $display("in2 = %b, out2 = %b, control = %b", in2, out2, control);
    if(in2 == out2)
        $display("correct!");
    else
        $display("false!");

    //case 5 11xxx
    control = 5'b11111;
    #10 
    $display("in3 = %b, out3 = %b, control = %b", in3, out3, control);
    if(in3 == out3)
        $display("correct!");
    else
        $display("false!");

    //case 6 100xx
    control = 5'b10011;
    #10 
    $display("in3 = %b, out4 = %b, control = %b", in3, out4, control);
    if(in3 == out4)
        $display("correct!");
    else
        $display("false!");

    //case 7 010xx
    control = 5'b01011;
    #10 
    $display("in4 = %b, out3 = %b, control = %b", in4, out3, control);
    if(in4 == out3)
        $display("correct!");
    else
        $display("false!");

    //case 8 110xx
    control = 5'b11011;
    #10 
    $display("in4 = %b, out4 = %b, control = %b", in4, out4, control);
    if(in4 == out4)
        $display("correct!");
    else
        $display("false!");
    

end

endmodule