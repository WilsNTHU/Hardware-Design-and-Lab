module Round_Robin_FIFO_Arbiter_test;
  reg clk;
  reg rst_n;
  reg [4-1:0] wen;
  reg [8-1:0] a, b, c, d;
  wire [8-1:0] dout;
  wire valid;

  // Instantiate the module
  Round_Robin_FIFO_Arbiter r1(clk, rst_n, wen, a, b, c, d, dout, valid);

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    clk = 1'b0;
    rst_n = 1'b0;

    @(negedge clk)
        rst_n = 1'b1;
        wen = 4'b1111;
        a = 8'd87;
        b = 8'd56;
        c = 8'd9;
        d = 8'd13;

    @(negedge clk)
        wen = 4'b1000;
        a = 8'd0;
        b = 8'd0;
        c = 8'd0;
        d = 8'd85;
    @(negedge clk)
        wen = 4'b0100;
        c = 8'd139;
        d = 8'd0;
    @(negedge clk)
        wen = 4'b0000;
        c = 8'd0;
    @(negedge clk)
        wen = 4'b0000;
    @(negedge clk)
        wen = 4'b0000;
    @(negedge clk)
        wen = 4'b0001;
        a = 8'd51;
    @(negedge clk)
        wen =4'b0000;
        a = 8'd0;
    @(negedge clk)
        wen =4'b0000;
    @(negedge clk)
        wen =4'b0000;
    @(negedge clk)
        wen =4'b0000;
  end
endmodule
