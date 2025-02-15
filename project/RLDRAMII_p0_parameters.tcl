#
# AUTO-GENERATED FILE: Do not edit ! ! ! 
#

set ::GLOBAL_RLDRAMII_p0_corename "RLDRAMII_p0"
set ::GLOBAL_RLDRAMII_p0_io_standard "1.8-V HSTL"
set ::GLOBAL_RLDRAMII_p0_io_interface_type "HPAD"
set ::GLOBAL_RLDRAMII_p0_device_width 1
set ::GLOBAL_RLDRAMII_p0_number_of_d_groups 2
set ::GLOBAL_RLDRAMII_p0_number_of_q_groups 2
set ::GLOBAL_RLDRAMII_p0_dq_group_size 18
set ::GLOBAL_RLDRAMII_p0_d_group_size 18
set ::GLOBAL_RLDRAMII_p0_number_of_dm_pins 1
set ::GLOBAL_RLDRAMII_p0_dqs_delay_chain_length 2
set ::GLOBAL_RLDRAMII_p0_uniphy_temp_ver_code 154576815
# PLL Parameters

#USER W A R N I N G !
#USER The PLL parameters are statically defined in this
#USER file at generation time!
#USER To ensure timing constraints and timing reports are correct, when you make 
#USER any changes to the PLL component using the MegaWizard Plug-In,
#USER apply those changes to the PLL parameters in this file

set ::GLOBAL_RLDRAMII_p0_num_pll_clock 7
set ::GLOBAL_RLDRAMII_p0_pll_mult(0) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(0) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(0) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_AFI_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_AFI_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_AFI_CLK) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(1) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(1) 1000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(1) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_MEM_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_MEM_CLK) 1000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_MEM_CLK) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(2) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(2) 1000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(2) 270.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_WRITE_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_WRITE_CLK) 1000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_WRITE_CLK) 270.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(3) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(3) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(3) 225.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_ADDR_CMD_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_ADDR_CMD_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_ADDR_CMD_CLK) 225.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(4) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(4) 4000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(4) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_AFI_HALF_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_AFI_HALF_CLK) 4000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_AFI_HALF_CLK) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(5) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(5) 4000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(5) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_NIOS_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_NIOS_CLK) 4000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_NIOS_CLK) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(6) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(6) 12000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(6) 0.0
set ::GLOBAL_RLDRAMII_p0_pll_mult(PLL_CONFIG_CLK) 2000000
set ::GLOBAL_RLDRAMII_p0_pll_div(PLL_CONFIG_CLK) 12000000
set ::GLOBAL_RLDRAMII_p0_pll_phase(PLL_CONFIG_CLK) 0.0

set ::GLOBAL_RLDRAMII_p0_leveling_capture_phase 90.0

##############################################################
## IP options
##############################################################

set IP(write_dcc) "static"
set IP(write_deskew_range) 31
set IP(read_deskew_range) 31
set IP(write_deskew_range_setup) 4
set IP(write_deskew_range_hold) 31
set IP(read_deskew_range_setup) 31
set IP(read_deskew_range_hold) 31
set IP(mem_if_memtype) "rldram2"
set IP(LRDIMM) 0
set IP(mp_calibration) 1
set IP(quantization_T9) 0.025
set IP(quantization_T1) 0.025
set IP(quantization_DCC) 0.025
set IP(quantization_T7) 0.025
set IP(quantization_WL) 0.0125
set IP(quantization_T11) 0.025
set IP(eol_reduction_factor_addr) 2.0
set IP(eol_reduction_factor_read) 2.1
set IP(eol_reduction_factor_write) 2.35
set IP(num_WL) 0
# Can be either dynamic or static
set IP(write_deskew_mode) "dynamic"
set IP(read_deskew_mode) "dynamic"
set IP(discrete_device) 1
set IP(num_ranks) 1
set IP(num_shadow_registers) 1
set IP(device_width) 1

set IP(num_report_paths) 10
set IP(epr) 0.058
set IP(epw) 0.076
