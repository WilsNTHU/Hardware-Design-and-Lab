`timescale 1ns/1ps
module tracker_sensor(clk, reset, left_signal, right_signal, mid_signal, state);
    input clk;
    input reset;
    input left_signal, right_signal, mid_signal;
    output reg [1:0] state;

    reg [1:0] next_state;

    parameter [1:0] STOP = 2'd0;
    parameter [1:0] TURN_LEFT = 2'd1;
    parameter [1:0] TURN_RIGHT = 2'd2;
    parameter [1:0] RUNNING = 2'd3;

    // [TO-DO] Receive three signals and make your own policy.
    // Hint: You can use output state to change your action.

    always @(posedge clk) begin
        if(reset) state = RUNNING;
        else state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        case({left_signal, mid_signal, right_signal})
            3'b111: next_state = RUNNING;
            3'b110: next_state = TURN_LEFT;
            3'b100: next_state = TURN_LEFT;
            3'b011: next_state = TURN_RIGHT;
            3'b001: next_state = TURN_RIGHT;
            3'b010: begin
                if(state == TURN_LEFT) next_state = TURN_LEFT;
                else if(state == TURN_RIGHT ) next_state = TURN_RIGHT; 
                else next_state = RUNNING;
            end
            3'b000: begin
                if(state == TURN_LEFT) next_state = TURN_LEFT;
                else if(state == TURN_RIGHT ) next_state = TURN_RIGHT; 
                else next_state = RUNNING;
            end
            default: next_state = RUNNING;
        endcase

        // if((left_signal && mid_signal) && right_signal)
        //     next_state = RUNNING;
        // else if(!right_signal && (mid_signal && left_signal)) 
        //     next_state = TURN_LEFT;
        // else if((!right_signal && !mid_signal) && left_signal)
        //     next_state = TURN_LEFT;
        // else if(!left_signal && (right_signal && mid_signal)) 
        //     next_state = TURN_RIGHT;
        // else if((!left_signal && !mid_signal) && right_signal)
        //     next_state = TURN_RIGHT;
        // else if((!left_signal && !right_signal) && !right_signal) begin
        //     if(state == TURN_LEFT) next_state = TURN_LEFT;
        //     else next_state = TURN_RIGHT;
        // end
        // else next_state = RUNNING;
        
    end

endmodule
