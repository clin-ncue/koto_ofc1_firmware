## Generated SDC file "Rx.out.sdc"

## Copyright (C) 1991-2012 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 12.0 Build 263 08/02/2012 Service Pack 2 SJ Full Version"

## DATE    "Wed Sep 05 11:16:48 2012"

##
## DEVICE  "5AGXFB5H4F35C4"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************
derive_pll_clocks -create_base_clocks -use_net_name
derive_clock_uncertainty -add
set_false_path -from VME*
set_false_path -to VME*
set_false_path -from *vme*
set_false_path -to *vme*

#create_clock -name virt_clk -period 8.000 

create_clock -name tapdel10_del1 -period 16.000 [get_registers {tapdel10:inst13|del1}]
create_clock -name tapdel10_del5 -period 16.000 [get_registers {tapdel10:inst13|del5}]
create_clock -name vme_interface_del80 -period 16.000 [get_registers {vme_interface:inst2|del80}]
create_clock -name _delayed_ds_in -period 16.000 [get_registers {dff_one:inst15|lpm_ff:lpm_ff_component|dffs[0]}]

create_clock -name master_clock -period 8.000 [get_ports {master_clock}]
create_clock -name samplingclock -period 2.00 [get_ports {samplingclock}]
create_clock -name XCLK -period 5.000 [get_ports {XCLK}]
create_clock -name _as -period 16.000 [get_ports {_as}]

create_clock -name 0_RX_CLK -period 8.000 [get_ports {0_RX_CLK}]
create_clock -name 1_RX_CLK -period 8.000 [get_ports {1_RX_CLK}]
create_clock -name 2_RX_CLK -period 8.000 [get_ports {2_RX_CLK}]
create_clock -name 3_RX_CLK -period 8.000 [get_ports {3_RX_CLK}]

#**************************************************************
# Input Constraints
#**************************************************************

#TLK3501 device

# Use +/- 200ps skew and center clock. This assumes a setup time of 3.8ns and a hold time of 3.8ns
# The 3.125Gbps TLK3101 RXD specs setup time of 2.5ns and hold time of 2.5ns
# max_value = 6.4ns-3.0ns = 3.4ns   :   min_value = 3.0ns

set_input_delay -clock { 0_RX_CLK } -min  3.700 [get_ports 0_RXD[*]]
set_input_delay -clock { 0_RX_CLK } -max  4.300 [get_ports 0_RXD[*]]
set_input_delay -clock { 1_RX_CLK } -min  3.700 [get_ports 1_RXD[*]]
set_input_delay -clock { 1_RX_CLK } -max  4.300 [get_ports 1_RXD[*]]
set_input_delay -clock { 2_RX_CLK } -min  3.700 [get_ports 2_RXD[*]]
set_input_delay -clock { 2_RX_CLK } -max  4.300 [get_ports 2_RXD[*]]
set_input_delay -clock { 3_RX_CLK } -min  3.700 [get_ports 3_RXD[*]]
set_input_delay -clock { 3_RX_CLK } -max  4.300 [get_ports 3_RXD[*]]




#set_max_skew -from [get_ports 0_RXD[*]] 2.000
#set_max_skew -from [get_ports 1_RXD[*]] 2.000
#set_max_skew -from [get_ports 2_RXD[*]] 2.000
#set_max_skew -from [get_ports 3_RXD[*]] 2.000


#ADC_SDO[0]
#ADC_SDO[1]
#ADC_SDO[2]
#ADC_SDO[3]
#ADC_SYNCIN[0]
#ADC_SYNCIN[0](n)
#ADC_SYNCIN[1]
#ADC_SYNCIN[1](n)
#ADC_SYNCIN[2]
#ADC_SYNCIN[2](n)
#ADC_SYNCIN[3]
#ADC_SYNCIN[3](n)
#ADC_SYNCIN[4]
#ADC_SYNCIN[4](n)
#ADC_SYNCIN[5]
#ADC_SYNCIN[5](n)
#ADC_SYNCIN[6]
#ADC_SYNCIN[6](n)
#ADC_SYNCIN[7]
#ADC_SYNCIN[7](n)
#
#DigIn[0]
#DigIn[0](n)
#DigIn[1]
#DigIn[1](n)
#QSFP_Rx0[0]
#QSFP_Rx0[0](n)
#QSFP_Rx0[1]
#QSFP_Rx0[1](n)
#QSFP_Rx0[2]
#QSFP_Rx0[2](n)
#QSFP_Rx0[3]
#QSFP_Rx0[3](n)
#_as
#_berrin
#_ds[0]
#_ds[1]
#_ga[0]
#_ga[1]
#_ga[2]
#_ga[3]
#_ga[4]
#_iack
#_iackin
#_lword
#_vme_write
set_input_delay -clock { _as } -min 0.000 [get_ports address[*]]
set_input_delay -clock { _as } -max 0.000 [get_ports address[*]]
#address[10]
#address[11]
#address[12]
#address[13]
#address[14]
#address[15]
#address[16]
#address[17]
#address[18]
#address[19]
#address[20]
#address[21]
#address[22]
#address[23]
#address[24]
#address[25]
#address[26]
#address[27]
#address[28]
#address[29]
#address[2]
#address[30]
#address[31]
#address[3]
#address[4]
#address[5]
#address[6]
#address[7]
#address[8]
#address[9]
#am[0]
#am[1]
#am[2]
#am[3]
#am[4]
#am[5]
#clkswitch
#gx_pll_refclkin1
#gx_pll_refclkin1(n)
#master_clock
#master_clock(n)
#master_clock1
#master_clock1(n)
#sysclk