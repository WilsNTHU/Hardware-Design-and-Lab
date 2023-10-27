`timescale 1ns/1ps
module test_Decode_And_Execute;
reg [10:0] SW;
wire [6:0] rd;
wire [3:0] digit;

FPGA_7segment D1(SW, rd, digit);

initial begin
    SW = 11'b00000001000;
    #10
    SW = 11'b00000011000;
    #10
    SW = 11'b00000101000;

end

endmodule