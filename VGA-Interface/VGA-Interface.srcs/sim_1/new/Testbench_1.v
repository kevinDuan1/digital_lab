`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 15:05:32
// Design Name: 
// Module Name: Testbench_1
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


module Testbench_1();

    reg CLK;
    reg RESET;
    wire VGA_HS;
    wire VGA_VS;
    wire [14:0] VGA_ADDR;
    
    VGA_Sig_Gen VGA_SIM(
                        .CLK(CLK),
                        .RESET(RESET),
                        .VGA_HS(VGA_HS),
                        .VGA_VS(VGA_VS),
                        .VGA_ADDR(VGA_ADDR));
    initial begin
        CLK = 1;  
        forever #10 CLK = ~CLK;
    end

    initial begin
        RESET = 1;
        #1000 RESET = 0;
    end
    
    initial begin
     #10000000 $stop;
    end
                        

endmodule
