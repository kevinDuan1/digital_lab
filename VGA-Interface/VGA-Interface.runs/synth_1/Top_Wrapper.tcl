# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Marco/VGA-Interface/VGA-Interface.cache/wt [current_project]
set_property parent.project_path C:/Users/Marco/VGA-Interface/VGA-Interface.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Counter.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/MouseReceiver.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/MouseMasterSM.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/MouseTransmitter.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/MUX_2_4.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Generic_counter.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/seg7decoder.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/ALU.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/VGA_Sig_Gen.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Frame_Buffer.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/IRTransmitterSM2.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/TENHz_Counter2.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/MouseTransceiver.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Register_display.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Processor.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Timer.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/ROM.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/RAM.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/VGA_Interface.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/New_Top_Wrapper.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/LED_Driver.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Mouse_Driver.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Seven_Seg_Driver.v
  C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/sources_1/new/Top_Wrapper.v
}
read_xdc C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/constrs_1/new/VGA_constraints.xdc
set_property used_in_implementation false [get_files C:/Users/Marco/VGA-Interface/VGA-Interface.srcs/constrs_1/new/VGA_constraints.xdc]

synth_design -top Top_Wrapper -part xc7a35tcpg236-1
write_checkpoint -noxdef Top_Wrapper.dcp
catch { report_utilization -file Top_Wrapper_utilization_synth.rpt -pb Top_Wrapper_utilization_synth.pb }
