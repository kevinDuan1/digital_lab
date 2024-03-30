`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2024 18:34:25
// Design Name: 
// Module Name: VGA_Interface
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


module VGA_Interface(
    input CLK,
    input RESET,
    inout [7:0]BUS_DATA,
    input [7:0]BUS_ADDRESS,
    output HS,
    output VS,
    output [7:0] VGA_Colour);
    
    wire[14:0] VGA_ADDR_A;      // VGA address sent to frame buffer from processor
    wire[14:0] VGA_ADDR_B;      // VGA address sent to frame buffer from VGA signal generator
    reg [7:0] VGA_ADDRH_A;      // To store horizontal address         
    reg [6:0] VGA_ADDRV_A;      // To store vertical address 
    reg PIXEL_DATA_IN;          // Pixel data to be stored in frame buffer
    wire PIXEL_DATA_OUT;        // Pixel data output from frame buffer to VGA signal generator
    wire VGA_CLK;               // VGA clock at 25MHz
    wire [15:0] Config_Colours; // Background and foreground colours
    reg A_WE;                   // Write enable for frame buffer
    reg [7:0] X_VAL=0;           // X axis data assigned form data bus
    reg [6:0] Y_VAL=0;           // Y axis data assigned form data bus
    reg [15:0] Colours=16'h00FF;
    wire C_CLK; 
        

    assign VGA_ADDR_A = {Y_VAL, X_VAL};     // combine X and Y values into address
    assign VGA_ADDR_B = {VGA_ADDRV_A, VGA_ADDRH_A};
    assign Config_Colours = Colours;       // Initialise config colours to black and white
    
    Frame_Buffer # ()                       // Instantiate frame buffer
                Frame_Buffer(
                             .A_CLK(CLK),
                             .A_ADDR(VGA_ADDR_A),
                             .A_DATA_IN(PIXEL_DATA_IN),
                             .A_DATA_OUT(PIXEL_DATA_OUT),
                             .A_WE(A_WE),
                             .B_CLK(VGA_CLK),
                             .B_ADDR(VGA_ADDR_B),
                             .B_DATA(PIXEL_DATA_B));
                             
    VGA_Sig_Gen # ()                        // Instantiate VGA signal generator
                VGA_Sig_Gen(
                            .CLK(CLK),
                            .RESET(RESET),
                            .CONFIG_COLOURS(Config_Colours),
                            .DPR_CLK(VGA_CLK),
                            .VGA_ADDR(VGA_ADDR_B),
                            .VGA_DATA(PIXEL_DATA_B),
                            .VGA_HS(HS),
                            .VGA_VS(VS),
                            .VGA_COLOUR(VGA_Colour));
                            

    Counter # (.COUNTER_WIDTH(27),
                       .COUNTER_MAX(99999999)
                       )
                       
                       Colour_Counter
                       (
                       .CLK(CLK),
                       .RESET(RESET),
                       .ENABLE_IN(1'b1),
                       .TRIG_OUT(C_CLK)
                       );
    
    
    //Change foregrounf
    always@(posedge C_CLK) begin
            Colours <= Colours + 16'b0000001000000001;
    end


    always@(posedge CLK) begin
            if (BUS_ADDRESS == 8'hB0)               // Base address
                    X_VAL <= BUS_DATA;              // Assign bus data to X values
            else if (BUS_ADDRESS == 8'hB1)
                    Y_VAL <= BUS_DATA[6:0];         // Assign bus data to Y values
            else if(BUS_ADDRESS == 8'hB2) begin     // High address
                    A_WE <= 1'b1;                   // Enable writing to frame buffer
                    PIXEL_DATA_IN <= BUS_DATA[0];   // Assign LSB of bus data to pixel data register
            end        
            else begin                              // For when address is not indicating to VGA
                    A_WE <= 1'b0;                   // Disable writing to frame buffer
                    PIXEL_DATA_IN <= PIXEL_DATA_IN; // Maintain the pixel data value
                    X_VAL <= X_VAL;                 // Maintain x and y values
                    Y_VAL <= Y_VAL;
            end
    end

    
    
    
endmodule
