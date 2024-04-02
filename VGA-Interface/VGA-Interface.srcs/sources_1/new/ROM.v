`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2024 12:02:14
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
    //standard signals
    input CLK,
    //BUS signals
    output reg [7:0] DATA,
    input [7:0] ADDR);
    
    parameter RAMAddrWidth = 8;
    //Memory
    reg [7:0]ROM[2**RAMAddrWidth-1:0];
    // Load program

    initial $readmemh("Complete_Demo_ROM5.txt", ROM);
    //single port ram
    always@(posedge CLK)
        DATA <= ROM[ADDR];
endmodule