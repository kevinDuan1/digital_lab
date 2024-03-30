`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2024 20:27:43
// Design Name: 
// Module Name: LED_Driver
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


module LED_Driver (
    //standard signals
    input CLK,
    input RESET,
    
    //BUS signals
    inout [7:0] BUS_DATA,
    input [7:0] BUS_ADDR,
    
    output [7:0] LED_OUT
    );

    // Memory address space
    parameter [7:0] LEDBaseAddr = 8'hF0; 
    reg [7:0] LED_DATA;

    // change the LED_DATA value if the address is the LEDBaseAddr
    always @(posedge CLK) begin
        if (RESET) begin
            LED_DATA <= 8'b0;
        end else begin
            if (BUS_ADDR == LEDBaseAddr) begin
                LED_DATA <= BUS_DATA;                
            end
        end
    end

    assign LED_OUT = LED_DATA;

    
endmodule
