`timescale 1ns/1ps

module Many_To_One_LFSR(clk, rst_n, out);
input clk;
input rst_n;
output reg [8-1:0] out;

    always @(posedge clk) begin
        if (~rst_n)
            out <= 8'b10111101; // Initial seed value
        else begin
            // XOR feedback function using multiple taps (bit 7, 5, 4, and 3)
            out <= {out[6:0], out[1] ^ out[2] ^ out[3] ^ out[7]}; // XOR gate between bit 7 and bit 0
           
        end
    end

endmodule

