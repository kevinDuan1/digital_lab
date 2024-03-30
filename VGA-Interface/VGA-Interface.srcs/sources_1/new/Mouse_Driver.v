`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2024 20:27:43
// Design Name: 
// Module Name: Mouse_Driver
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


module Mouse_Driver (
    //standard signals
    input CLK,
    input RESET,
    
    //IO - Mouse side
    inout CLK_MOUSE,
    inout DATA_MOUSE,
    input [1:0] sensitivity,

    //BUS signals
    inout [7:0] BUS_DATA,
    input [7:0] BUS_ADDR,
    
    // Interrupts
    output BUS_INTERRUPT_RAISE,
    input BUS_INTERRUPT_ACK,
    output [3:0] MasterStateCode
    );

    // Memory address space
    parameter [7:0] MouseBaseAddr = 8'hA0; // Timer Base Address in the Memory Map
    wire [7:0] MouseStatus;
    wire [7:0] MouseX;
    wire [7:0] MouseY;
    
    // Mouse Transeiver
    wire TargetReached;
    MouseTransceiver Mouse_transceiver(
        .CLK(CLK),
        .RESET(RESET),
        .MouseSensitivity(sensitivity),
        .CLK_MOUSE(CLK_MOUSE),
        .DATA_MOUSE(DATA_MOUSE),
        .Status_BYTE(MouseStatus),
        .X_BYTE(MouseX),  
        .Y_BYTE(MouseY),
        .SendInterrupt(TargetReached),
        .MasterStateCode(MasterStateCode)
    );

    //interrupt 
    reg Interrupt;
    always@(posedge CLK) begin
        if(RESET)
            Interrupt <= 1'b0;
        else if(TargetReached)
            Interrupt <= 1'b1;
        else if(BUS_INTERRUPT_ACK)
            Interrupt <= 1'b0;
    end
    assign BUS_INTERRUPT_RAISE = Interrupt;

    //Tristate output BUS_DATA
    reg TransmitMouseValue, TransmitMouseValue_Next;
    reg [7:0] Mouse_Byte, Mouse_Byte_Next;
    always@(posedge CLK) begin
        if (RESET) begin
            TransmitMouseValue <= 1'b0;
            Mouse_Byte <= 8'h00;
        end
        else begin
            TransmitMouseValue <= TransmitMouseValue_Next;
            Mouse_Byte <= Mouse_Byte_Next;
        end
    end

    always@(*) begin
        case (BUS_ADDR)
            MouseBaseAddr : begin
                TransmitMouseValue_Next = 1'b1;
                Mouse_Byte_Next = MouseStatus;
            end
            MouseBaseAddr + 8'h01 : begin
                TransmitMouseValue_Next = 1'b1;
                Mouse_Byte_Next = MouseX;
            end
            MouseBaseAddr + 8'h02 : begin
                TransmitMouseValue_Next = 1'b1;
                Mouse_Byte_Next = MouseY;
            end
            default: begin
                TransmitMouseValue_Next = 1'b0;
                Mouse_Byte_Next = 8'h00;
            end
        endcase
    end
    assign BUS_DATA = (TransmitMouseValue) ? Mouse_Byte : 8'hZZ;
    
endmodule
