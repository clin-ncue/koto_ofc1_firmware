# Define Clocks
create_clock -period 8   -name master_clock1  [get_ports {master_clock1}]
create_clock -period 8   -name clk_125mhz     [get_ports {clk_125mhz}]
create_clock -period 8   -name adc_clk0       [get_ports {adc_clk[0]}]
create_clock -period 8   -name adc_clk1       [get_ports {adc_clk[1]}]
create_clock -period 8   -name adc_clk2       [get_ports {adc_clk[2]}]
create_clock -period 8   -name adc_clk3       [get_ports {adc_clk[3]}]
create_clock -period 8   -name adc_clk4       [get_ports {adc_clk[4]}]
create_clock -period 8   -name adc_clk5       [get_ports {adc_clk[5]}]
create_clock -period 8   -name adc_clk6       [get_ports {adc_clk[6]}]
create_clock -period 8   -name adc_clk7       [get_ports {adc_clk[7]}]
create_clock -period 8   -name adc_clk8       [get_ports {adc_clk[8]}]
create_clock -period 8   -name adc_clk9       [get_ports {adc_clk[9]}]
create_clock -period 8   -name adc_clk10      [get_ports {adc_clk[10]}]
create_clock -period 8   -name adc_clk11      [get_ports {adc_clk[11]}]
create_clock -period 8   -name adc_clk12      [get_ports {adc_clk[12]}]
create_clock -period 8   -name adc_clk13      [get_ports {adc_clk[13]}]
create_clock -period 8   -name adc_clk14      [get_ports {adc_clk[14]}]
create_clock -period 8   -name adc_clk15      [get_ports {adc_clk[15]}]
create_clock -period 8   -name L1_rx_clk      [get_ports {L1_rx_clk}]
create_clock -period 8   -name L2_rx_clk      [get_ports {L2_rx_clk}]

# Use +/- 200ps skew and center clock. This assumes a setup time of 3.8ns and a hold time of 3.8ns
# max_value = 8ns-3.8ns = 4.2ns   :   min_value = 3.8ns
set_input_delay -clock { clk_125mhz } -max   4.2 [get_ports {L1A LIVE}]
set_input_delay -clock { clk_125mhz } -min   3.8 [get_ports {L1A LIVE}] -add_delay

# Use +/- 200ps skew and center clock. This assumes a setup time of 3.8ns and a hold time of 3.8ns
# The 2.5Gbps TLK3101 RXD specs setup time of 3.0ns and hold time of 3.0ns
# max_value = 8ns-3.8ns = 4.2ns   :   min_value = 3.8ns
set_input_delay -clock { L1_rx_clk }  -max   4.2   [get_ports {L1_rx_data[*] L1_rx_error L1_rx_enable}]
set_input_delay -clock { L1_rx_clk }  -min   3.8   [get_ports {L1_rx_data[*] L1_rx_error L1_rx_enable}] -add_delay

# Use +/- 200ps skew and center clock. This assumes a setup time of 3.8ns and a hold time of 3.8ns
# The 3.125Gbps TLK3101 RXD specs setup time of 2.5ns and hold time of 2.5ns
# max_value = 6.4ns-3.0ns = 3.4ns   :   min_value = 3.0ns
set_input_delay -clock { L2_rx_clk }  -max   4.2 [get_ports {L2_rx_data[*] L2_rx_error L2_rx_enable}]
set_input_delay -clock { L2_rx_clk }  -min   3.8 [get_ports {L2_rx_data[*] L2_rx_error L2_rx_enable}] -add_delay

