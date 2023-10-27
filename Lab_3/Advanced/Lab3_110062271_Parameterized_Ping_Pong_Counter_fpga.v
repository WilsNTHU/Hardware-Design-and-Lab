module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;

reg direction;
reg next_direction;
reg [3:0] out;
reg [3:0] next_out;

reg[26:0] one_second_counter;
wire one_second_enable;

always @(posedge clk) begin
    if(~rst_n) one_second_counter <= 0;
    else begin
        if(one_second_counter >= 99999999) one_second_counter <= 0;
        else one_second_counter <= one_second_counter + 1;
    end
end


assign one_second_enable = (one_second_counter == 99999999) ? 1'b1 : 1'b0;


always @(posedge clk) begin
    if(!rst_n) begin
        out <= min;
        direction <= 1'b1;
    end
    else if(one_second_enable)begin
        out <= next_out;
        direction <= next_direction;
    end
end

always @(*) begin
    if(enable) begin // fpga modified version
        if(((max > min) && (out == max || (out == min && direction == 1'b0))) || ((flip == 1'b1) && (out <= max) && (out >= min))) begin
            next_direction = !direction; 
            if(next_direction == 1'b0) next_out = out - 1'b1;
            else next_out = out + 1'b1;
        end
        else if((max == min) || (max < min) || (out > max) || (out < min)) begin
            next_out = out;
            next_direction = direction;
        end
        else begin
            next_direction = direction;
            if(next_direction == 1'b0) next_out = out - 1'b1;
            else next_out = out + 1'b1;
        end
    end
    else begin
        next_out = out;
        next_direction = direction;
    end
end


endmodule

module debounce(clk, pb, pb_debounced);
input clk, pb;
output pb_debounced;
reg [3:0] temp;

always @(posedge clk) begin
    temp[3:1] <= temp[2:0];
    temp[0] <= pb;
end

assign pb_debounced = (temp == 4'b1111) ? 1'b1 : 1'b0;

endmodule

module onepulse(clk, pb_debounced, pb_one_pulse);
input clk, pb_debounced;
output reg pb_one_pulse;

reg pb_debounced_delay;

always @(posedge clk) begin
    pb_one_pulse <= pb_debounced & (!pb_debounced_delay);
    pb_debounced_delay <= pb_debounced;
end

endmodule

module one_signal(clk, pb, pb_one_pulse);
input clk, pb;
output pb_one_pulse;

wire pb_debounced;

debounce d1(clk, pb, pb_debounced);
onepulse d2(clk, pb_debounced, pb_one_pulse);

endmodule


module  FPGA_7segemnt(SW, clk, btn_up, btn_down, LED_out, anode_digit);
input [8:0] SW;
input clk, btn_up, btn_down;
wire rst_n, flip, direction;

reg [19:0] refresh_counter;
wire [1:0] sel;

reg [26:0] one_second_counter;
wire one_second_enable;
wire [3:0] dout;
reg reset_signal;
output reg [6:0] LED_out;
output reg [3:0] anode_digit;

one_signal d1(clk, btn_up, rst_n);
one_signal d2(clk, btn_down, flip);

// Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
Parameterized_Ping_Pong_Counter C1(clk, !rst_n, SW[8], flip, SW[7:4], SW[3:0], direction, dout); 


always @(posedge clk or posedge rst_n) begin
    if(rst_n == 1) refresh_counter <= 0;
    else refresh_counter <= refresh_counter + 1;
end

assign sel = refresh_counter[19:18];

always @(sel) begin
        if(sel == 2'b00) begin
            anode_digit = 4'b1110;
            if(direction == 1'b0) LED_out = 7'b1100011;
            else LED_out = 7'b0011101;
        end
        else if(sel == 2'b01) begin
            anode_digit = 4'b1101;
            if(direction == 1'b0) LED_out = 7'b1100011;
            else LED_out = 7'b0011101;
        end
        else if(sel == 2'b10) begin
            anode_digit = 4'b1011;
            case(dout)
                4'd0: LED_out = 7'b0000001;
                4'd1: LED_out = 7'b1001111;
                4'd2: LED_out = 7'b0010010;
                4'd3: LED_out = 7'b0000110; 
                4'd4: LED_out = 7'b1001100;
                4'd5: LED_out = 7'b0100100;
                4'd6: LED_out = 7'b0100000;
                4'd7: LED_out = 7'b0001111;
                4'd8: LED_out = 7'b0000000;
                4'd9: LED_out = 7'b0000100;
                4'd10: LED_out = 7'b0000001;
                4'd11: LED_out = 7'b1001111;
                4'd12: LED_out = 7'b0010010;
                4'd13: LED_out = 7'b0000110;
                4'd14: LED_out = 7'b1001100;
                4'd15: LED_out = 7'b0100100;
                default: LED_out = 7'b0000000;
            endcase
        end
        else begin
            anode_digit = 4'b0111;
            if(dout >= 4'b1010) LED_out = 7'b1001111; // 1
            else LED_out = 7'b0000001; // 0
        end
end



endmodule