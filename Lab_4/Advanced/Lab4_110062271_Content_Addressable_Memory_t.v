module CAM_test;
reg clk, wen, ren;
reg [7:0] din;
reg [3:0] addr;
wire [3:0] dout;
wire hit;

// Content_Addressable_Memory(clk, wen, ren, din, addr, dout, hit);
Content_Addressable_Memory C1(clk, wen, ren, din, addr, dout, hit);

always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    ren = 1'b0;
    wen = 1'b0;
    addr = 4'd0;
    din = 8'd0;

    @(negedge clk) 
    wen = 1'b1;
    din = 8'd4;
    @(negedge clk) 
    addr = 4'd7;
    din = 8'd8;
    @(negedge clk) 
    addr = 4'd15;
    din = 8'd35;
    @(negedge clk) 
    addr = 4'd9;
    din = 8'd8;
    @(negedge clk) 
    addr = 4'd0;
    din = 8'd0;
    wen = 1'b0;
    @(negedge clk) 
    wen = 1'b0;
    @(negedge clk) 
    wen = 1'b0;
    @(negedge clk) 
    din = 8'd4;
    ren = 1'b1;
    @(negedge clk) 
    din = 8'd8;
    ren = 1'b1;
    @(negedge clk) 
    din = 8'd35;
    ren = 1'b1;
    @(negedge clk)
    din = 8'd87; 
    ren = 1'b1;
    @(negedge clk)
    din = 8'd45; 
    ren = 1'b1;
    @(negedge clk) 
    din = 8'd0;
    ren = 1'b0;
    @(negedge clk) 
    ren = 1'b0;
    @(negedge clk) 
    ren = 1'b0;
    @(negedge clk) 
    ren = 1'b0;

end
endmodule