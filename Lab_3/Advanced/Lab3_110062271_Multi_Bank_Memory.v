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

module Bank_Memory(clk, ren, wen, waddr, raddr, din, dout);
input clk;
input ren, wen;
input [11-1:0] waddr;
input [11-1:0] raddr;
input [8-1:0] din;
output [8-1:0] dout;

reg ren1, ren2, ren3, ren4, wen1, wen2, wen3, wen4;
wire [7:0] out1, out2, out3, out4;
reg [7:0] dout;

always @(*) begin
    if(ren == 1'b1) begin
        ren1 = (raddr[8:7] == 2'b00) ? 1'b1 : 1'b0;
        ren2 = (raddr[8:7] == 2'b01) ? 1'b1 : 1'b0;
        ren3 = (raddr[8:7] == 2'b10) ? 1'b1 : 1'b0;
        ren4 = (raddr[8:7] == 2'b11) ? 1'b1 : 1'b0;
    end
    else begin
        ren1 = 1'b0;
        ren2 = 1'b0;
        ren3 = 1'b0;
        ren4 = 1'b0;
    end 

    if(wen == 1'b1) begin
        if(ren == 1'b1 && (raddr[8:7] == waddr[8:7])) begin
            wen1 = 1'b0;
            wen2 = 1'b0;
            wen3 = 1'b0;
            wen4 = 1'b0;
        end
        else begin
            wen1 = (waddr[8:7] == 2'b00) ? 1'b1 : 1'b0;
            wen2 = (waddr[8:7] == 2'b01) ? 1'b1 : 1'b0;
            wen3 = (waddr[8:7] == 2'b10) ? 1'b1 : 1'b0;
            wen4 = (waddr[8:7] == 2'b11) ? 1'b1 : 1'b0;
        end
        
    end
    
end

wire [6:0] addr1, addr2, addr3, addr4;
assign addr1 = (ren1 == 1'b1) ? raddr[6:0] : (wen1 == 1'b1) ? waddr[6:0] : 4'b0;
assign addr2 = (ren2 == 1'b1) ? raddr[6:0] : (wen2 == 1'b1) ? waddr[6:0] : 4'b0;
assign addr3 = (ren3 == 1'b1) ? raddr[6:0] : (wen3 == 1'b1) ? waddr[6:0] : 4'b0;
assign addr4 = (ren4 == 1'b1) ? raddr[6:0] : (wen4 == 1'b1) ? waddr[6:0] : 4'b0;


Memory m1(clk, ren1, wen1, addr1, din, out1);
Memory m2(clk, ren2, wen2, addr2, din, out2);
Memory m3(clk, ren3, wen3, addr3, din, out3);
Memory m4(clk, ren4, wen4, addr4, din, out4);

always @(*) begin
    if(ren == 1'b1) begin
        if(ren1 == 1'b1) begin
        dout = out1;
        end
        else if(ren2 == 1'b1) begin
            dout = out2;
        end
        else if(ren3 == 1'b1) begin
            dout = out3;
        end
        else if(ren4 == 1'b1)begin
            dout = out4;
        end
    end
end

endmodule


module Multi_Bank_Memory (clk, ren, wen, waddr, raddr, din, dout);
input clk;
input ren, wen;
input [11-1:0] waddr;
input [11-1:0] raddr;
input [8-1:0] din;
output [8-1:0] dout;


reg ren1, ren2, ren3, ren4, wen1, wen2, wen3, wen4;
wire [7:0] out1, out2, out3, out4;
reg [7:0] dout;

always @(*) begin
    if(ren == 1'b1) begin
        ren1 = (raddr[10:9] == 2'b00) ? 1'b1 : 1'b0;
        ren2 = (raddr[10:9] == 2'b01) ? 1'b1 : 1'b0;
        ren3 = (raddr[10:9] == 2'b10) ? 1'b1 : 1'b0;
        ren4 = (raddr[10:9] == 2'b11) ? 1'b1 : 1'b0;
    end
    else begin
        ren1 = 1'b0;
        ren2 = 1'b0;
        ren3 = 1'b0;
        ren4 = 1'b0;
    end

    if(wen == 1'b1) begin
        if(ren == 1'b1 && (raddr[10:9] == waddr[10:9])) begin
            wen1 = 1'b0;
            wen2 = 1'b0;
            wen3 = 1'b0;
            wen4 = 1'b0;
        end
        else begin
            wen1 = (waddr[10:9] == 2'b00) ? 1'b1 : 1'b0;
            wen2 = (waddr[10:9] == 2'b01) ? 1'b1 : 1'b0;
            wen3 = (waddr[10:9] == 2'b10) ? 1'b1 : 1'b0;
            wen4 = (waddr[10:9] == 2'b11) ? 1'b1 : 1'b0;
        end
    end
end



// Bank_Memory(clk, ren, wen, waddr, raddr, din, dout);
Bank_Memory m1(clk, ren1, wen1, waddr, raddr, din, out1);
Bank_Memory m2(clk, ren2, wen2, waddr, raddr, din, out2);
Bank_Memory m3(clk, ren3, wen3, waddr, raddr, din, out3);
Bank_Memory m4(clk, ren4, wen4, waddr, raddr, din, out4);

always @(*) begin
    if(ren == 1'b1) begin
        if(ren1 == 1'b1) begin
        dout = out1;
        end
        else if(ren2 == 1'b1) begin
            dout = out2;
        end
        else if(ren3 == 1'b1) begin
            dout = out3;
        end
        else if(ren4 == 1'b1)begin
            dout = out4;
        end
    end
    
end

endmodule
