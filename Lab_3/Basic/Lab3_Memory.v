`timescale 1ns/1ps

module Memory (clk, ren, wen, addr, din, dout);
input clk;
input ren, wen;
input [7-1:0] addr;
input [8-1:0] din;
output [8-1:0] dout;

reg [8-1:0] dout;
reg [8-1:0] memory [127:0];

always @(posedge clk) begin
    if(ren && wen) begin
        dout [8-1:0] <= memory[addr];
    end
    else if(ren && !wen) begin
        dout [8-1:0] <= memory[addr];
    end
    else if(wen && !ren) begin
        memory[addr] <= din[8-1:0];
        dout <= 0;
    end
    else begin
        dout <= 0;
    end
end

endmodule