# Use +/- 200ps skew and center clock. This assumes a setup time of 3.8ns and a hold time of 3.8ns
# The AD9254 specs setup time of 1.9ns and hold time of 3.0ns
# max_value = 8ns-3.8ns = 4.2ns   :   min_value = 3.8ns
set_input_delay -clock { adc_clk0 }  -max   4.2 [get_ports { adc[0]  adc[1] adc[2] adc[3] adc[4] adc[5] adc[6] adc[7] adc[8] adc[9] adc[10] adc[11] adc[12] adc[13] adc_or[0] }]
set_input_delay -clock { adc_clk1 }  -max   4.2 [get_ports { adc[14] adc[15] adc[16] adc[17] adc[18] adc[19] adc[20] adc[21] adc[22] adc[23] adc[24] adc[25] adc[26] adc[27] adc_or[1] }]
set_input_delay -clock { adc_clk2 }  -max   4.2 [get_ports { adc[28] adc[29] adc[30] adc[31] adc[32] adc[33] adc[34] adc[35] adc[36] adc[37] adc[38] adc[39] adc[40] adc[41] adc_or[2] }]
set_input_delay -clock { adc_clk3 }  -max   4.2 [get_ports { adc[42] adc[43] adc[44] adc[45] adc[46] adc[47] adc[48] adc[49] adc[50] adc[51] adc[52] adc[53] adc[54] adc[55] adc_or[3] }]
set_input_delay -clock { adc_clk4 }  -max   4.2 [get_ports { adc[56] adc[57] adc[58] adc[59] adc[60] adc[61] adc[62] adc[63] adc[64] adc[65] adc[66] adc[67] adc[68] adc[69] adc_or[4] }]
set_input_delay -clock { adc_clk5 }  -max   4.2 [get_ports { adc[70] adc[71] adc[72] adc[73] adc[74] adc[75] adc[76] adc[77] adc[78] adc[79] adc[80] adc[81] adc[82] adc[83] adc_or[5] }]
set_input_delay -clock { adc_clk6 }  -max   4.2 [get_ports { adc[84] adc[85] adc[86] adc[87] adc[88] adc[89] adc[90] adc[91] adc[92] adc[93] adc[94] adc[95] adc[96] adc[97] adc_or[6] }]
set_input_delay -clock { adc_clk7 }  -max   4.2 [get_ports { adc[98] adc[99] adc[100] adc[101] adc[102] adc[103] adc[104] adc[105] adc[106] adc[107] adc[108] adc[109] adc[110] adc[111] adc_or[7] }]
set_input_delay -clock { adc_clk8 }  -max   4.2 [get_ports { adc[112] adc[113] adc[114] adc[115] adc[116] adc[117] adc[118] adc[119] adc[120] adc[121] adc[122] adc[123] adc[124] adc[125] adc_or[8] }]
set_input_delay -clock { adc_clk9 }  -max   4.2 [get_ports { adc[126] adc[127] adc[128] adc[129] adc[130] adc[131] adc[132] adc[133] adc[134] adc[135] adc[136] adc[137] adc[138] adc[139] adc_or[9] }]
set_input_delay -clock { adc_clk10 } -max   4.2 [get_ports { adc[140] adc[141] adc[142] adc[143] adc[144] adc[145] adc[146] adc[147] adc[148] adc[149] adc[150] adc[151] adc[152] adc[153] adc_or[10] }]
set_input_delay -clock { adc_clk11 } -max   4.2 [get_ports { adc[154] adc[155] adc[156] adc[157] adc[158] adc[159] adc[160] adc[161] adc[162] adc[163] adc[164] adc[165] adc[166] adc[167] adc_or[11] }]
set_input_delay -clock { adc_clk12 } -max   4.2 [get_ports { adc[168] adc[169] adc[170] adc[171] adc[172] adc[173] adc[174] adc[175] adc[176] adc[177] adc[178] adc[179] adc[180] adc[181] adc_or[12] }]
set_input_delay -clock { adc_clk13 } -max   4.2 [get_ports { adc[182] adc[183] adc[184] adc[185] adc[186] adc[187] adc[188] adc[189] adc[190] adc[191] adc[192] adc[193] adc[194] adc[195] adc_or[13] }]
set_input_delay -clock { adc_clk14 } -max   4.2 [get_ports { adc[196] adc[197] adc[198] adc[199] adc[200] adc[201] adc[202] adc[203] adc[204] adc[205] adc[206] adc[207] adc[208] adc[209] adc_or[14] }]
set_input_delay -clock { adc_clk15 } -max   4.2 [get_ports { adc[210] adc[211] adc[212] adc[213] adc[214] adc[215] adc[216] adc[217] adc[218] adc[219] adc[220] adc[221] adc[222] adc[223] adc_or[15] }]
set_input_delay -clock { adc_clk0 }  -min   3.8 [get_ports { adc[0]  adc[1] adc[2] adc[3] adc[4] adc[5] adc[6] adc[7] adc[8] adc[9] adc[10] adc[11] adc[12] adc[13] adc_or[0] }]                         -add_delay
set_input_delay -clock { adc_clk1 }  -min   3.8 [get_ports { adc[14] adc[15] adc[16] adc[17] adc[18] adc[19] adc[20] adc[21] adc[22] adc[23] adc[24] adc[25] adc[26] adc[27] adc_or[1] }]                -add_delay
set_input_delay -clock { adc_clk2 }  -min   3.8 [get_ports { adc[28] adc[29] adc[30] adc[31] adc[32] adc[33] adc[34] adc[35] adc[36] adc[37] adc[38] adc[39] adc[40] adc[41] adc_or[2] }]                -add_delay
set_input_delay -clock { adc_clk3 }  -min   3.8 [get_ports { adc[42] adc[43] adc[44] adc[45] adc[46] adc[47] adc[48] adc[49] adc[50] adc[51] adc[52] adc[53] adc[54] adc[55] adc_or[3] }]                -add_delay
set_input_delay -clock { adc_clk4 }  -min   3.8 [get_ports { adc[56] adc[57] adc[58] adc[59] adc[60] adc[61] adc[62] adc[63] adc[64] adc[65] adc[66] adc[67] adc[68] adc[69] adc_or[4] }]                -add_delay
set_input_delay -clock { adc_clk5 }  -min   3.8 [get_ports { adc[70] adc[71] adc[72] adc[73] adc[74] adc[75] adc[76] adc[77] adc[78] adc[79] adc[80] adc[81] adc[82] adc[83] adc_or[5] }]                -add_delay
set_input_delay -clock { adc_clk6 }  -min   3.8 [get_ports { adc[84] adc[85] adc[86] adc[87] adc[88] adc[89] adc[90] adc[91] adc[92] adc[93] adc[94] adc[95] adc[96] adc[97] adc_or[6] }]                -add_delay
set_input_delay -clock { adc_clk7 }  -min   3.8 [get_ports { adc[98] adc[99] adc[100] adc[101] adc[102] adc[103] adc[104] adc[105] adc[106] adc[107] adc[108] adc[109] adc[110] adc[111] adc_or[7] }]    -add_delay
set_input_delay -clock { adc_clk8 }  -min   3.8 [get_ports { adc[112] adc[113] adc[114] adc[115] adc[116] adc[117] adc[118] adc[119] adc[120] adc[121] adc[122] adc[123] adc[124] adc[125] adc_or[8] }]  -add_delay
set_input_delay -clock { adc_clk9 }  -min   3.8 [get_ports { adc[126] adc[127] adc[128] adc[129] adc[130] adc[131] adc[132] adc[133] adc[134] adc[135] adc[136] adc[137] adc[138] adc[139] adc_or[9] }]  -add_delay
set_input_delay -clock { adc_clk10 } -min   3.8 [get_ports { adc[140] adc[141] adc[142] adc[143] adc[144] adc[145] adc[146] adc[147] adc[148] adc[149] adc[150] adc[151] adc[152] adc[153] adc_or[10] }] -add_delay
set_input_delay -clock { adc_clk11 } -min   3.8 [get_ports { adc[154] adc[155] adc[156] adc[157] adc[158] adc[159] adc[160] adc[161] adc[162] adc[163] adc[164] adc[165] adc[166] adc[167] adc_or[11] }] -add_delay
set_input_delay -clock { adc_clk12 } -min   3.8 [get_ports { adc[168] adc[169] adc[170] adc[171] adc[172] adc[173] adc[174] adc[175] adc[176] adc[177] adc[178] adc[179] adc[180] adc[181] adc_or[12] }] -add_delay
set_input_delay -clock { adc_clk13 } -min   3.8 [get_ports { adc[182] adc[183] adc[184] adc[185] adc[186] adc[187] adc[188] adc[189] adc[190] adc[191] adc[192] adc[193] adc[194] adc[195] adc_or[13] }] -add_delay
set_input_delay -clock { adc_clk14 } -min   3.8 [get_ports { adc[196] adc[197] adc[198] adc[199] adc[200] adc[201] adc[202] adc[203] adc[204] adc[205] adc[206] adc[207] adc[208] adc[209] adc_or[14] }] -add_delay
set_input_delay -clock { adc_clk15 } -min   3.8 [get_ports { adc[210] adc[211] adc[212] adc[213] adc[214] adc[215] adc[216] adc[217] adc[218] adc[219] adc[220] adc[221] adc[222] adc[223] adc_or[15] }] -add_delay


