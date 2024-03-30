`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Harysh Tan Ravy
// 
// Create Date: 23.01.2024 11:23:04
// Design Name: 
// Module Name: TENHz_Counter2
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


module TENHz_Counter2(
    input CLK,
    input RESET,
    //Declare SEND_PACKET as a register to store values that will be used
    //in an always statement
    output reg SEND_PACKET
    );
    
    //Creat a register to store values of a clock cycle counter
    reg [23:0] Counter;
    
    //Generate 10Hz SEND_PACKET signal
    always@(posedge CLK) begin
        if (RESET)
            Counter <= 0;
        else begin
            //Logic for whether 10000000 clock cycles has been reached
            if (Counter == 10000000) begin
                Counter <= 0;
                SEND_PACKET <= 1; //SEND_PACKET signal produced every 10000000 clock cycle to produce frequency 10Hz
            end 
            else begin
                Counter <= Counter + 1; //Continute coutning clock signals
                SEND_PACKET <= 0;
            end
        end
    end
    
endmodule
