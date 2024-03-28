`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 12:55:49
// Design Name: 
// Module Name: Processor_TB
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


module Processor_TB(

    );
    
    reg CLK;
    reg RESET;
    
    wire BUS_DATA;
    wire BUS_ADDR;
    wire BUS_WE;
    wire ROM_ADDRESS;
    wire ROM_DATA;
    reg BUS_INTERRUPTS_RAISE;
    wire BUS_INTERRUPTS_ACK;
    
    RAM uut1 (
        .CLK(CLK),
        .BUS_WE(BUS_WE),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA)
        );
    
    ROM uut2 (
        .CLK(CLK),
        .ADDR(ROM_ADDRESS),
        .DATA(ROM_DATA)
        );
    
    Processor uut3 (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        .ROM_ADDRESS(ROM_ADDRESS),
        .ROM_DATA(ROM_DATA),
        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK)
        );
        
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        RESET = 1;
        BUS_INTERRUPTS_RAISE = 0;
        #100 RESET = 0;
        #100 BUS_INTERRUPTS_RAISE = 1;
        #10 BUS_INTERRUPTS_RAISE = 0;
    end
        
    
endmodule
