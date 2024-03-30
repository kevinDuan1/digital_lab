`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 15:40:53
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
    // Standard signals
    input RESET,
    input CLK,
    // VGA Outputs
    output [7:0]VGA_Colour,
    output HS,
    output VS,
    // IR Output
    output IR_LED,
    // Mouse Inputs and Outputs
    inout CLK_MOUSE,
    inout DATA_MOUSE,
    input [1:0] MouseSensitivity,
    output [7:0] LED_OUT,
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT
    );
    
    wire [7:0] ROM_ADDRESS;
    wire [7:0] ROM_DATA;
    wire [7:0] BUS_DATA;
    wire [7:0] BUS_ADDR;
    wire [1:0] BUS_INTERRUPTS_RAISE;
    wire [1:0] BUS_INTERRUPTS_ACK;
    wire BUS_WE;


    ROM ROM(
                   .CLK(CLK),
                   .ADDR(ROM_ADDRESS),
                   .DATA(ROM_DATA) 
                   );


    RAM RAM(
                   .CLK(CLK),
                   .BUS_DATA(BUS_DATA),
                   .BUS_ADDR(BUS_ADDR), 
                   .BUS_WE(BUS_WE)
                   );    


    Processor Processor   (
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

        
    VGA_Interface VGA(
                   .CLK(CLK),
                   .RESET(RESET),
                   .HS(HS),
                   .VS(VS),
                   .VGA_Colour(VGA_Colour),
                   .BUS_ADDRESS(BUS_ADDR),
                   .BUS_DATA(BUS_DATA)
                   );
                   
                   
    Timer Timer(
                  .CLK(CLK),
                  .RESET(RESET),
                  .BUS_DATA(BUS_DATA),
                  .BUS_ADDR(BUS_ADDR),
                  .BUS_WE(BUS_WE),
                  .BUS_INTERRUPT_RAISE(BUS_INTERRUPTS_RAISE[1]),
                  .BUS_INTERRUPT_ACK(BUS_INTERRUPTS_ACK[1]) 
                  );
                  
    New_Top_Wrapper IRWrapper (
                  .CLK(CLK),
                  .RESET(RESET),
                  .BUS_ADDR(BUS_ADDR),
                  .BUS_DATA(BUS_DATA),
                  .BUS_WE(BUS_WE),
                  .IR_LED(IR_LED)
                  );

    LED_Driver LED_Driver_inst (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA),
        .LED_OUT(LED_OUT)
    );
    
    Seven_Seg_Driver Seven_Seg_Driver_inst (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA),
        .SEG_SELECT(SEG_SELECT),
        .DEC_OUT(DEC_OUT)
    );
    

    Mouse_Driver Mouse_Driver_inst (
        .CLK(CLK),
        .RESET(RESET),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA),
        .BUS_INTERRUPT_ACK(BUS_INTERRUPTS_ACK[0]),
        .BUS_INTERRUPT_RAISE(BUS_INTERRUPTS_RAISE [0]),
        .CLK_MOUSE(CLK_MOUSE),
        .DATA_MOUSE(DATA_MOUSE),
        .sensitivity(MouseSensitivity)
    );

endmodule
