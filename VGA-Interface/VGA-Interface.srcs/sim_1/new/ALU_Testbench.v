`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 17:42:40
// Design Name: 
// Module Name: ALU_Testbench
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


module ALU_Testbench();
    //inputs
    reg CLK;
    reg RESET;
    reg [7:0]IN_A;
    reg [7:0]IN_B;
    reg [3:0]ALU_op_Code;
    //outputs
    wire [7:0]OUT_RESULT;
    
    //Instantiate ALU module
    ALU ALU_SIM(
                .CLK(CLK),
                .RESET(RESET),
                .IN_A(IN_A),
                .IN_B(IN_B),
                .ALU_Op_Code(ALU_op_Code),
                .OUT_RESULT(OUT_RESULT)
    );
    
    //Simulate CLK
    always begin
        CLK = 0;  
        forever #10 CLK = ~CLK;
    end
    
    initial begin
    RESET = 1'b1;
        IN_A=8'h00;
        IN_B=8'h00;
        ALU_op_Code=4'h0;
        
    #100
    RESET = 1'b0;
    IN_A=8'h02;
    IN_B=8'h01;
    #100 ALU_op_Code=4'h0;
    #100 ALU_op_Code=4'h1;
    #100 ALU_op_Code=4'h2;
    #100 ALU_op_Code=4'h3;
    #100 ALU_op_Code=4'h4;
    #100 ALU_op_Code=4'h5;
    #100 ALU_op_Code=4'h6;
    #100 ALU_op_Code=4'h7;
    #100 ALU_op_Code=4'h8;
    #100 ALU_op_Code=4'h9;
    #100 ALU_op_Code=4'hA;
    #100 ALU_op_Code=4'hB;
    #100 ALU_op_Code=4'hC;
    #100 ALU_op_Code=4'hD;
    end
    



endmodule
