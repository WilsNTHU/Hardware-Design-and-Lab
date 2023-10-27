`timescale 1ns/1ps

module FIFO_8(clk, rst_n, wen, ren, din, dout, error);
input clk;
input rst_n;
input wen, ren;
input [8-1:0] din;
output [8-1:0] dout;
output error;

reg [7:0] dout;
reg error;

reg [7:0] mem [7:0];
reg full, empty;
reg [2:0] read_ptr, write_ptr;

always @(posedge clk) begin
    if(~rst_n) begin
        read_ptr <= 3'd0;
        write_ptr <= 3'd0;
        dout <= 8'd0;
        error <= 1'b0;
        empty <= 1'b1;
        full <= 1'b0;
    end
    else begin
        if((ren && !wen) || (ren && wen)) begin
            if(empty) error <= 1'b1;
            else begin
                error <= 1'b0;
                dout <= mem[read_ptr];
                full <= 1'b0;
                if(read_ptr == 3'd7) begin
                    if(write_ptr == 3'd0) empty <= 1'b1;
                    else empty <= 1'b0;
                end
                else begin
                    if(read_ptr + 3'd1 == write_ptr) empty <= 1'b1;
                    else empty <= 1'b0;
                end
                read_ptr <= (read_ptr == 3'd7) ? 3'd0 : read_ptr + 3'd1;
            end
        end
        else if(wen && !ren) begin
            if(full) error <= 1'b1;
            else begin
                error <= 1'b0;
                mem[write_ptr] <= din;
                empty <= 1'd0;
                if(write_ptr == 3'd7) begin
                    if(read_ptr == 3'd0) full <= 1'b1;
                    else full <= 1'b0;
                end
                else begin
                    if(write_ptr + 3'd1 == read_ptr) full <= 1'b1;
                    else full <= 1'b0;
                end
                write_ptr <= (write_ptr == 3'd7) ? 3'd0 : write_ptr + 3'd1;
            end
        end
        else dout <= dout; // ren == 1'b0 && wen == 1'b0
    end
end

endmodule