#Clock Generation for PLL clocks

create_generated_clock -name pll_125mhz     -source [get_ports {clk_125mhz}] -divide_by 1 -duty_cycle 50 -phase 0      [get_nets {inst12|altpll_component|_clk1}]
create_generated_clock -name pll_125mhz_inv -source [get_ports {clk_125mhz}] -divide_by 1 -duty_cycle 50 -phase 210.00 [get_nets {inst12|altpll_component|_clk3}]
create_generated_clock -name pll_156mhz     -source [get_ports {clk_125mhz}] -divide_by 1 -multiply_by 1 -phase 0      [get_nets {inst11|altpll_component|_clk0}]
create_generated_clock -name pll_156mhz_inv -source [get_ports {clk_125mhz}] -divide_by 1 -multiply_by 1 -phase 213.75 [get_nets {inst11|altpll_component|_clk2}]
create_generated_clock -name sample_clock   -source [get_ports {clk_125mhz}] -divide_by 1 -duty_cycle 50 -phase 72     [get_nets {inst9|altpll_component|_clk4}]

create_generated_clock -name samplingclock  -source [get_nets {inst9|altpll_component|_clk4}]  [get_ports {samplingclock}]
create_generated_clock -name L1_clk         -source [get_nets {inst12|altpll_component|_clk3}] [get_ports {L1_clk}]
create_generated_clock -name L2_clk         -source [get_nets {inst11|altpll_component|_clk2}] [get_ports {L2_clk}]


