`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Edinburgh
// Engineer: Harysh Tan Ravy
// 
// Create Date: 23.01.2024 09:27:06
// Design Name: 
// Module Name: IRTransmitterSM2
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


module IRTransmitterSM2(
    input CLK,
    input RESET,
    input [3:0] COMMAND,
    input SEND_PACKET,
    //Declare IR_LED as a register to store values that will be used
    //in an always statement
    output reg IR_LED
    );
    
    //Declare the parameters of the Yellow car packet regions
    parameter StartBurstSize = 88;
    parameter GapSize = 40;
    parameter CarSelectBurstSize = 22;
    parameter AssertBurstSize = 44;
    parameter DeAssertBurstSize = 22;
    
    //Declare the parameter of the ratio of clock freq to pulse freq
    //to determine the number of clock cycles every pulse cycle to produce 
    //a pulse freq of 40kHz from the 100MHz clock
    parameter CLKratio = 2500;
    
    //Create registers to store values of the 40kHz pulse counter and pulse
    //signal
    //Initialise them to be 0
    reg [11:0] Pulse_Counter = 0;
    reg pulse = 0;
    
    //Generate 40kHz pulse
    always@(posedge CLK) begin
        if (RESET) begin
            Pulse_Counter <= 0;
            pulse <= 0;
        end
        else begin
            if (Pulse_Counter == (CLKratio/2 -1)) begin 
                Pulse_Counter <= 0;
                pulse <= ~pulse; //Every 1250 clock cycles, invert pulse signal to produce pulses with a period of 2500 cycles and freq of 40kHz
            end
            else begin
                Pulse_Counter <= Pulse_Counter + 1;
            end
        end
    end
    
    //Declare parameters of the states of the SM
    //Declare separate GAP states for specific previous states rather than single GAP state
    parameter IDLE = 4'b0000;
    parameter START = 4'b0001;
    parameter GAP_start = 4'b0010;
    parameter CAR_SELECT = 4'b0011;
    parameter GAP_carselect = 4'b0100;
    parameter RIGHT = 4'b0101;
    parameter GAP_right = 4'b0110;
    parameter LEFT = 4'b0111;
    parameter GAP_left = 4'b1000;
    parameter BACKWARD = 4'b1001;
    parameter GAP_backward = 4'b1010;
    parameter FORWARD = 4'b1011;
    parameter GAP_forward = 4'b1100;
    
    //Create registers to store the values of the current and next states
    reg [3:0] Curr_State;
    reg [3:0] Next_State;
    
    //Create registers to store values of the clock signal counter and
    //clock reset signal 
    reg [26:0] CLK_Counter = 0;
    reg CLK_Reset;
    
    //Create logic to count clock signals that will be applied to IR packet regions
    always@(posedge CLK) begin
        if (RESET)
            CLK_Counter <= 0;
        else begin
            if (CLK_Reset == 1)
                CLK_Counter <= 0;
            else
                CLK_Counter <= CLK_Counter + 1;
        end
    end
    
    //Create the sequential logic for the SM
    always@(posedge CLK) begin
        if (RESET)
            Curr_State <= IDLE;
        else
            Curr_State <= Next_State;
    end
    
    //Create SM logic for each state
    always @* begin
        case (Curr_State)
            //IDLE state to wait for SEND_PACKET signal
            IDLE: begin
                CLK_Reset <= 1; //Keeps clock counter at 0
                IR_LED <= 0; //No IR signal transmitted
                
                if (SEND_PACKET == 1) 
                    Next_State <= START; //Next state moves to START state when SEND_PACKET signal received
                else 
                    Next_State <= Curr_State; //Remain in IDLE state if no SEND_PACKET signal received
            end
            
            //START state to produce Start packet region
            START: begin
                IR_LED <= pulse; //IR signal follows 40kHz pulse signals
                
                //Logic for whether 88 40kHz pulse cycles produced
                //(88 40kHz pulse cycles is the same as 88x2500 100MHz clock cycles)
                if (CLK_Counter == (StartBurstSize * CLKratio) - 1) begin
                    CLK_Reset <= 1; //Reset clock counter to 0
                    Next_State <= GAP_start; //Next state is GAP state
                end
                else begin
                    CLK_Reset <= 0; //Keep counting clock cycles
                    Next_State <= Curr_State;
                end
            end
            
            //GAP state after START state to produce Gap packet region
            GAP_start: begin
                IR_LED <= 0; //No IR signaL transmitted
                
                //Logic for whether 40 40kHz pulse cycles produced
                if (CLK_Counter == (GapSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= CAR_SELECT;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //CAR_SELECT state to produce Car Select pacekt region
            CAR_SELECT: begin
                IR_LED <= pulse;
                
                //Logic for whether 22 40kHz pulse cycles produced
                if (CLK_Counter == (CarSelectBurstSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= GAP_carselect;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //GAP state after CAR_SELECT state to produce Gap packet region
            GAP_carselect: begin
                IR_LED <= 0;
                
                //Logic for whether 40 40kHz pulse cycles produced
                if (CLK_Counter == (GapSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= RIGHT;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //RIGHT state to produce Start packet region
            RIGHT: begin
                IR_LED <= pulse;
                
                //1st bit of COMMAND input determines assert/de-assert of right direction
                if (COMMAND[0] == 1) begin //Assert
                    //Logic for whether 44 40kHz pulse cycles produced
                    if (CLK_Counter == (AssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_right;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
                else begin //De-assert
                    //Logic for whether 22 40kHz pulse cycles produced
                    if (CLK_Counter == (DeAssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_right;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
            end
            
            //GAP state after RIGHT state to produce Gap packet region
            GAP_right: begin
                IR_LED <= 0;
                
                //Logic for whether 40 40kHz pulse cycles produced
                if (CLK_Counter == (GapSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= LEFT;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //LEFT state to produce Start packet region
            LEFT: begin
                IR_LED <= pulse;
                
                //2nd bit of COMMAND input determines assert/de-assert of left direction
                if (COMMAND[1] == 1) begin //Assert
                    //Logic for whether 44 40kHz pulse cycles produced
                    if (CLK_Counter == (AssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_left;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
                else begin //De-assert
                    //Logic for whether 22 40kHz pulse cycles produced
                    if (CLK_Counter == (DeAssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_left;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
            end
               
            //GAP state after LEFT state to produce Gap packet region         
            GAP_left: begin
                IR_LED <= 0;
                
                //Logic for whether 40 40kHz pulse cycles produced
                if (CLK_Counter == (GapSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= BACKWARD;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //BACKWARD state to produce Start packet region
            BACKWARD: begin
                IR_LED <= pulse;
                
                //3rd bit of COMMAND input determines assert/de-assert of backward direction
                if (COMMAND[2] == 1) begin //Assert
                    //Logic for whether 44 40kHz pulse cycles produced
                    if (CLK_Counter == (AssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_backward;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
                else begin //De-assert
                    //Logic for whether 22 40kHz pulse cycles produced
                    if (CLK_Counter == (DeAssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_backward;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
            end
            
            //GAP state after BACKWARD state to produce Gap packet region
            GAP_backward: begin
                IR_LED <= 0;
                
                //Logic for whether 40 40kHz pulse cycles produced
                if (CLK_Counter == (GapSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= FORWARD;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //FORWARD state to produce Start packet region
            FORWARD: begin
                IR_LED <= pulse;
                
                //4th bit of COMMAND input determines assert/de-assert of forward direction
                if (COMMAND[3] == 1) begin //Assert
                    //Logic for whether 44 40kHz pulse cycles produced
                    if (CLK_Counter == (AssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_forward;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
                else begin //De-assert
                    //Logic for whether 22 40kHz pulse cycles produced
                    if (CLK_Counter == (DeAssertBurstSize * CLKratio) - 1) begin
                        CLK_Reset <= 1;
                        Next_State <= GAP_forward;
                    end
                    else begin
                        CLK_Reset <= 0;
                        Next_State <= Curr_State;
                    end
                end
            end
            
            //GAP state after FORWARD state to produce Gap packet region
            GAP_forward: begin
                IR_LED <= 0;
                
                //Logic for whether 40 40kHz pulse cycles produced
                if (CLK_Counter == (GapSize * CLKratio) - 1) begin
                    CLK_Reset <= 1;
                    Next_State <= IDLE;
                end
                else begin
                    CLK_Reset <= 0;
                    Next_State <= Curr_State;
                end
            end
            
            //Default state conditions
            default: begin
                CLK_Reset <= 1;
                IR_LED <= 0;
                Next_State <= IDLE;
            end            
        endcase
    end

    
endmodule
