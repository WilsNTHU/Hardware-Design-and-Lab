module Top(
    input clk,
    input rst,
    input echo,
    input left_signal,
    input right_signal,
    input mid_signal,
    output trig,
    output left_motor,
    output reg [1:0]left,
    output right_motor,
    output reg [1:0]right,
    output reg [3:0] LED
);

    // parameter [1:0] STOP = 2'd0;
    parameter [1:0] TURN_LEFT = 2'd1;
    parameter [1:0] TURN_RIGHT = 2'd2;
    parameter [1:0] RUNNING = 2'd3;

    wire Rst_n, rst_pb, stop;
    wire [1:0] mode;
    debounce d0(rst_pb, rst, clk);
    onepulse d1(rst_pb, clk, Rst_n);

    motor A(
        .clk(clk),
        .rst(Rst_n),
        .mode(mode),
        .pwm({left_motor, right_motor})
    );

    sonic_top B(
        .clk(clk), 
        .rst(Rst_n), 
        .Echo(echo), 
        .Trig(trig),
        .stop(stop)
    );
    
    tracker_sensor C(
        .clk(clk), 
        .reset(Rst_n), 
        .left_signal(left_signal), 
        .right_signal(right_signal),
        .mid_signal(mid_signal), 
        .state(mode)
       );

    always @(*) begin
        // [TO-DO] Use left and right to set your pwm
        if(stop) begin
            {left, right} = {2'b00, 2'b00}; // {left, right} = {in1, in2}
            LED = 4'b1000;
        end
        else begin
            case(mode)
                TURN_LEFT: begin
                    {left, right} = {2'b01, 2'b10};
                    LED = 4'b0100;
                end
                TURN_RIGHT:  begin
                    {left, right} = {2'b10, 2'b01};
                    LED = 4'b0010;
                end
                default: begin
                    {left, right} = {2'b10, 2'b10};
                    LED = 4'b0001;
                end
            endcase
        end
    end

endmodule

module debounce (pb_debounced, pb, clk);
    output pb_debounced; 
    input pb;
    input clk;
    reg [4:0] DFF;
    
    always @(posedge clk) begin
        DFF[4:1] <= DFF[3:0];
        DFF[0] <= pb; 
    end
    assign pb_debounced = (&(DFF)); 
endmodule

module onepulse (PB_debounced, clk, PB_one_pulse);
    input PB_debounced;
    input clk;
    output reg PB_one_pulse;
    reg PB_debounced_delay;

    always @(posedge clk) begin
        PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
        PB_debounced_delay <= PB_debounced;
    end 
endmodule

