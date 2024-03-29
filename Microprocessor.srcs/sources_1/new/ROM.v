`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Harysh Tan Ravy
// 
// Create Date: 04.03.2024 21:07:51
// Design Name: 
// Module Name: ROM
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


module ROM(
    input CLK,
    input [7:0] ADDR,
    output reg [7:0] DATA
    );
    
    parameter RAMAddrWidth = 8;
    
    //Memory
    reg [7:0] ROM [2**RAMAddrWidth-1:0];
    
    //Load program
    initial $readmemh("Complete_Demo_ROM2.txt", ROM);
    
    //Single port logic
    always@(posedge CLK)
        DATA <= ROM[ADDR];
    
endmodule
