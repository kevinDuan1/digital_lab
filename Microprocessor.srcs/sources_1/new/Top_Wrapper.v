`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 12:10:54
// Design Name: 
// Module Name: Top_Wrapper
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


module Top_Wrapper(
    // General 
    input CLK,
    input RESET,
    // IR Output
    output IR_LED,
    // VGA Outputs
    output [7:0]VGA_Colour,
    output HS,
    output VS
    );
    
    //Declare wires for the RAM, ROM and Interrupt signals
    wire [7:0] BUS_DATA;
    wire [7:0] BUS_ADDR;
    wire BUS_WE;
    
    wire [7:0] ROM_ADDRESS;
    wire [7:0] ROM_DATA;
    
    wire [1:0] BUS_INTERRUPTS_RAISE;
    wire [1:0] BUS_INTERRUPTS_ACK;
    
    //Instantiate the IR wrapper
    New_Top_Wrapper IRWrapper (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA),
        .BUS_WE(BUS_WE),
        .IR_LED(IR_LED)
        );
    
    //Instantiate VGA interface
    VGA_Interface VGA(
        .CLK(CLK),
        .RESET(RESET),
        .HS(HS),
        .VS(VS),
        .VGA_Colour(VGA_Colour),
        .BUS_ADDRESS(BUS_ADDR),
        .BUS_DATA(BUS_DATA)
        );

    //Instantiate the RAM module
    RAM ProcRAM (
        .CLK(CLK),
        .BUS_WE(BUS_WE),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA)
        );
    
    //Instantiate the ROM module
    ROM ProcROM (
        .CLK(CLK),
        .ADDR(ROM_ADDRESS),
        .DATA(ROM_DATA)
        );
    
    //Instantiate the Timer module
    Timer ProcTimer (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE [1]),
        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK [1])
        );
    
    //Instantiate the Processor module
    Processor ProcCPU (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        .ROM_ADDRESS(ROM_ADDRESS),
        .ROM_DATA(ROM_DATA),
        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK)
//        .RegA(RegA),
//        .RegB(RegB),
//        .CURR_STATE(CURR_STATE)
        );
    
endmodule
