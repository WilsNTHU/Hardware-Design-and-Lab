`timescale 1ns/1ps

module Calculate_submodule(clk, en, a, b, gcd, done);
input clk, en;
input [15:0] a, b;
output reg done;
output reg [15:0] gcd;

reg [15:0] A, B;

always @(en) begin
    A = a;
    B = b;
end

always @(posedge clk) begin
    if(~en) done <= 1'b0; 
    else begin
        if(~done) begin
            if(A == 0) begin
                gcd <= B;
                done <= 1'b1;
            end
            else begin
                if(B != 16'd0) begin
                    if(A > B) A <= A - B;
                    else B <= B - A;
                end
                else begin
                    gcd <= A;
                    done <= 1'b1;
                end
            end
        end
    end
end

endmodule

module Greatest_Common_Divisor (clk, rst_n, start, a, b, done, gcd);
input clk, rst_n;
input start;
input [15:0] a;
input [15:0] b;
output done;
output [15:0] gcd;

parameter WAIT = 2'b00;
parameter CAL = 2'b01;
parameter FINISH = 2'b10;

wire cal_finished;
wire [15:0] gcd_result;

reg en, done;
reg [15:0] A, B;
reg [1:0] state, next_state;
reg [15:0] gcd;

reg [1:0] counter;

Calculate_submodule c1(clk, en, A, B, gcd_result, cal_finished);

always @(posedge clk) begin
    if(~rst_n) begin
        state <= WAIT;
        en <= 1'b0;
        gcd <= 16'd0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        if(state == WAIT) begin
            en <= 1'b0;
            gcd <= 16'd0;
            done <= 1'b0;
            counter <= 2'd0;
        end
        if(state == FINISH) begin
            counter <= counter + 2'd1;
            if(counter == 2'd2) begin
                state <= WAIT;
                en <= 1'b0;
                gcd <= 16'd0;
                done <= 2'd0;
            end
            else begin
                gcd <= gcd_result;
                done <= cal_finished;
            end
        end
    end
end

always @(*) begin
    if(state == WAIT) begin
        A = a;
        B = b;
    end
end

always @(*) begin
    case(state)
        WAIT: begin
            if(start == 1'b1) next_state = CAL;
            else next_state = WAIT;
        end
            
        CAL: begin
            en <= 1'b1;
            if(cal_finished == 1'b1) next_state = FINISH;
        end
            
    endcase   
        
end

endmodule
