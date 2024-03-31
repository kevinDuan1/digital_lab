`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2024 11:43:46
// Design Name: 
// Module Name: VGA_Sig_Gen
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


module VGA_Sig_Gen(
    input CLK,
    input RESET,
// colour configuration interface
    input [15:0] CONFIG_COLOURS,
// frame buffer interface
    output DPR_CLK,
    output [14:0] VGA_ADDR,
    input VGA_DATA,
// VGA port iterface
    output reg VGA_HS,  // horizontal sync
    output reg VGA_VS,  // vertical sync
    output reg [7:0] VGA_COLOUR
    );
    
    // quarter clock speed for VGA display
    wire VGA_CLK;
    Counter # (.COUNTER_WIDTH(3),
               .COUNTER_MAX(3))
               CounterCLK (
                        .CLK(CLK),
                        .RESET(1'b0),
                        .ENABLE_IN(1'b1),
                        .TRIG_OUT(VGA_CLK));

    
    // define VGA signal parameters
    //Vertical timing parameters.
    parameter VTPulseWidthEnd = 10'd2;
    parameter VTBackPorchEnd = 10'd31;
    parameter VTDisplayTimeEnd = 10'd511;
    parameter VTFrontPorchEnd = 10'd521;
    
    //Horizontal timing parameters
    parameter HTPulseWidthEnd = 10'd96;
    parameter HTBackPorchEnd = 10'd144;
    parameter HTDisplayTimeEnd = 10'd784;
    parameter HTFrontPorchEnd = 10'd800;

    
    // Define Horizontal and Vertical Counters to generate the VGA signals
    wire [9:0] HCounter;
    wire [9:0] VCounter;
    wire TRIGH;
    reg [9:0] ADDRH;
    reg [8:0] ADDRV;

    
    // Assigns horizontal and vertical values for raster scan of the display 
    Counter # (.COUNTER_WIDTH(10),
               .COUNTER_MAX(HTFrontPorchEnd))
               CounterH (
                        .CLK(VGA_CLK),
                        .RESET(1'b0),
                        .ENABLE_IN(1'b1),
                        .TRIG_OUT(TRIGH),
                        .COUNT(HCounter));
                        
    Counter # (.COUNTER_WIDTH(10),
               .COUNTER_MAX(VTFrontPorchEnd))
               CounterV (
                        .CLK(VGA_CLK),
                        .RESET(1'b0),
                        .ENABLE_IN(TRIGH),
                        .COUNT(VCounter));
    
    // Create address of next pixel. Concatenate and tie the lookahead address to the frame buffer address
    
    assign DPR_CLK = VGA_CLK;
    assign VGA_ADDR = {ADDRV[8:2], ADDRH[9:2]};
    

                  
    // HS
    always@(posedge CLK) begin
        if (HCounter <= HTPulseWidthEnd)
            VGA_HS <= 0;
        else
            VGA_HS <= 1;
     end
     
    //VS
    always@(posedge CLK) begin
        if (VCounter <= VTPulseWidthEnd)
            VGA_VS <= 0;
        else
            VGA_VS <= 1;
    end
    
        always@(posedge VGA_CLK) begin
        if ((VCounter >= VTBackPorchEnd) && (VCounter <= VTDisplayTimeEnd))
             ADDRV <= VCounter - VTBackPorchEnd;
        else 
            ADDRV <= 0;
    end
    
    always@(posedge VGA_CLK) begin
        if ((HCounter >= HTBackPorchEnd) && (HCounter <= HTDisplayTimeEnd))
            ADDRH <= HCounter - HTBackPorchEnd;
        else 
            ADDRH <= 0;
    end

    
    //COLOUR OUT    
    always@(posedge CLK) begin
        if (((HCounter >= HTBackPorchEnd)&&(HCounter <= HTDisplayTimeEnd))&&((VCounter >= VTBackPorchEnd)&&(VCounter <= VTDisplayTimeEnd)))
            if (VGA_DATA)
               VGA_COLOUR <= CONFIG_COLOURS[15:8];
            else
               VGA_COLOUR <= CONFIG_COLOURS[7:0];
        else
            VGA_COLOUR <= 8'h00;     
    end
    
    
endmodule


