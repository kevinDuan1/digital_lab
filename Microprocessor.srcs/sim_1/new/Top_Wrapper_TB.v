`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 13:20:39
// Design Name: 
// Module Name: Top_Wrapper_TB
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


module Top_Wrapper_TB(

    );
    
    //Declare the inputs and outputs of the processor wrapper as registers and wires
    
    reg CLK;
    reg RESET;
    wire IR_LED;
//    wire [7:0] BUS_DATA;
//    wire [7:0] BUS_ADDR;
//    wire BUS_WE;
    
//    wire [7:0] ROM_ADDRESS;
//    wire [7:0] ROM_DATA;
    
//    wire [1:0] BUS_INTERRUPTS_RAISE;
//    wire [1:0] BUS_INTERRUPTS_ACK;
    
//    //for testbench
//    wire [7:0] RegA;
//    wire [7:0] RegB;
//    wire [7:0] CURR_STATE;
    
    //Instantiate the top wrapper as the unit under test
    
    Top_Wrapper uut (
        .CLK(CLK),
        .RESET(RESET),
        .IR_LED(IR_LED)
//        .BUS_DATA(BUS_DATA),
//        .BUS_ADDR(BUS_ADDR),
//        .BUS_WE(BUS_WE),
//        .ROM_ADDRESS(ROM_ADDRESS),
//        .ROM_DATA(ROM_DATA),
//        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
//        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK),
//        //for testbench
//        .RegA(RegA),
//        .RegB(RegB),
//        .CURR_STATE(CURR_STATE)
        );
    
    //Generate a 100MHz clock signal
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    //Apply a global reset to the whole program for 10ns
    initial begin
        RESET = 1;
        #10 RESET = 0;
    end
    
endmodule
