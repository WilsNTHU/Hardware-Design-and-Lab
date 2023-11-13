`timescale 1ns/1ps

module One_TO_Many_LFSR(clk, rst_n, out);
input clk;
input rst_n;
output reg [8-1:0] out;

 reg [7:0] lfsr_reg;

    always @(posedge clk) begin
        if (~rst_n)
            out <= 8'b10111101; // Initial seed value
        else begin
            // XOR feedback function using bit 0 as the feedback bit
            out <= {out[6], out[5], out[4], out[3]^out[7], out[2]^out[7], out[1]^out[7], out[0], out[7]};
        end
    end


endmodule