# Clock Uncertainty
set_clock_uncertainty -to { pll_125mhz } -setup 0.20
set_clock_uncertainty -to { pll_125mhz } -hold  0.20
set_clock_uncertainty -to { pll_156mhz } -setup 0.20
set_clock_uncertainty -to { pll_156mhz } -hold  0.20

# Soft error test Function (input from FPGA)
set_input_delay -clock { pll_125mhz } -max  4.0  [get_ports {read_crc_error}]
#set_input_delay -clock { pll_125mhz } -max   4.0 [get_ports {read_crc_error}]
set_input_delay -clock { pll_125mhz } -min   1.0 [get_ports {read_crc_error}]

#Output delays for 2.5Gbps Optical Links
# Use +/- 200ps skew and center clock. This assumes a setup time of 3.8ns and a hold time of 3.8ns
# The 2.5Gbps TLK3101 TXD specs setup time of 1.5ns and hold time of 0.4ns
# max_value = 3.8ns   :   min_value = -3.8ns
set_output_delay -clock { L1_clk } -max  3.5 [get_ports {L1_data*  L1_enable L1_error }]
set_output_delay -clock { L1_clk } -min -3.5 [get_ports {L1_data*  L1_enable L1_error }] -add_delay

#Output delays for 3.125Gbps Optical Links
# Use +/- 200ps skew and center clock. This assumes a setup time of 3.0ns and a hold time of 3.0ns
# The 3.125Gbps TLK3101 specs TXD setup time of 1.5ns and hold time of 0.4ns
# max_value = 3.0ns   :   min_value = -3.0ns
set_output_delay -clock { L2_clk } -max  3.5 [get_ports {L2_data*  L2_enable L2_error }]
set_output_delay -clock { L2_clk } -min -3.5 [get_ports {L2_data*  L2_enable L2_error }] -add_delay

