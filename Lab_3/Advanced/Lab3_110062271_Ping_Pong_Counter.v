`timescale 1ns/1ps

module Ping_Pong_Counter (clk, rst_n, enable, direction, out);
input clk, rst_n;
input enable;
output direction;
output [4-1:0] out;

reg direction;
reg next_direction;
reg [3:0] out;
reg [3:0] next_out;

always @(posedge clk) begin
    if(!rst_n) begin
        out <= 4'd0;
        direction <= 1'b1;
    end
    else begin
        out <= next_out;
        direction <= next_direction;
    end
end

always @(*) begin
    if(enable) begin
        if(out == 4'd15 || (out == 4'd0 && direction == 1'b0)) next_direction = !direction; 
        if(next_direction == 1'b0) next_out = out - 1;
        else if(next_direction == 1'd1) next_out = out + 1;
    end
    else begin
        next_out = out;
        next_direction = direction;
    end
end

endmodule
