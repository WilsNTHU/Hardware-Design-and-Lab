module Sliding_Window_Test;

reg clk, rst_n, in;
wire dec;

wire [2:0] test_state;
Sliding_Window_Sequence_Detector m1(clk, rst_n, in, dec, test_state);

always #5 clk = ~clk;

initial begin
    clk = 1'b1;
    rst_n = 1'b0;
    in = 1'b0;

    #5
    rst_n = 1'b1;
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b0;
    #10
    in = 1'b0;
    #10
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b0;
    #10
    in = 1'b0;
    #10
    in = 1'b1;
    #10
    in = 1'b0;
    #10
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b1;
    #10
    in = 1'b0;

end
endmodule