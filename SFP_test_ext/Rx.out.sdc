

## DEVICE  "5AGXFB5H4F35C4"

set_time_format -unit ns -decimal_places 3

# Define Clocks
create_clock -period 8   -name CLOCKIN_0  [get_ports {CLOCKIN_0}]
#create_clock -period 8   -name CLOCKIN_1  [get_ports {CLOCKIN_1}]
create_clock -period 8   -name CLOCKIN_2  [get_ports {CLOCKIN_2}]
#create_clock -period 8   -name CLOCKIN_3  [get_ports {CLOCKIN_3}]
create_clock -period 8   -name CLOCKIN_4  [get_ports {CLOCKIN_4}]
#create_clock -period 8   -name CLOCKIN_5  [get_ports {CLOCKIN_5}]
create_clock -period 8   -name CLOCKIN_6  [get_ports {CLOCKIN_6}]
#create_clock -period 8   -name CLOCKIN_7  [get_ports {CLOCKIN_7}]
create_clock -period 8   -name SFP_0_1_gx_pll_refclkin  [get_ports {SFP_0_1_gx_pll_refclkin}]
create_clock -period 8   -name SFP_2_3_gx_pll_refclkin  [get_ports {SFP_2_3_gx_pll_refclkin}]
create_clock -period 8   -name SFP_4_5_gx_pll_refclkin  [get_ports {SFP_4_5_gx_pll_refclkin}]
create_clock -period 8   -name SFP_6_7_gx_pll_refclkin  [get_ports {SFP_6_7_gx_pll_refclkin}]
create_clock -period 8   -name SFP_8_9_gx_pll_refclkin  [get_ports {SFP_8_9_gx_pll_refclkin}]
create_clock -period 8   -name SFP_10_11_gx_pll_refclkin  [get_ports {SFP_10_11_gx_pll_refclkin}]
create_clock -period 8   -name SFP_12_13_gx_pll_refclkin  [get_ports {SFP_12_13_gx_pll_refclkin}]
create_clock -period 8   -name SFP_14_15_gx_pll_refclkin  [get_ports {SFP_14_15_gx_pll_refclkin}]



derive_pll_clocks -create_base_clocks -use_net_name
derive_clock_uncertainty -add 
set_false_path -from *vme_interface*
set_false_path -to *vme_interface*
set_false_path -from vme_interface*
set_false_path -to vme_interface*


#set_false_path -from Cluster_Counter*
#set_false_path -to Cluster_Counter*




set_false_path -from *VME_thing*
set_false_path -to *VME_thing*
set_false_path -from VME_thing*
set_false_path -to VME_thing*
set_false_path -from tdc_vme*
set_false_path -to tdc_vme*
set_false_path -from tdc_vme*
set_false_path -to tdc_vme*

set_false_path -from SFP*Control*
set_false_path -to SFP*Control*
set_false_path -from debug*
set_false_path -to debug*
set_false_path -to ClockSwitchControl*
set_false_path -to led*


set_false_path -from dff_one:inst17*


set_false_path -from _iack
set_false_path -to _iack

set_false_path -from [get_registers {tapdel_10*dff_one*}] -to [get_registers {tapdel_10*dff_one*}]

#set_false_path -from *signaltap*
#set_false_path -to *signaltap*

create_clock -name tapdel -period 40.000 [get_registers {tapdel_10:inst45|dff_one:inst*|lpm_ff:lpm_ff_component|dffs[0]}]


create_clock -name vme_interface_del80 -period 40.000 [get_registers {vme_interface:inst2|del80}]
create_clock -name _delayed_ds_in -period 40.000 [get_registers {dff_one:inst15|lpm_ff:lpm_ff_component|dffs[0]}]


#VME Interface    Asynchronous Interface I/O timing
create_clock -period 40 -name vme_virtual_clock
create_clock -period 40 -name _ds             -waveform { 0 20 } [get_ports {_ds[*]}]
create_clock -period 40 -name _as              -waveform { 0 20 } [get_ports {_as}]


set_input_delay  -clock { vme_virtual_clock } -max 10 [get_ports {address* am* _as _iack _ga* _lword _vme_write vme_data* _ds*}]
set_input_delay  -clock { vme_virtual_clock } -min  1 [get_ports {address* am* _as _iack _ga* _lword _vme_write vme_data* _ds*}]

#set_input_delay  -clock { The_clock } -max  0 [get_ports {DigIn[*] CRC_ERROR_IN}]
#set_input_delay  -clock { The_clock } -min  0 [get_ports {DigIn[*] CRC_ERROR_IN}]
