// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Tue Jan 30 15:25:34 2024
// Host        : Peepee running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/Marco/VGA-Interface/VGA-Interface.sim/sim_1/impl/func/VGA_Sig_Gen_func_impl.v
// Design      : VGA_Sig_Gen
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Counter
   (VGA_HS_reg,
    VGA_ADDR_OBUF,
    DPR_CLK_OBUF);
  output VGA_HS_reg;
  output [7:0]VGA_ADDR_OBUF;
  input DPR_CLK_OBUF;

  wire DPR_CLK_OBUF;
  wire [1:0]HCounter;
  wire [7:0]VGA_ADDR_OBUF;
  wire VGA_HS_i_2_n_0;
  wire VGA_HS_reg;
  wire [9:0]count_value;
  wire \count_value[0]_i_2_n_0 ;
  wire \count_value[7]_i_1_n_0 ;
  wire \count_value[8]_i_2_n_0 ;
  wire \count_value[8]_i_3_n_0 ;
  wire \count_value[9]_i_2_n_0 ;
  wire \count_value[9]_i_3_n_0 ;
  wire \count_value[9]_i_4_n_0 ;
  wire \count_value[9]_i_5_n_0 ;

  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF80)) 
    VGA_HS_i_1
       (.I0(VGA_ADDR_OBUF[3]),
        .I1(VGA_ADDR_OBUF[4]),
        .I2(VGA_HS_i_2_n_0),
        .I3(VGA_ADDR_OBUF[6]),
        .I4(VGA_ADDR_OBUF[7]),
        .I5(VGA_ADDR_OBUF[5]),
        .O(VGA_HS_reg));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    VGA_HS_i_2
       (.I0(VGA_ADDR_OBUF[2]),
        .I1(HCounter[0]),
        .I2(VGA_ADDR_OBUF[1]),
        .I3(HCounter[1]),
        .I4(VGA_ADDR_OBUF[0]),
        .O(VGA_HS_i_2_n_0));
  LUT6 #(
    .INIT(64'h00000000FFDFFFFF)) 
    \count_value[0]_i_1 
       (.I0(\count_value[9]_i_4_n_0 ),
        .I1(\count_value[0]_i_2_n_0 ),
        .I2(VGA_ADDR_OBUF[3]),
        .I3(VGA_ADDR_OBUF[2]),
        .I4(VGA_ADDR_OBUF[6]),
        .I5(HCounter[0]),
        .O(count_value[0]));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \count_value[0]_i_2 
       (.I0(VGA_ADDR_OBUF[5]),
        .I1(VGA_ADDR_OBUF[4]),
        .I2(VGA_ADDR_OBUF[7]),
        .I3(VGA_ADDR_OBUF[6]),
        .O(\count_value[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value[1]_i_1 
       (.I0(HCounter[1]),
        .I1(HCounter[0]),
        .O(count_value[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \count_value[2]_i_1 
       (.I0(VGA_ADDR_OBUF[0]),
        .I1(HCounter[1]),
        .I2(HCounter[0]),
        .O(count_value[2]));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \count_value[3]_i_1 
       (.I0(VGA_ADDR_OBUF[1]),
        .I1(HCounter[0]),
        .I2(HCounter[1]),
        .I3(VGA_ADDR_OBUF[0]),
        .O(count_value[3]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \count_value[4]_i_1 
       (.I0(VGA_ADDR_OBUF[2]),
        .I1(VGA_ADDR_OBUF[0]),
        .I2(HCounter[1]),
        .I3(HCounter[0]),
        .I4(VGA_ADDR_OBUF[1]),
        .O(count_value[4]));
  LUT3 #(
    .INIT(8'h41)) 
    \count_value[5]_i_1 
       (.I0(\count_value[8]_i_3_n_0 ),
        .I1(\count_value[8]_i_2_n_0 ),
        .I2(VGA_ADDR_OBUF[3]),
        .O(count_value[5]));
  LUT3 #(
    .INIT(8'h9A)) 
    \count_value[6]_i_1 
       (.I0(VGA_ADDR_OBUF[4]),
        .I1(\count_value[8]_i_2_n_0 ),
        .I2(VGA_ADDR_OBUF[3]),
        .O(count_value[6]));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \count_value[7]_i_1 
       (.I0(VGA_ADDR_OBUF[5]),
        .I1(VGA_ADDR_OBUF[3]),
        .I2(VGA_ADDR_OBUF[4]),
        .I3(\count_value[8]_i_2_n_0 ),
        .O(\count_value[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000DFFF2000)) 
    \count_value[8]_i_1 
       (.I0(VGA_ADDR_OBUF[5]),
        .I1(\count_value[8]_i_2_n_0 ),
        .I2(VGA_ADDR_OBUF[4]),
        .I3(VGA_ADDR_OBUF[3]),
        .I4(VGA_ADDR_OBUF[6]),
        .I5(\count_value[8]_i_3_n_0 ),
        .O(count_value[8]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \count_value[8]_i_2 
       (.I0(VGA_ADDR_OBUF[1]),
        .I1(HCounter[0]),
        .I2(HCounter[1]),
        .I3(VGA_ADDR_OBUF[0]),
        .I4(VGA_ADDR_OBUF[2]),
        .O(\count_value[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    \count_value[8]_i_3 
       (.I0(VGA_ADDR_OBUF[5]),
        .I1(VGA_ADDR_OBUF[4]),
        .I2(VGA_ADDR_OBUF[7]),
        .I3(VGA_ADDR_OBUF[6]),
        .I4(VGA_ADDR_OBUF[3]),
        .I5(VGA_HS_i_2_n_0),
        .O(\count_value[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hA8AA5555)) 
    \count_value[9]_i_1 
       (.I0(VGA_ADDR_OBUF[7]),
        .I1(\count_value[9]_i_2_n_0 ),
        .I2(\count_value[9]_i_3_n_0 ),
        .I3(\count_value[9]_i_4_n_0 ),
        .I4(\count_value[9]_i_5_n_0 ),
        .O(count_value[9]));
  LUT3 #(
    .INIT(8'hDF)) 
    \count_value[9]_i_2 
       (.I0(VGA_ADDR_OBUF[6]),
        .I1(VGA_ADDR_OBUF[2]),
        .I2(VGA_ADDR_OBUF[3]),
        .O(\count_value[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF4FF)) 
    \count_value[9]_i_3 
       (.I0(HCounter[1]),
        .I1(HCounter[0]),
        .I2(VGA_ADDR_OBUF[0]),
        .I3(VGA_ADDR_OBUF[6]),
        .I4(VGA_ADDR_OBUF[4]),
        .I5(VGA_ADDR_OBUF[5]),
        .O(\count_value[9]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h10100010)) 
    \count_value[9]_i_4 
       (.I0(VGA_ADDR_OBUF[0]),
        .I1(HCounter[1]),
        .I2(VGA_ADDR_OBUF[3]),
        .I3(VGA_ADDR_OBUF[1]),
        .I4(VGA_ADDR_OBUF[2]),
        .O(\count_value[9]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \count_value[9]_i_5 
       (.I0(VGA_ADDR_OBUF[5]),
        .I1(\count_value[8]_i_2_n_0 ),
        .I2(VGA_ADDR_OBUF[4]),
        .I3(VGA_ADDR_OBUF[3]),
        .I4(VGA_ADDR_OBUF[6]),
        .O(\count_value[9]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[0] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[0]),
        .Q(HCounter[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[1] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[1]),
        .Q(HCounter[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[2] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[2]),
        .Q(VGA_ADDR_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[3] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[3]),
        .Q(VGA_ADDR_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[4] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[4]),
        .Q(VGA_ADDR_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[5] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[5]),
        .Q(VGA_ADDR_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[6] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[6]),
        .Q(VGA_ADDR_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[7] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(\count_value[7]_i_1_n_0 ),
        .Q(VGA_ADDR_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[8] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[8]),
        .Q(VGA_ADDR_OBUF[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_reg[9] 
       (.C(DPR_CLK_OBUF),
        .CE(1'b1),
        .D(count_value[9]),
        .Q(VGA_ADDR_OBUF[7]),
        .R(1'b0));
endmodule

(* ECO_CHECKSUM = "7bd08c1d" *) (* HTDisp = "640" *) (* HTpw = "96" *) 
(* HTs = "800" *) (* Hbp = "48" *) (* Hfp = "16" *) 
(* VTDisp = "480" *) (* VTpw = "2" *) (* VTs = "521" *) 
(* Vbp = "29" *) (* Vfp = "10" *) 
(* NotValidForBitStream *)
module VGA_Sig_Gen
   (CLK,
    RESET,
    CONFIG_COLOURS,
    DPR_CLK,
    VGA_ADDR,
    VGA_DATA,
    VGA_HS,
    VGA_VS,
    VGA_COLOUR);
  input CLK;
  input RESET;
  input [15:0]CONFIG_COLOURS;
  output DPR_CLK;
  output [14:0]VGA_ADDR;
  output VGA_DATA;
  output VGA_HS;
  output VGA_VS;
  output [7:0]VGA_COLOUR;

  wire CLK;
  wire CLK_IBUF;
  wire CLK_IBUF_BUFG;
  wire CounterH_n_0;
  wire DPR_CLK;
  wire DPR_CLK_OBUF;
  wire RESET;
  wire RESET_IBUF;
  wire [14:0]VGA_ADDR;
  wire [7:0]VGA_ADDR_OBUF;
  wire VGA_CLK_i_1_n_0;
  wire [7:0]VGA_COLOUR;
  wire VGA_HS;
  wire VGA_HS_OBUF;
  wire VGA_VS;

  BUFG CLK_IBUF_BUFG_inst
       (.I(CLK_IBUF),
        .O(CLK_IBUF_BUFG));
  IBUF CLK_IBUF_inst
       (.I(CLK),
        .O(CLK_IBUF));
  Counter CounterH
       (.DPR_CLK_OBUF(DPR_CLK_OBUF),
        .VGA_ADDR_OBUF(VGA_ADDR_OBUF),
        .VGA_HS_reg(CounterH_n_0));
  OBUF DPR_CLK_OBUF_inst
       (.I(DPR_CLK_OBUF),
        .O(DPR_CLK));
  IBUF RESET_IBUF_inst
       (.I(RESET),
        .O(RESET_IBUF));
  OBUF \VGA_ADDR_OBUF[0]_inst 
       (.I(VGA_ADDR_OBUF[0]),
        .O(VGA_ADDR[0]));
  OBUF \VGA_ADDR_OBUF[10]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[10]));
  OBUF \VGA_ADDR_OBUF[11]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[11]));
  OBUF \VGA_ADDR_OBUF[12]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[12]));
  OBUF \VGA_ADDR_OBUF[13]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[13]));
  OBUF \VGA_ADDR_OBUF[14]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[14]));
  OBUF \VGA_ADDR_OBUF[1]_inst 
       (.I(VGA_ADDR_OBUF[1]),
        .O(VGA_ADDR[1]));
  OBUF \VGA_ADDR_OBUF[2]_inst 
       (.I(VGA_ADDR_OBUF[2]),
        .O(VGA_ADDR[2]));
  OBUF \VGA_ADDR_OBUF[3]_inst 
       (.I(VGA_ADDR_OBUF[3]),
        .O(VGA_ADDR[3]));
  OBUF \VGA_ADDR_OBUF[4]_inst 
       (.I(VGA_ADDR_OBUF[4]),
        .O(VGA_ADDR[4]));
  OBUF \VGA_ADDR_OBUF[5]_inst 
       (.I(VGA_ADDR_OBUF[5]),
        .O(VGA_ADDR[5]));
  OBUF \VGA_ADDR_OBUF[6]_inst 
       (.I(VGA_ADDR_OBUF[6]),
        .O(VGA_ADDR[6]));
  OBUF \VGA_ADDR_OBUF[7]_inst 
       (.I(VGA_ADDR_OBUF[7]),
        .O(VGA_ADDR[7]));
  OBUF \VGA_ADDR_OBUF[8]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[8]));
  OBUF \VGA_ADDR_OBUF[9]_inst 
       (.I(1'b0),
        .O(VGA_ADDR[9]));
  LUT2 #(
    .INIT(4'h1)) 
    VGA_CLK_i_1
       (.I0(RESET_IBUF),
        .I1(DPR_CLK_OBUF),
        .O(VGA_CLK_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    VGA_CLK_reg
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(VGA_CLK_i_1_n_0),
        .Q(DPR_CLK_OBUF),
        .R(1'b0));
  OBUF \VGA_COLOUR_OBUF[0]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[0]));
  OBUF \VGA_COLOUR_OBUF[1]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[1]));
  OBUF \VGA_COLOUR_OBUF[2]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[2]));
  OBUF \VGA_COLOUR_OBUF[3]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[3]));
  OBUF \VGA_COLOUR_OBUF[4]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[4]));
  OBUF \VGA_COLOUR_OBUF[5]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[5]));
  OBUF \VGA_COLOUR_OBUF[6]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[6]));
  OBUF \VGA_COLOUR_OBUF[7]_inst 
       (.I(1'b0),
        .O(VGA_COLOUR[7]));
  OBUF VGA_HS_OBUF_inst
       (.I(VGA_HS_OBUF),
        .O(VGA_HS));
  FDRE #(
    .INIT(1'b0)) 
    VGA_HS_reg
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(CounterH_n_0),
        .Q(VGA_HS_OBUF),
        .R(1'b0));
  OBUF VGA_VS_OBUF_inst
       (.I(1'b0),
        .O(VGA_VS));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
