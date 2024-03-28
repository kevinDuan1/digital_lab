`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Harysh Tan Ravy
// 
// Create Date: 04.03.2024 21:21:52
// Design Name: 
// Module Name: Timer
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


module Timer(
    input CLK,
    input RESET,
    inout [7:0] BUS_DATA,
    input [7:0] BUS_ADDR,
    input BUS_WE,
    output BUS_INTERRUPTS_RAISE,
    input BUS_INTERRUPTS_ACK
    );
    
    parameter [7:0] TimerBaseAddr = 8'hF0; //Timer base address in the memory map
    parameter InitialInterruptRate = 100; //Default interrupt rate leading to 1 interrupt every 100ms
    parameter InitialInterruptEnable = 1'b1; //By default the interrupt is enabled
    
    //////////////////////////////////////////////////////////////////////////////////
    //TimerBaseAddr + 0 -> reports current timer value
    //TimerBaseAddr + 1 -> address of a timer interrupt interval register, 100ms by default
    //TimerBaseAddr + 2 -> resets the timer, count from 0 again
    //TimerBaseAddr + 3 -> address of an interrupt enable register, allow microprocessor to disable timer
    
    //This module will raise an interrupt flag when the designated time is up
    //It will automatically set the time of the next interrupt to the time of the last interrupt
    //plus a configurable value in ms
    
    //////////////////////////////////////////////////////////////////////////////////
    //Interrupt Rate Configuration
    //The rate is initialised to 100ms by the parameter above but can also be set by the processor by writing
    //to mem address TimerBaseAddr + 1
    
    reg [7:0] InterruptRate;
    
    always@(posedge CLK) begin
        if (RESET)
            InterruptRate <= InitialInterruptRate;
        else if ((BUS_ADDR == TimerBaseAddr + 8'h01) & BUS_WE)
            InterruptRate <= BUS_DATA;
    end
    
    //////////////////////////////////////////////////////////////////////////////////
    //Interrupt Enable Configuration
    //If not set to 1, no interrupt created
    
    reg InterruptEnable;
    
    always@(posedge CLK) begin
        if (RESET)
            InterruptEnable <= InitialInterruptEnable;
        else if ((BUS_ADDR == TimerBaseAddr + 8'h03) & BUS_WE)
            InterruptEnable <= BUS_DATA[0];
    end
    
    //////////////////////////////////////////////////////////////////////////////////
    //Down Counter Configuration
    //Lower the clock speed from 100MHz to 1kHz
    
    reg [31:0] DownCounter;
    
    always@(posedge CLK) begin
        if (RESET)
            DownCounter <= 0;
        else begin
            if (DownCounter == 32'd99999)
                DownCounter <= 0;
            else
                DownCounter <= DownCounter + 1'b1;
        end
    end
    
    //////////////////////////////////////////////////////////////////////////////////
    //Now we can record the last time an interrupt was sent and add a value to it to determine
    //if its time to raise the interrupt
    
    //1ms Counter Generation   
    
    reg [31:0] Timer;
    
    always@(posedge CLK) begin
        if (RESET | (BUS_ADDR == TimerBaseAddr + 8'h02))
            Timer <= 0;
        else begin
            if ((DownCounter == 0))
                Timer <= Timer + 1'b1;
            else
                Timer <= Timer;
        end
    end
    
    //Interrupt Generation
    
    reg TargetReached;
    reg [31:0] LastTime;
    
    always@(posedge CLK) begin
        if (RESET) begin
            TargetReached <= 1'b0;
            LastTime <= 0;
        end else if ((LastTime + InterruptRate) == Timer) begin
            if (InterruptEnable)
                TargetReached <= 1'b1;
            LastTime <= Timer;
        end else
            TargetReached <= 1'b0;
    end
    
    //Interrupt Broadcasting
    
    reg Interrupt;
    
    always@(posedge CLK) begin
        if (RESET)
            Interrupt <= 1'b0;
        else if (TargetReached)
            Interrupt <= 1'b1;
        else if (BUS_INTERRUPTS_ACK)
            Interrupt <= 1'b0;
    end
    
    assign BUS_INTERRUPTS_RAISE = Interrupt;
    
    //Tristate output for interrupt timer output value
    
    reg TransmitTimerValue;
    
    always@(posedge CLK) begin
        if (BUS_ADDR == TimerBaseAddr)
            TransmitTimerValue <= 1'b1;
        else
            TransmitTimerValue <= 1'b0;
    end
    
    assign BUS_DATA = (TransmitTimerValue) ? Timer[7:0] : 8'hZZ;            
    
endmodule
