#clk
set_property PACKAGE_PIN W5 [get_ports CLK]
    set_property IOSTANDARD LVCMOS33 [get_ports CLK]
    
#reset
set_property PACKAGE_PIN U18 [get_ports RESET]
    set_property IOSTANDARD LVCMOS33 [get_ports RESET]
    
#ir_led
set_property PACKAGE_PIN P18 [get_ports IR_LED]
    set_property IOSTANDARD LVCMOS33 [get_ports IR_LED]

# sensitivity control 
set_property PACKAGE_PIN V17 [get_ports {MouseSensitivity[0]}]							
    set_property IOSTANDARD LVCMOS33 [get_ports {MouseSensitivity[0]}]

set_property PACKAGE_PIN V16 [get_ports {MouseSensitivity[1]}]							
    set_property IOSTANDARD LVCMOS33 [get_ports {MouseSensitivity[1]}]
    
# clock
set_property PACKAGE_PIN C17 [get_ports CLK_MOUSE]
    set_property IOSTANDARD LVCMOS33 [get_ports CLK_MOUSE]
    set_property PULLUP true [get_ports CLK_MOUSE]

# data
set_property PACKAGE_PIN B17 [get_ports DATA_MOUSE]
    set_property IOSTANDARD LVCMOS33 [get_ports DATA_MOUSE]
    set_property PULLUP true [get_ports DATA_MOUSE]
    
# 7 segment display
set_property PACKAGE_PIN W7 [get_ports {DEC_OUT[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[0]}]
set_property PACKAGE_PIN W6 [get_ports {DEC_OUT[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[1]}]
set_property PACKAGE_PIN U8 [get_ports {DEC_OUT[2]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[2]}]
set_property PACKAGE_PIN V8 [get_ports {DEC_OUT[3]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[3]}]                        
set_property PACKAGE_PIN U5 [get_ports {DEC_OUT[4]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[4]}]                        
set_property PACKAGE_PIN V5 [get_ports {DEC_OUT[5]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[5]}]
set_property PACKAGE_PIN U7 [get_ports {DEC_OUT[6]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[6]}]
set_property PACKAGE_PIN V7 [get_ports {DEC_OUT[7]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[7]}]
set_property PACKAGE_PIN U2 [get_ports {SEG_SELECT[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[0]}]
set_property PACKAGE_PIN U4 [get_ports {SEG_SELECT[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[1]}]
set_property PACKAGE_PIN V4 [get_ports {SEG_SELECT[2]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[2]}]
set_property PACKAGE_PIN W4 [get_ports {SEG_SELECT[3]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[3]}]

#LEDs
set_property PACKAGE_PIN U16 [get_ports {LED_OUT[7]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[7]}]
set_property PACKAGE_PIN E19 [get_ports {LED_OUT[6]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[6]}]
set_property PACKAGE_PIN U19 [get_ports {LED_OUT[5]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[5]}]
set_property PACKAGE_PIN V19 [get_ports {LED_OUT[4]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[4]}]                        
set_property PACKAGE_PIN W18 [get_ports {LED_OUT[3]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[3]}]                        
set_property PACKAGE_PIN U15 [get_ports {LED_OUT[2]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[2]}]
set_property PACKAGE_PIN U14 [get_ports {LED_OUT[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[1]}]
set_property PACKAGE_PIN V14 [get_ports {LED_OUT[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[0]}]

# VGA colour
set_property PACKAGE_PIN N19 [get_ports {VGA_Colour[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[7]}]
set_property PACKAGE_PIN J19 [get_ports {VGA_Colour[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[6]}]
set_property PACKAGE_PIN H19 [get_ports {VGA_Colour[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[5]}]

set_property PACKAGE_PIN D17 [get_ports {VGA_Colour[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[4]}]
set_property PACKAGE_PIN G17 [get_ports {VGA_Colour[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[3]}]
set_property PACKAGE_PIN H17 [get_ports {VGA_Colour[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[2]}]

set_property PACKAGE_PIN J18 [get_ports {VGA_Colour[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[1]}]
set_property PACKAGE_PIN K18 [get_ports {VGA_Colour[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Colour[0]}]

             
# VGA HS and VS
             
set_property PACKAGE_PIN P19 [get_ports HS]
    set_property IOSTANDARD LVCMOS33 [get_ports HS]
set_property PACKAGE_PIN R19 [get_ports VS]
    set_property IOSTANDARD LVCMOS33 [get_ports VS]