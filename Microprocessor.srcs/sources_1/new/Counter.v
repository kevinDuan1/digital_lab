`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2024 12:12:51
// Design Name: 
// Module Name: Counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Counter(
    CLK,
    RESET,
    ENABLE_IN,
    TRIG_OUT,
    COUNT
    );
    
    parameter COUNTER_WIDTH = 4;
    parameter COUNTER_MAX = 9;
    
    input CLK;
    input RESET;
    input ENABLE_IN;
    output TRIG_OUT;
    output [COUNTER_WIDTH-1:0] COUNT;
    
    reg [COUNTER_WIDTH-1:0] count_value;
    reg trigger_out;
    
    always@(posedge CLK)begin
        if(RESET)
            count_value <= 0;
        else begin
            if(ENABLE_IN) begin
                if(count_value == COUNTER_MAX)
                    count_value <=0;
                else 
                    count_value <= count_value + 1;
            end
        end
    end
    
    always@(posedge CLK)begin
        if(RESET)
            trigger_out <= 0;
        else begin
            if((count_value == COUNTER_MAX) && ENABLE_IN)
                trigger_out <= 1;
            else
                trigger_out <= 0;
        end
    end
    
    assign COUNT = count_value;
    assign TRIG_OUT = trigger_out;
    
endmodule
