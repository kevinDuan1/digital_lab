`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 12:29:51
// Design Name: 
// Module Name: MouseReceiver
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
module Register_display(
    // Standard Inputs
    input CLK,
    input RESET,
    input [7:0] MouseX,
    input [7:0] MouseY, 
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT
);

    // counters 
    wire Bit17TriggerOut;
    wire [1:0] Bit2Select;

    //17 bits counter
    Generic_counter # (.COUNTER_WIDTH(17),
                       .COUNTER_MAX(99999) 
                       )
                       Bit17Counter(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE(1'b1),
                        .TRIG_OUT(Bit17TriggerOut)
                       );

    //2 bits counter 
    Generic_counter #(.COUNTER_WIDTH(2),
                      .COUNTER_MAX(3)
                      )
                      Bit2Counter(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE(Bit17TriggerOut),
                        .COUNT(Bit2Select)
                      );
    // MUX
    wire [4:0] MuxOut;
    MUX_2_4 Mux4(
        .CONTROL(Bit2Select),
        .IN0({1'b0, MouseY[3:0]}),
        .IN1({1'b0, MouseY[7:4]}),
        .IN2({1'b0, MouseX[3:0]}),
        .IN3({1'b0, MouseX[7:4]}),
        .OUT(MuxOut)
    );

    // 7-segment decoder
    seg7decoder decoder(
        .SEG_SELECT_IN(Bit2Select),
        .BIN_IN(MuxOut[3:0]),
        .DOT_IN(MuxOut[4]),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(DEC_OUT)
    );

endmodule