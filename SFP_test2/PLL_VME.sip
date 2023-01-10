set_global_assignment -entity "PLL_VME" -library "lib_PLL_VME" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_VME" -library "lib_PLL_VME" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "PLL_VME" -library "lib_PLL_VME" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_VME" -name SPD_FILE [file join $::quartus(sip_path) "PLL_VME.spd"]

set_global_assignment -library "lib_PLL_VME" -name MISC_FILE [file join $::quartus(sip_path) "PLL_VME_sim/PLL_VME.vho"]
