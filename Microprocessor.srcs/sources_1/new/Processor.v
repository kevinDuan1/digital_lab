`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2024 22:06:57
// Design Name: 
// Module Name: Processor
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


module Processor(
    //Standard signals
    input CLK,
    input RESET,
    //BUS signals
    inout [7:0] BUS_DATA,
    output [7:0] BUS_ADDR,
    input BUS_WE,
    //ROM signals
    output [7:0] ROM_ADDRESS,
    input [7:0] ROM_DATA,
    //INTERRUPT signals
    input [1:0] BUS_INTERRUPTS_RAISE,
    output [1:0] BUS_INTERRUPTS_ACK
    
//    //for testbench
//    output [7:0] RegA,
//    output [7:0] RegB,
//    output [7:0] CURR_STATE
    );
    
//    //for testbench
//    assign RegA = CurrRegA;
//    assign RegB = CurrRegB;
//    assign CURR_STATE = CurrProgCounter;
    
    //The main data bus is treated as tristate, so we need a mechanism to handle this
    //Tristate signals that interface with the main SM
    wire [7:0] BusDataIn;
    reg [7:0] CurrBusDataOut, NextBusDataOut;
    reg CurrBusDataOutWE, NextBusDataOutWE;
    
    //Tristate mechanism
    assign BusDataIn = BUS_DATA;
    assign BUS_DATA = (CurrBusDataOutWE) ? CurrBusDataOut : 8'hZZ;
    assign BUS_WE = CurrBusDataOutWE;
    
    //Address of the bus
    reg [7:0] CurrBusAddr, NextBusAddr;
    assign BUS_ADDR = CurrBusAddr;
    
    //The processor has 2 internal registers to hold data between operation and a 3rd to hold
    //the current program context when using function calls
    reg [7:0] CurrRegA, NextRegA;
    reg [7:0] CurrRegB, NextRegB;
    reg CurrRegSelect, NextRegSelect;
    reg [7:0] CurrProgContext, NextProgContext;
    
    //Dedicated interrupt output lines - one for each interrupted line
    reg [1:0] CurrInterruptAck, NextInterruptAck;
    assign BUS_INTERRUPTS_ACK = CurrInterruptAck;
    
    //Instantiate program memory here
    //There is a program counter which points to the current operation
    //The program counter has an offset that is used to reference informationthat is part of the
    //current operation
    reg [7:0] CurrProgCounter, NextProgCounter;
    reg [1:0] CurrProgCounterOffset, NextProgCounterOffset;
    wire [7:0] ProgMemoryOut;
    wire [7:0] ActualAddress;
    assign ActualAddress = CurrProgCounter + CurrProgCounterOffset;
    
    //ROM signals
    assign ROM_ADDRESS = ActualAddress;
    assign ProgMemoryOut = ROM_DATA;
    
    //Instantiate the ALU
    //The processor has an integarted ALU that can do several different operations
    wire [7:0] AluOut;
    
    ALU ALU0 (
        .CLK(CLK),
        .RESET(RESET),
        .IN_A(CurrRegA),
        .IN_B(CurrRegB),
        .ALU_Op_Code(ProgMemoryOut[7:4]),
        .OUT_RESULT(AluOut)
        );
    
    //The microprocessor is essentially a SM with 1 sequential pipeline of states for each operation
    //Current list of operation:
    //0: Read from Mem to A
    //1: Read from Mem to B
    //2: Write from A to Mem
    //3: Write from B to Mem
    //4: Do maths with the ALU and save result in reg A
    //5: Do maths with the ALU and save result in reg B
    //6: If A==B or A>B or A<B go to ADDR
    //7: Go to ADDR
    //8: Go to IDLE
    //9: End thread, go to IDLE state and wait for interrupt
    //10: Function call
    //11: Return from function call
    //12: Dereference A
    //13: Dereference B
    
    parameter [7:0] //Program thread selection
    
    IDLE = 8'hF0, //Waits here until an interrupt wakes up the processor
    
    GET_THREAD_START_ADDR_0 = 8'hF1, //Wait
    GET_THREAD_START_ADDR_1 = 8'hF2, //Apply the new address to the program counter
    GET_THREAD_START_ADDR_2 = 8'hF3, //Wait. Go to ChooseOP
    
    //Operation selection
    //Depending on the value of ProgMemOut, go to one of the instruction start states
    CHOOSE_OPP = 8'h00,
    
    //Data flow
    READ_FROM_MEM_TO_A = 8'h10, //Wait to find what address to read then save reg select
    READ_FROM_MEM_TO_B = 8'h11, //Wait to find what address to read then save reg select
    READ_FROM_MEM_0 = 8'h12, //Set BUS_ADDR to designated address
    READ_FROM_MEM_1 = 8'h13, //Wait - increments program counter by 2. Reset offset
    READ_FROM_MEM_2 = 8'h14, //Writes memory output to chosen register then end op
    
    WRITE_TO_MEM_FROM_A = 8'h20, //Read Op + 1 to find what address to write to
    WRITE_TO_MEM_FROM_B = 8'h21, //Read Op + 1 to find what address to write to
    WRITE_TO_MEM_0 = 8'h22, //Wait - increments program counter by 2. Reset offset
    
    //Data manipulation
    DO_MATHS_OPP_SAVE_IN_A = 8'h30, //The result of maths op is available then save it to reg A
    DO_MATHS_OPP_SAVE_IN_B = 8'h31, //The result of maths op is available then save it to reg B
    DO_MATHS_OPP_0 = 8'h32, //Wait for new op address to settle then end op
    
    IF_A_EQUALITY_B_GOTO = 8'h40, //Conditional state to determine which branch to go to
    IF_A_EQUALITY_B_GOTO_BREQ = 8'h41, //Put the addess of the branch to the prog counter 
    IF_A_EQUALITY_B_GOTO_BGTQ = 8'h42, //Put the addess of the branch to the prog counter
    IF_A_EQUALITY_B_GOTO_BLTQ = 8'h43, //Put the addess of the branch to the prog counter
    IF_A_EQUALITY_B_GOTO_0 = 8'h44, //Wait for new op addres to settle then end op
    
    GOTO = 8'h50, //Go to the specified address
    GOTO_0 = 8'h51, //Wait for address to be available
    GOTO_1 = 8'h52, //Wait for new op address to settle then add up
    
    GOTO_IDLE = 8'h54, //Go to the IDLE state
    
    FUNCTION_START = 8'h60, //Function call at address and save the next prog counter
    FUNCTION_START_0 = 8'h61, //Wait for address to be available
    FUNCTION_START_1 = 8'h62, //Wait for new op address to settle then end op
    
    RETURN = 8'h63, //Return from function and load prog counter from context
    RETURN_0 = 8'h64, //Wait for new op address to settle then end op
    
    DE_REFERENCE_A = 8'h70, //Mem access through reg A
    DE_REFERENCE_B = 8'h71, //Mem access through reg B
    DE_REFERENCE_0 = 8'h72, //Wait for RAM value to arrive
    DE_REFERENCE_1 = 8'h73; //Write data from bus to the correct register
    
    //Sequential part of the State Machine
    reg [7:0] CurrState, NextState;
    
    always@(posedge CLK) begin
        if (RESET) begin
            CurrState = 8'h00;
            CurrProgCounter = 8'h00;
            CurrProgCounterOffset = 2'h0;
            CurrBusAddr = 8'hFF; //Initial instruction after reset
            CurrBusDataOut = 8'h00;
            CurrBusDataOutWE = 1'b0;
            CurrRegA = 8'h00;
            CurrRegB = 8'h00;
            CurrRegSelect = 1'b0;
            CurrProgContext = 8'h00;
            CurrInterruptAck = 2'b00;
        end else begin
            CurrState = NextState;
            CurrProgCounter = NextProgCounter;
            CurrProgCounterOffset = NextProgCounterOffset;
            CurrBusAddr = NextBusAddr;
            CurrBusDataOut = NextBusDataOut;
            CurrBusDataOutWE = NextBusDataOutWE;
            CurrRegA = NextRegA;
            CurrRegB = NextRegB;
            CurrRegSelect = NextRegSelect;
            CurrProgContext = NextProgContext;
            CurrInterruptAck = NextInterruptAck;
        end
    end
    
    //Combinatorial section - large!
    always@* begin
        //Generic assignment to reduce the complexity of the rest of the SM
        NextState = CurrState;
        NextProgCounter = CurrProgCounter;
        NextProgCounterOffset = 2'h0;
        NextBusAddr = 8'hFF;
        NextBusDataOut = CurrBusDataOut;
        NextBusDataOutWE = 1'b0;
        NextRegA = CurrRegA;
        NextRegB = CurrRegB;
        NextRegSelect = CurrRegSelect;
        NextProgContext = CurrProgContext;
        NextInterruptAck = 2'b00;
        
        //Case statement to describe each state
        case (CurrState)
            //Thread states
            IDLE: begin
                if(BUS_INTERRUPTS_RAISE[0]) begin //Interrupt Request A
                    NextState = GET_THREAD_START_ADDR_0;
                    NextProgCounter = 8'hFF;
                    NextInterruptAck = 2'b01;
                end else if(BUS_INTERRUPTS_RAISE[1]) begin //Interrupt Request B
                    NextState = GET_THREAD_START_ADDR_0;
                    NextProgCounter = 8'hFE;
                    NextInterruptAck = 2'b10;
                end else begin
                    NextState = IDLE;
                    NextProgCounter = 8'hFF;
                    NextInterruptAck = 2'b00;
                end
            end
            
            //Wait state - for new prog address to arrive
            GET_THREAD_START_ADDR_0:
                NextState = GET_THREAD_START_ADDR_1;
            
            //Assign the new program counter value
            GET_THREAD_START_ADDR_1: begin
                NextState = GET_THREAD_START_ADDR_2;
                NextProgCounter = ProgMemoryOut;
            end
            
            //Wait for the new program counter value to settle
            GET_THREAD_START_ADDR_2:
                NextState = CHOOSE_OPP;
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //CHOOSE_OPP - another case statement to choose which operation to perform
            CHOOSE_OPP: begin
                case(ProgMemoryOut[3:0])
                    4'h0:
                        NextState = READ_FROM_MEM_TO_A;
                    4'h1:
                        NextState = READ_FROM_MEM_TO_B;
                    4'h2:
                        NextState = WRITE_TO_MEM_FROM_A;
                    4'h3:
                        NextState = WRITE_TO_MEM_FROM_B;
                    4'h4:
                        NextState = DO_MATHS_OPP_SAVE_IN_A;
                    4'h5:
                        NextState = DO_MATHS_OPP_SAVE_IN_B;
                    4'h6:
                        NextState = IF_A_EQUALITY_B_GOTO;
                    4'h7:
                        NextState = GOTO;
                    4'h8:
                        NextState = IDLE;
                    4'h9:
                        NextState = FUNCTION_START;
                    4'hA:
                        NextState = RETURN;
                    4'hB:
                        NextState = DE_REFERENCE_A;
                    4'hC:
                        NextState = DE_REFERENCE_B;
                    default:
                        NextState = CurrState;
                endcase
                NextProgCounterOffset = 2'h1;
            end
            
            //READ_FROM_MEM_TO_A starts the memory read operational pipeline
            //Wait state to give time for the mem address to be read
            //Reg select is set to 0
            READ_FROM_MEM_TO_A: begin
                NextState = READ_FROM_MEM_0;
                NextRegSelect = 1'b0;
            end
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //READ_FROM_MEM_TO_B starts the memory read operational pipeline
            //Wait state to give time for the mem address to be read
            //Reg select is set to 1
            READ_FROM_MEM_TO_B: begin
                NextState = READ_FROM_MEM_0;
                NextRegSelect = 1'b1;
            end
            
            //The address will be valid during this state so set the BUS_ADDR to this value
            READ_FROM_MEM_0: begin
                NextState = READ_FROM_MEM_1;
                NextBusAddr = ProgMemoryOut;
            end
            
            //Wait state to give time for the mem data to be read
            //Increment the program counter here
            //Must be done 2 clock cycles ahead so that it presents the right data when required
            READ_FROM_MEM_1: begin
                NextState = READ_FROM_MEM_2;
                NextProgCounter = CurrProgCounter + 2;
            end
            
            //The data will now have arrived from memory
            //Write it to the proper register
            READ_FROM_MEM_2: begin
                NextState = CHOOSE_OPP;
                if(!CurrRegSelect)
                    NextRegA = BusDataIn;
                else
                    NextRegB = BusDataIn;
            end
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //WRITE_TO_MEM_A starts the memory write operational pipeline
            //Wait state - to find the address of where we are writing
            //Increment the program counter here
            //Must be done 2 clock cycles ahead so that it presents the right data when required
            WRITE_TO_MEM_FROM_A: begin
                NextState = WRITE_TO_MEM_0;
                NextRegSelect = 1'b0;
                NextProgCounter = CurrProgCounter + 2;
            end
            
            //WRITE_TO_MEM_B starts the memory write operational pipeline
            //Wait state - to find the address of where we are writing
            //Increment the program counter here
            //Must be done 2 clock cycles ahead so that it presents the right data when required
            WRITE_TO_MEM_FROM_B: begin
                NextState = WRITE_TO_MEM_0;
                NextRegSelect = 1'b1;
                NextProgCounter = CurrProgCounter + 2;
            end
            
            //The address will be valid during this state so set BUS_ADDR to this value and write the 
            //value to the memory location
            WRITE_TO_MEM_0: begin
                NextState = CHOOSE_OPP;
                NextBusAddr = ProgMemoryOut;
                if(!NextRegSelect)
                    NextBusDataOut = CurrRegA;
                else
                    NextBusDataOut = CurrRegB;
                
                NextBusDataOutWE = 1'b1;
            end
            
            //////////////////////////////////////////////////////////////////////////////////
                        
            //DO_MATHS_OPP_SAVE_IN_A starts the DoMaths operational pipeline
            //Reg A and Reg B must already be set to desired values
            //MSBs of the operation type determines the maths operation type
            //At this stage, result ready to collect from ALU
            DO_MATHS_OPP_SAVE_IN_A: begin
                NextState = DO_MATHS_OPP_0;
                NextRegA = AluOut;
                NextProgCounter = CurrProgCounter + 1;
            end
            
            //DO_MATHS_OPP_SAVE_IN_B starts the DoMaths operational pipeline when
            //the result will go into reg B
            DO_MATHS_OPP_SAVE_IN_B: begin
                NextState = DO_MATHS_OPP_0;
                NextRegB = AluOut;
                NextProgCounter = CurrProgCounter + 1;
            end
            
            //Wait state for new prog address to settle
            DO_MATHS_OPP_0:
                NextState = CHOOSE_OPP;
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //Starts the Equality operational pipeline
            //Checks the 4 most significant bits of the instruction structure
            //and see whether it goes to BREQ, BGTQ or BLTQ
            IF_A_EQUALITY_B_GOTO: begin
                if (ProgMemoryOut [7:4] == 4'b1001)
                    NextState = IF_A_EQUALITY_B_GOTO_BREQ;
                else if (ProgMemoryOut [7:4] == 4'b1010)
                    NextState = IF_A_EQUALITY_B_GOTO_BGTQ;
                else
                    NextState = IF_A_EQUALITY_B_GOTO_BLTQ;
            end
            
            
            IF_A_EQUALITY_B_GOTO_BREQ: begin
                NextState = IF_A_EQUALITY_B_GOTO_0;
                if (CurrRegA == CurrRegB)
                    NextProgCounter = ProgMemoryOut;
                else
                    NextProgCounter = CurrProgCounter + 2;
            end
            
            IF_A_EQUALITY_B_GOTO_BGTQ: begin
                NextState = IF_A_EQUALITY_B_GOTO_0;
                if (CurrRegA > CurrRegB)
                    NextProgCounter = ProgMemoryOut;
                else
                    NextProgCounter = CurrProgCounter + 2;
            end
            
            IF_A_EQUALITY_B_GOTO_BLTQ: begin
                NextState = IF_A_EQUALITY_B_GOTO_0;
                if (CurrRegA < CurrRegB)
                    NextProgCounter = ProgMemoryOut;
                else
                    NextProgCounter = CurrProgCounter + 2;
            end
            
            IF_A_EQUALITY_B_GOTO_0:
                NextState = CHOOSE_OPP;
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //Starts the GOTO Addr operational pipeline
            //Assign new address to prog counter and move along the program
            GOTO:
                NextState = GOTO_0;
            
            GOTO_0: begin
                NextState = GOTO_1;
                NextProgCounter = ProgMemoryOut;
            end
            
            GOTO_1:
                NextState = CHOOSE_OPP;
            
            GOTO_IDLE:
                NextState = IDLE;
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //Starts the function call operational pipeline
            //Save prog counter of return position and move to address
            FUNCTION_START: begin
                NextState = FUNCTION_START_0;
                NextProgContext = CurrProgCounter + 2;
           end
            
            FUNCTION_START_0: begin
                NextState = FUNCTION_START_1;
                NextProgCounter = ProgMemoryOut;
            end
            
            FUNCTION_START_1:
                NextState = CHOOSE_OPP;
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //Starts the return from function call operational pipeline
            //Restore prog counter from prog context
            RETURN: begin
                NextState = RETURN_0;
                NextProgCounter = CurrProgContext;
            end
            
            RETURN_0:
                NextState = CHOOSE_OPP;
            
            //////////////////////////////////////////////////////////////////////////////////
            
            //Starts the dereference operational pipeline
            //Get indirect memory access
            //Value in register treated as an addr to the desired value
            //Essentially, a pointer that points the value of the RAM addr that is stored in reg
            //then saves this value to the reg
            DE_REFERENCE_A: begin
                NextState = DE_REFERENCE_0;
                NextRegSelect = 1'b0;
                NextBusAddr = CurrRegA;
            end
            
            DE_REFERENCE_B: begin
                NextState = DE_REFERENCE_0;
                NextRegSelect = 1'b1;
                NextBusAddr = CurrRegB;
            end
            
            DE_REFERENCE_0: begin
                NextState = DE_REFERENCE_1;
                NextProgCounter = CurrProgCounter + 1;
            end
            
            DE_REFERENCE_1: begin
                NextState = CHOOSE_OPP;
                if(!CurrRegSelect)
                    NextRegA = BusDataIn;
                else
                    NextRegB = BusDataIn;
            end
            
        endcase
    end
                
endmodule
