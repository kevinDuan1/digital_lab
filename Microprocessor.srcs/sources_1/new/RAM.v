`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Harysh Tan Ravy
// 
// Create Date: 04.03.2024 20:55:01
// Design Name: 
// Module Name: RAM
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


module RAM(
    input CLK,
    input BUS_WE,
    input [7:0] BUS_ADDR,
    inout [7:0] BUS_DATA
    );
    
    parameter RAMBaseAddr = 0;
    parameter RAMAddrWidth = 7; //128 x 8-bits memory
    
    //Delcare a parameter to mask the RAM address
    parameter RAMAddrMask = 127; //Equivalent to 0111111 in binary
    
    //Tristate
    wire [7:0] BufferedBusData;
    reg [7:0] Out;
    reg RAMBusWE;
    
    //Only place data on the bus if the processor is NOT writing but if it IS addressing this memory
    assign BUS_DATA = (RAMBusWE) ? Out : 8'hZZ;
    assign BufferedBusData = BUS_DATA;
    
    //Memory
    reg [7:0] Mem [2**RAMAddrWidth-1:0];
    
    //Initialise the memory for data preloading, initialising variables, and declaring constants
    initial $readmemh("Complete_Demo_RAM.txt", Mem);
    
    //Single port RAM
    always@(posedge CLK) begin
        //Apply masking to address bus to check if it has value between 0 and 127
        if((BUS_ADDR & (~RAMAddrMask)) == 0) begin
            if (BUS_WE) begin
                Mem[BUS_ADDR[6:0]] <= BufferedBusData;
                RAMBusWE <= 0;
            end else
                RAMBusWE <= 1;
        end else
            RAMBusWE <= 0;
        
        Out <= Mem[BUS_ADDR[6:0]];
    end
    
endmodule
