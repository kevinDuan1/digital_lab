`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2024 20:27:43
// Design Name: 
// Module Name: Seven_Seg_Driver
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


module Seven_Seg_Driver (
    //standard signals
    input CLK,
    input RESET,

    //BUS signals
    inout [7:0] BUS_DATA,
    input [7:0] BUS_ADDR,
    
    //Display
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT
    );

    // Memory address space
    parameter [7:0] SevenSegAddr = 8'hD0; // Timer Base Address in the Memory Map
    reg [7:0] X_DATA, Y_DATA;   

    // read the X_DATA and Y_DATA if the address is the SevenSegAddr and SevenSegAddr + 1
    always @(posedge CLK) begin
        if (RESET) begin
            X_DATA <= 8'h00;
            Y_DATA <= 8'h00;
        end else begin
            if (BUS_ADDR == SevenSegAddr) begin
                X_DATA <= BUS_DATA;                
            end else if (BUS_ADDR == SevenSegAddr + 8'h01) begin
                Y_DATA <= BUS_DATA;                
            end
        end
    end

    // Display module
    Register_display RD(
        //Standard Inputs
        .CLK(CLK),
        .RESET(RESET),
        //Mouse Data
        .MouseX(X_DATA),
        .MouseY(Y_DATA),
        //Display
        .SEG_SELECT(SEG_SELECT),
        .DEC_OUT(DEC_OUT)
    );
    
endmodule
