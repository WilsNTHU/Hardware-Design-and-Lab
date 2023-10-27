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
        if(ren && !wen) begin
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
        else if((wen && !ren) || (ren && wen)) begin
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
        else begin
            if(empty) begin
                dout <= 8'b0;
                error <= 1'b1;
            end
            else begin
                dout <= dout;
                error <= 1'b0;
            end
        end
    end
end

endmodule

module Round_Robin_FIFO_Arbiter(clk, rst_n, wen, a, b, c, d, dout, valid);
input clk;
input rst_n;
input [4-1:0] wen;
input [8-1:0] a, b, c, d;
output [8-1:0] dout;
output valid;

reg[7:0] dout;
reg valid;

reg ren1, ren2, ren3, ren4;
wire err1, err2, err3, err4;
reg [1:0] counter;
reg [7:0] result;
reg [1:0] sel;
wire [7:0] out1, out2, out3, out4;


always @(posedge clk) begin
    if(~rst_n) begin
        dout <= 8'b0;
        valid <= 1'b0;
        counter <= 2'b00;
    end
    else begin
        case(counter)
        2'b00:
            if(wen[0] || err1) begin
                valid <= 1'b0;
                dout <= 8'b0;
            end
            else begin
                valid <= 1'b1;
                sel <= 2'b00;
            end
        2'b01:
            if(wen[1] || err2) begin
                valid <= 1'b0;
                dout <= 8'b0;
            end
            else begin
                valid <= 1'b1;
                sel <= 2'b01;
            end
        2'b10:
            if(wen[2] || err3) begin
                valid <= 1'b0;
                dout <= 8'b0;
            end
            else begin
                valid <= 1'b1;
                sel <= 2'b10;
            end
        default:
            if(wen[3] || err4) begin
                valid <= 1'b0;
                dout <= 8'b0;
            end
            else begin
                valid <= 1'b1;
                sel <= 2'b11;
            end
        endcase
        counter <= (counter == 2'b11) ? 2'b00 : (counter + 2'b01);
    end
end

always @(posedge clk) begin
    if(~rst_n) begin
        ren1 <= 1'b1;
        ren2 <= 1'b0;
        ren3 <= 1'b0;
        ren4 <= 1'b0;
        result <= out1;
    end
    else begin
        ren1 <= (counter == 2'b11) ? 1'b1 : 1'b0;
        ren2 <= (counter == 2'b00) ? 1'b1 : 1'b0;
        ren3 <= (counter == 2'b01) ? 1'b1 : 1'b0;
        ren4 <= (counter == 2'b10) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case(sel)
        2'b00: dout = out1;
        2'b01: dout = out2;
        2'b10: dout = out3;
        2'b11: dout = out4;
    endcase
end


// FIFO_8(clk, rst_n, wen, ren, din, dout, error);
FIFO_8 F1(clk, rst_n, wen[0], ren1, a, out1, err1);
FIFO_8 F2(clk, rst_n, wen[1], ren2, b, out2, err2);
FIFO_8 F3(clk, rst_n, wen[2], ren3, c, out3, err3);
FIFO_8 F4(clk, rst_n, wen[3], ren4, d, out4, err4);

endmodule
