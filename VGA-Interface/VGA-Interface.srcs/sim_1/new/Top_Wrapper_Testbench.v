`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 17:36:38
// Design Name: 
// Module Name: Top_Wrapper_Testbench
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


module Top_Wrapper_Testbench();

    reg CLK;
    reg RESET;
    wire VGA_HS;
    wire VGA_VS;
    wire [7:0] COLOUR_OUT;
    
    
    // Instantiate top wrapper
    Top_Wrapper TOP_SIM(
                        .CLK(CLK),
                        .RESET(RESET),
                        .HS(VGA_HS),
                        .VS(VGA_VS),
                        .VGA_Colour(COLOUR_OUT));
    //Simulate CLK
    always begin
       CLK = 0;  
       forever #10 CLK = ~CLK;
    end
    
    // Simulate RESET
    initial begin
        RESET = 1;
        #100 RESET = 0;
     end
    
endmodule
