`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 10:58:43
// Design Name: 
// Module Name: New_Top_Wrapper
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


module New_Top_Wrapper(
    input CLK,
    input RESET,
    input [7:0] BUS_ADDR,
    input [7:0] BUS_DATA,
    input BUS_WE,
    output IR_LED
    );
    
    parameter [7:0] IRBaseAddr = 8'h90;
    
    reg [3:0] COMMAND;
    
    //Create wire for SEND_PACKET signals as it is a crucial signal that doesn't come from any I/O
    wire SEND_PACKET;
    
    always@(posedge CLK) begin
        if (RESET)
            COMMAND <= 0;
        else if ((BUS_ADDR == IRBaseAddr) & BUS_WE)
            COMMAND <= BUS_DATA [3:0];
    end
    
    //Instantiate 10Hz counter module for generating SEND_PACKET signals at 10Hz
    TENHz_Counter2 Counter (
        .CLK (CLK),
        .RESET (RESET),
        .SEND_PACKET (SEND_PACKET)
        );
    
    //Instantiate IR SM module    
    IRTransmitterSM2 IRSM (
        .CLK (CLK),
        .RESET (RESET),
        .COMMAND (COMMAND),
        .SEND_PACKET (SEND_PACKET),
        .IR_LED (IR_LED)
        );
    
endmodule
