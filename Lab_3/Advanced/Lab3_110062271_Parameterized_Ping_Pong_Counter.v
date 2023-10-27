`timescale 1ns/1ps

module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;

reg direction;
reg next_direction;
reg [3:0] out;
reg [3:0] next_out;

always @(posedge clk) begin
    if(!rst_n) begin
        out <= min;
        direction <= 1'b1;
    end
    else begin
        out <= next_out;
        direction <= next_direction;
    end
end

always @(*) begin
    if(enable) begin
        if(((max > min) && (out == max || (out == min && direction == 1'b0))) || ((flip == 1'b1) && (out < max) && (out > min))) begin
            next_direction = !direction; 
            if(next_direction == 1'b0) next_out = out - 1'b1;
            else next_out = out + 1'b1;
        end
        else if((max == min) || (max < min) || (out > max) || (out < min)) begin
            next_out = out;
            next_direction = direction;
        end
        else begin
            next_direction = direction;
            if(next_direction == 1'b0) next_out = out - 1'b1;
            else next_out = out + 1'b1;
        end

        
    end
    else begin
        next_out = out;
        next_direction = direction;
    end
end


endmodule
