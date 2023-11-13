`timescale 1ns/1ps

module Comparator_Array(din, in0, in1, in2, in3, in4, in5, in6, in7, in8, 
in9, in10, in11, in12, in13, in14, in15, out0, out1, out2, out3, out4, out5,
out6, out7, out8, out9, out10, out11, out12, out13, out14, out15);

input [7:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, 
in9, in10, in11, in12, in13, in14, in15;
input [7:0] din;
output out0, out1, out2, out3, out4, out5,out6, out7, out8, 
out9, out10, out11, out12, out13, out14, out15;

assign out0 = (in0 == din) ? 1'b1 : 1'b0;
assign out1 = (in1 == din) ? 1'b1 : 1'b0;
assign out2 = (in2 == din) ? 1'b1 : 1'b0;
assign out3 = (in3 == din) ? 1'b1 : 1'b0;
assign out4 = (in4 == din) ? 1'b1 : 1'b0;
assign out5 = (in5 == din) ? 1'b1 : 1'b0;
assign out6 = (in6 == din) ? 1'b1 : 1'b0;
assign out7 = (in7 == din) ? 1'b1 : 1'b0;
assign out8 = (in8 == din) ? 1'b1 : 1'b0;
assign out9 = (in9 == din) ? 1'b1 : 1'b0;
assign out10 = (in10 == din) ? 1'b1 : 1'b0;
assign out11 = (in11 == din) ? 1'b1 : 1'b0;
assign out12 = (in12 == din) ? 1'b1 : 1'b0;
assign out13 = (in13 == din) ? 1'b1 : 1'b0;
assign out14 = (in14 == din) ? 1'b1 : 1'b0;
assign out15 = (in15 == din) ? 1'b1 : 1'b0;

endmodule



module Priority(in0, in1, in2, in3, in4, in5, in6, in7, in8, 
in9, in10, in11, in12, in13, in14, in15, dout, signal);

input in0, in1, in2, in3, in4, in5, in6, in7, in8, 
in9, in10, in11, in12, in13, in14, in15;
output [3:0] dout;
output signal;

assign dout = (in15 == 1'b1) ? 4'b1111:
              (in14 == 1'b1) ? 4'b1110:
              (in13 == 1'b1) ? 4'b1101:
              (in12 == 1'b1) ? 4'b1100:
              (in11 == 1'b1) ? 4'b1011:
              (in10 == 1'b1) ? 4'b1010:
              (in9 == 1'b1) ? 4'b1001:
              (in8 == 1'b1) ? 4'b1000:
              (in7 == 1'b1) ? 4'b0111:
              (in6 == 1'b1) ? 4'b0110:
              (in5 == 1'b1) ? 4'b0101:
              (in4 == 1'b1) ? 4'b0100:
              (in3 == 1'b1) ? 4'b0011:
              (in2 == 1'b1) ? 4'b0010:
              (in1 == 1'b1) ? 4'b0001:
              (in0 == 1'b1) ? 4'b0000:
              4'b0000; 

assign signal = in0 | in1 | in2 | in3 | in4 | in5 | in6 | in7 | in8 | 
in9 | in10 | in11 | in12 | in13 | in14 | in15;

endmodule



module Content_Addressable_Memory(clk, wen, ren, din, addr, dout, hit);
input clk;
input wen, ren;
input [7:0] din;
input [3:0] addr;
output [3:0] dout;
output reg hit;

reg [3:0] dout;

wire [3:0] out_temp;
wire signal;
reg [7:0] CAM [15:0];

wire[3:0] in0, in1, in2, in3, in4, in5,
in6, in7, in8, in9, in10, in11, in12, in13, in14, in15;

wire [3:0] out0, out1, out2, out3, out4, out5,
out6, out7, out8, out9, out10, out11, out12, out13, out14, out15;

// Comparator_Array(in_data, din, dout);
Comparator_Array C1(din, 
CAM[0], CAM[1], CAM[2], CAM[3], CAM[4], CAM[5], CAM[6], CAM[7], CAM[8], CAM[9], CAM[10], CAM[11], CAM[12], CAM[13], CAM[14], CAM[15], 
out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15);

//Priority(in0, in1, in2, in3, in4, in5, in6, in7, in8, 
//in9, in10, in11, in12, in13, in14, in15, dout, signal);

Priority P1(out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, 
out_temp, signal);

wire write_enabled, read_enabled;
assign write_enabled = wen & !ren;
assign read_enabled = (!wen & ren) | (wen & ren);


// CAM logic
always @(posedge clk) begin
    if(write_enabled) begin
        dout <= 1'b0;
        hit <= 1'b0;
        
    end
    else if(read_enabled) begin
        if(signal) begin
            hit <= 1'b1;
            dout <= out_temp;
        end
        else begin
            hit <= 1'b0;
            dout <= 1'b0;
        end
    end
    else begin // !wen && !ren
        dout <= 1'b0;
        hit <= 1'b0;
    end
end


endmodule
