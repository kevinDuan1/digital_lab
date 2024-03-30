`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Marco Bancalari-Ruiz
// 
// Create Date: 23.01.2024 10:29:39
// Design Name: 
// Module Name: Frame_Buffer
// Project Name: VGA Interface
// Target Devices: BASYS 3 board, VGA monitor
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 1
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Frame_Buffer(
// port A: read/write
    input A_CLK,    // port A clock
    input [14:0] A_ADDR,    // port A pixel address (7+8 bits)
    input A_DATA_IN,    // pixel data in
    output reg A_DATA_OUT,  // port A pixel data out to microprocessor
    input A_WE,     // write enable
// port B: read only
    input B_CLK,    // port B clock
    input [14:0] B_ADDR,    // port B pixel address (7+8 bits)
    output reg B_DATA   // port B pixel data out to signal gen
    );
    
    
    // 256 x 128 1 bit memory to hold frame data
    //LSB stores horizontal address, MSB stores vertical address
    reg [0:0] Mem [2**15-1:0];
    
    // Port A - Read/Write to be used by microprocessor
    always@(posedge A_CLK) begin
        if(A_WE)
            Mem[A_ADDR] <= A_DATA_IN;   // set memory at address to data in when write enabled
            
        A_DATA_OUT <= Mem[A_ADDR];      // output stored data at address
    end
    
    // Port B - Read Only e.g. to be read from the VGA signal generator module for display
    always@(posedge B_CLK)
        B_DATA <= Mem[B_ADDR]; 
    
endmodule
