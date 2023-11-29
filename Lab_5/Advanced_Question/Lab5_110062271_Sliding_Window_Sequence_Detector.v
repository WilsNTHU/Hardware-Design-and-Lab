`timescale 1ns/1ps

module Sliding_Window_Sequence_Detector (clk, rst_n, in, dec, test_state);
input clk, rst_n;
input in;
output dec;
output [2:0] test_state;

parameter [2:0] s0 = 3'd0;
parameter [2:0] s1 = 3'd1;
parameter [2:0] s2 = 3'd2;
parameter [2:0] s3 = 3'd3;
parameter [2:0] s4 = 3'd4;
parameter [2:0] s5 = 3'd5;
parameter [2:0] s6 = 3'd6;
parameter [2:0] s7 = 3'd7;

reg [2:0] state, next_state;


reg dec;

always @(posedge clk) begin
    if(~rst_n) begin
        state <= s0;
    end
    else begin
        state <= next_state;
    end
end

reg [2:0] test_state;
always @(*) begin
    test_state = state;
end

always @(*) begin
    case(state) 
        s0:
            if(in == 1'b1) begin
                next_state = s1;
                dec = 1'b0;
            end
            else begin
                next_state = s0;
                dec = 1'b0;
            end   
        s1:
            if(in == 1'b1) begin
                next_state = s2;
                dec = 1'b0;
            end
            else begin
                next_state = s0;
                dec = 1'b0;
            end   
        s2:
            if(in == 1'b1) begin
                next_state = s3;
                dec = 1'b0;
            end
            else begin
                next_state = s0;
                dec = 1'b0;
            end   
        s3:
            if(in == 1'b1) begin
                next_state = s2;
                dec = 1'b0;
            end
            else begin
                next_state = s4;
                dec = 1'b0;
            end   
        s4:
            if(in == 1'b1) begin
                next_state = s1;
                dec = 1'b0;
            end
            else begin
                next_state = s5;
                dec = 1'b0;
            end   
        s5:
            if(in == 1'b1) begin
                next_state = s6;
                dec = 1'b0;
            end
            else begin
                next_state = s0;
                dec = 1'b0;
            end   
        s6:
            if(in == 1'b1) begin
                next_state = s7;
                dec = 1'b0;
            end
            else begin
                next_state = s5;
                dec = 1'b0;
            end   
        default:
            if(in == 1'b1) begin
                next_state = s3;
                dec = 1'b1;
            end
            else begin
                next_state <= s0;
                dec <= 1'b0;
            end  
    endcase   
end



endmodule 