#Output delay for ERROR signal
set_output_delay -clock { pll_125mhz } -max 1.0 [get_ports {Board_error }]
set_output_delay -clock { pll_125mhz } -min 1.0 [get_ports {Board_error }]

#Lock ref control signal for TLC3101 or TLK2501 transceiver
set_output_delay -clock { pll_125mhz } -max 4.0 [get_ports {lckrefn_l1 lckrefn_l2}]
set_output_delay -clock { pll_125mhz } -min 1.0 [get_ports {lckrefn_l1 lckrefn_l2}]

#Output delays for slow signals 
set_output_delay -clock { pll_125mhz } -max 2.0 [get_ports {*led* }]
set_output_delay -clock { pll_125mhz } -min 1.0 [get_ports {*led* }]
set_output_delay -clock { pll_125mhz }      2.0 [get_ports *chip*]

#Output delays for external clocks
set_output_delay -clock { L1_clk }        0 [get_ports {L1_clk}]
set_output_delay -clock { L2_clk }        0 [get_ports {L2_clk}]
set_output_delay -clock { samplingclock } 0 [get_ports {samplingclock}]

#
## MT: Commented constraints not needed in merged designed
#

#Multicycle paths.  Some path are allowed upto 3 cycles to meet set time by design 
set_multicycle_path -from [get_clocks {pll_125mhz}]     -to [get_ports *led*] -setup -end 3
set_multicycle_path -from [get_clocks {pll_125mhz}]     -to [get_ports *led*] -hold  -end 3
#set_multicycle_path -from [get_registers *control*rom*inst68*] -to [get_registers *control*counter5*] -setup -end 2
#set_multicycle_path -from [get_registers *control*rom*inst68*] -to [get_registers *control*counter5*] -hold  -end 2
#set_multicycle_path -from [get_registers *control*rom*inst69*] -to [get_registers *control*counter5*] -setup -end 2
#set_multicycle_path -from [get_registers *control*rom*inst69*] -to [get_registers *control*counter5*] -hold  -end 2
#set_multicycle_path -from [get_registers *control*rom*] -to [get_registers *control*inst54*]  -setup -end 2
#set_multicycle_path -from [get_registers *control*rom*] -to [get_registers *control*inst54*]  -hold  -end 2
#set_multicycle_path -from [get_registers *control*rom*] -to [get_registers *control*inst47*]  -setup -end 2
#set_multicycle_path -from [get_registers *control*rom*] -to [get_registers *control*inst47*]  -hold  -end 2
##set_multicycle_path -from [get_registers *packet*compress*corr*inst47*] -to [get_registers *packet*compress*word_*inst6*] -setup -end 2
##set_multicycle_path -from [get_registers *packet*compress*corr*inst47*] -to [get_registers *packet*compress*word_*inst6*] -hold  -end 2
set_multicycle_path -from [get_registers *control*rom*inst157*] -to [get_registers *control*counter5*] -setup -end 2
set_multicycle_path -from [get_registers *control*rom*inst157*] -to [get_registers *control*counter5*] -hold  -end 2
set_multicycle_path -from [get_registers *control*rom*inst157*] -to [get_registers *control*counter13*] -setup -end 2
set_multicycle_path -from [get_registers *control*rom*inst157*] -to [get_registers *control*counter13*] -hold  -end 2
set_multicycle_path -from [get_registers *packet*compress*min_range*inst3\|*] -to [get_registers *packet*compress*lossless*add7*] -setup -end 2
set_multicycle_path -from [get_registers *packet*compress*min_range*inst3\|*] -to [get_registers *packet*compress*lossless*add7*] -hold -end 2

set_multicycle_path -from [get_registers *packet*compression*_cal*min_range*reg14en*] -to [get_registers *packet*compression*lossless*shifter_27*reg28*] -setup -end 2
set_multicycle_path -from [get_registers *packet*compression*_cal*min_range*reg14en*] -to [get_registers *packet*compression*lossless*shifter_27*reg28*] -hold  -end 2


#Reset Multicycle path
##set_multicycle_path -from [get_registers {control:inst16|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers *adc_sync*aclr*]       -setup -end 2
##set_multicycle_path -from [get_registers {control:inst16|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers *adc_sync*aclr*]       -hold  -end 2
##set_multicycle_path -from [get_registers {control:inst16|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*fifo*]     -setup -end 2
##set_multicycle_path -from [get_registers {control:inst16|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*fifo*]     -hold  -end 2
##set_multicycle_path -from [get_registers {control:inst16|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*counter1*] -setup -end 2
##set_multicycle_path -from [get_registers {control:inst16|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*counter1*] -hold  -end 2
set_multicycle_path -from [get_registers {control:inst6|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers *adc_sync*aclr*]       -setup -end 2
set_multicycle_path -from [get_registers {control:inst6|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers *adc_sync*aclr*]       -hold  -end 2
set_multicycle_path -from [get_registers {control:inst6|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*fifo*]     -setup -end 2
set_multicycle_path -from [get_registers {control:inst6|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*fifo*]     -hold  -end 2
set_multicycle_path -from [get_registers {control:inst6|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*counter1*] -setup -end 2
set_multicycle_path -from [get_registers {control:inst6|ff3:inst74|lpm_ff:lpm_ff_component|dffs[0]}] -to [get_registers data_buffer*counter1*] -hold  -end 2

#False path,  LED display.
set_false_path -from [get_registers *] -to [get_ports led*]
set_false_path -from [get_ports vme*]  -to [get_ports led*]
set_false_path -from [get_registers *adc_sync*inst1*lpm_ff*] -to [get_registers *display_driver*]
#False path    Serdes chip enable
set_false_path -from  [get_clocks {clk_125mhz}]       -to [get_ports {L1_chip_enable L2_chip_enable}]
#False path    Test mode adc clock capture by clk_125mhz
set_false_path -from  [get_clocks *adc*]              -to [get_registers *adc_sync*ff3*inst5*]
#False path for debug pins
set_false_path -from  [get_clocks *]                  -to [get_ports  debug*]
set_false_path -from  [get_ports {LIVE L1A}]          -to [get_ports  debug*]

#False Path  Test Mode for data capture
#set_false_path -from [get_registers packet*inst15*] -to [get_registers packet*fifo*q_b*]
##set_false_path -from [get_registers packet*inst15*] -to [get_registers packet*fifo*portb*]
##set_false_path -from [get_registers packet*inst15*] -to [get_registers packet*fifo*rdptr_g*]
##set_false_path -from [get_registers packet*inst15*] -to [get_registers packet*fifo*mixed_widths*]
##set_false_path -from [get_registers packet*inst26*] -to [get_registers packet*fifo*]
set_false_path -from [get_registers *L2*fifo*]      -to [get_registers *vme_interface*]
 
#Multicycle path for reset in loopback test mode
set_multicycle_path -from [get_registers loopback*inst3*]            -to [get_registers loopback*fifo*12a*]    -setup -end 2
set_multicycle_path -from [get_registers loopback*inst3*]            -to [get_registers loopback*fifo*12a*]    -hold  -end 2
set_multicycle_path -from [get_registers loopback*inst3*]            -to [get_registers loopback*fifo*15a*]    -setup -end 2
set_multicycle_path -from [get_registers loopback*inst3*]            -to [get_registers loopback*fifo*15a*]    -hold  -end 2
#set_multicycle_path -from [get_registers loopback*inst13*counter16*] -to [get_registers vme_interface*inst79*] -setup -end 2
#set_multicycle_path -from [get_registers loopback*inst13*counter16*] -to [get_registers vme_interface*inst79*] -hold  -end 2
set_multicycle_path -from [get_registers *control*sr4*\[1\]*] -to [get_registers *loopback_with*fifo*aclr*] -setup -end 2
set_multicycle_path -from [get_registers *control*sr4*\[1\]*] -to [get_registers *loopback_with*fifo*aclr*] -hold  -end 2
#Multicycle recovery time set to false_path
#set_false_path -from [get_registers control*sr4*\[1\]] -to [get_registers loopback_test5*fifo*aclr*]

#************************************************************************************
#********VME Interface  Asynchronous Interface, timing meet by interface spec.*******
#************************************************************************************

#Multicycle path in Scalar Block to/from VME block
set_multicycle_path -from [get_registers *pedestal_track*] -to [get_ports *vme_data\[*] -setup -end 3
set_multicycle_path -from [get_registers *pedestal_track*] -to [get_ports *vme_data\[*] -hold  -end 3

#VME Interface    Asynchronous Interface I/O timing
create_clock -period 80 -name vme_virtual_clock
create_clock -period 80 -name vme_ds0             -waveform { 64 88 } [get_ports {vme_ds0}]
create_clock -period 80 -name vme_ds1             -waveform { 64 88 } [get_ports {vme_ds1}]
create_clock -period 80 -name vme_as              -waveform { 64 88 } [get_ports {vme_as}]

create_generated_clock   -name energy_sum_clk      -source [get_pins {vme_ds0|combout}] -divide_by 1 [get_registers vme_interface_fast*inst111*]
create_generated_clock   -name data_buffer_clk     -source [get_pins {vme_ds0|combout}] -divide_by 1 [get_registers vme_interface_fast*inst134*]


set_input_delay  -clock { vme_virtual_clock } -max 5 [get_ports {vme_address* vme_am* vme_ga* vme_iackin vme_lword vme_write vme_data* vme_ds*}]
set_input_delay  -clock { vme_virtual_clock } -min 2 [get_ports {vme_address* vme_am* vme_ga* vme_iackin vme_lword vme_write vme_data* vme_ds*}]
set_output_delay -clock { pll_125mhz }        -max 2 [get_ports {vme_dir vme_dtack }]
set_output_delay -clock { pll_125mhz }        -min 1 [get_ports {vme_dir vme_dtack }]
set_output_delay -clock { pll_125mhz }        -max 2 [get_ports {vme_data* }]
set_output_delay -clock { pll_125mhz }        -min 1 [get_ports {vme_data* }]

#VME register and port timing within vme block  allow 3 cycles
set_multicycle_path -from [get_registers vme_interface*]   -to [get_registers vme_interface*]      -setup 2
set_multicycle_path -from [get_registers vme_interface*]   -to [get_registers vme_interface*]      -hold  2
set_multicycle_path -from [get_registers vme_interface*]   -to [get_ports {vme_* }]                -setup 3
set_multicycle_path -from [get_registers vme_interface*]   -to [get_ports {vme_* }]                -hold  3
set_multicycle_path -from [get_registers vme_interface*]   -to [get_ports {vme_data* vme_dtack}]   -setup 3
set_multicycle_path -from [get_registers vme_interface*]   -to [get_ports {vme_data* vme_dtack}]   -hold  3
set_multicycle_path -from [get_registers vme_interface*]   -to [get_ports {lckrefn_l1 lckrefn_l2}] -setup 3
set_multicycle_path -from [get_registers vme_interface*]   -to [get_ports {lckrefn_l1 lckrefn_l2}] -hold  3
set_multicycle_path -from [get_ports {vme_ds* }]   -to [get_ports {vme_data* vme_dir}]          -setup 3
set_multicycle_path -from [get_ports {vme_ds* }]   -to [get_ports {vme_data* vme_dir}]          -hold  3
set_multicycle_path -from [get_ports {vme_ds* }]   -to [get_registers vme_interface*]           -setup 2
set_multicycle_path -from [get_ports {vme_ds* }]   -to [get_registers vme_interface*]           -hold  2
set_multicycle_path -from [get_ports {vme_as }]    -to [get_ports {vme_data* vme_dir}]          -setup 3
set_multicycle_path -from [get_ports {vme_as }]    -to [get_ports {vme_data* vme_dir}]          -hold  3
set_multicycle_path -from [get_ports {vme_as }]    -to [get_registers vme_interface*]           -setup 2
set_multicycle_path -from [get_ports {vme_as }]    -to [get_registers vme_interface*]           -hold  2

set_multicycle_path -from [get_ports vme_data*]    -to [get_registers vme_interface*reg*]       -setup 2
set_multicycle_path -from [get_ports vme_data*]    -to [get_registers vme_interface*reg*]       -hold  2
 

#************************************************************************************
#*******                 VME timing with external blocks                     ********
#*******      All vme control registers are to be up dated when LIVE=0       ********
#*******      Status registers that are monitored when LIVE=1 should         ********
#*******      be read multiple time to eliminate asynchronous timing.        ********
#************************************************************************************

#VME  register timing between vme block allow 3 cycles
set_multicycle_path -from [get_registers vme_interface*]  -to [get_registers *]  -setup 3
set_multicycle_path -from [get_registers vme_interface*]  -to [get_registers *]  -hold  3
set_multicycle_path -from [get_registers *]  -to [get_registers vme*inst101*]    -setup 3
set_multicycle_path -from [get_registers *]  -to [get_registers vme*inst101*]    -hold  3

#VME   Serdes chip enable signals
set_multicycle_path -from [get_registers *vme_interface*vme_reg16*inst4*[12]*] -to [get_ports {*chip_enable* }] -setup 3
set_multicycle_path -from [get_registers *vme_interface*vme_reg16*inst4*[12]*] -to [get_ports {*chip_enable* }] -hold  3
#VME Tied internally 
set_false_path -from [get_ports {vme_iackin}]               -to [get_ports {vme_iackout}]

# Asynchronous signal Board_error
set_false_path -from [get_registers *] -to [get_ports Board*]

# Asynchronous signal read_crc_error
set_false_path -from [get_ports {read_crc_error}] -to [get_registers {vme_interface*}]

#Design Assistance  warnings suppressed
#
#  D101  vme address    ( vme bus timing prevents this condition )
#  D103  vme address    ( vme bus timing prevents this condition )
#  R104  vme address    ( vme bus timing prevents this condition )
#  C104  vme_clk        ( done intentionally for asynchronous bus )
#  C104  adc_clk's      ( test mode for adc_clk alignment )
#  D102  adc_clk and start0 alignment issue ( need to use samplingclock for correct alignment )
#  D103  start0 and adc_clk's  ( need to use samplingclock for correct alignment )
#  D102  fifo testmode  ( vme control signal prevents this condition )

#  ignore timing violatons from VME values passed inside "coe_data_block" 
set_false_path -from {new_packet_assembler:inst23|new_compression_block:inst5|new_coe_data_block:inst|coe_word:inst*} -to {vme_data[*]}