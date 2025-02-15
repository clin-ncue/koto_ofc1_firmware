# (C) 2001-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


#####################################################################
#
# THIS IS AN AUTO-GENERATED FILE!
# -------------------------------
# If you modify this files, all your changes will be lost if you
# regenerate the core!
#
# FILE DESCRIPTION
# ----------------
# This file contains the traversal routines that are used by both
# RLDRAMII_p0_pin_assignments.tcl and RLDRAMII_p0.sdc scripts. 
#
# These routines are only meant to support these two scripts. 
# Trying to using them in a different context can have unexpected 
# results.

set script_dir [file dirname [info script]]

source [file join $script_dir RLDRAMII_p0_parameters.tcl]
load_package sdc_ext

proc RLDRAMII_p0_find_all_pins { mystring } {
	set allpins [get_pins -compatibility_mode $mystring ]

	foreach_in_collection pin $allpins {
		set pinname [ get_pin_info -name $pin ]

		puts "$pinname"
	}
}


proc RLDRAMII_p0_index_in_collection { col j } {
	set i 0
	foreach_in_collection path $col {
		if {$i == $j} {
			return $path
		}
		set i [expr $i + 1]
	}
	return ""
}


proc RLDRAMII_p0_get_clock_to_pin_name_mapping {} {
	set result [list]
	set clocks_collection [get_clocks]
	foreach_in_collection clock $clocks_collection { 
		set clock_name [get_clock_info -name $clock] 
		set clock_target [get_clock_info -targets $clock]
		set first_index [RLDRAMII_p0_index_in_collection $clock_target 0]
		set catch_exception [catch {get_pin_info -name $first_index} pin_name]
		if {$catch_exception == 0} {
			lappend result [list $clock_name $pin_name]
		}
	}
	return $result
}              


proc RLDRAMII_p0_get_clock_name_from_pin_name { pin_name } {
	set table [RLDRAMII_p0_get_clock_to_pin_name_mapping]
	foreach entry $table {
		if {[string compare [lindex [lindex [split $entry] 1] 0] $pin_name] == 0} {
			return [lindex $entry 0]
		}
	}
	return ""
}


proc RLDRAMII_p0_get_clock_name_from_pin_name_vseries {pin_name suffix} {
	set name [RLDRAMII_p0_get_clock_name_from_pin_name $pin_name]
	if {[string compare -nocase $name ""] == 0} {
		set pll_clock $pin_name
		regsub {~PLL_OUTPUT_COUNTER\|divclk$} $pll_clock "" pll_clock
		regsub {_phy$} $pll_clock "" pll_clock
		regsub {[0-9]+$} $pll_clock "" pll_clock
		set pll_clock "${pll_clock}_${suffix}"
	} else {
		set pll_clock $name
	}
	return $pll_clock
}


proc RLDRAMII_p0_get_clock_name_from_pin_name_pre_vseries {pin_name suffix} {
	set name [RLDRAMII_p0_get_clock_name_from_pin_name $pin_name]
	if {[string compare -nocase $name ""] == 0} {
		set pll_clock $pin_name
		regsub {upll_memphy\|auto_generated\|pll1\|clk\[[0-9]+\]$} $pll_clock "pll" pll_clock
		set pll_clock "${pll_clock}_${suffix}"
	} else {
		set pll_clock $name
	}
	return $pll_clock
}

proc RLDRAMII_p0_get_or_add_clock_vseries_from_virtual_refclk {args} {
	array set opts { /
		-suffix "" /
		-target "" /
		-period "" /
		-phase 0 }

	array set opts $args
	
	set clock_name [RLDRAMII_p0_get_clock_name_from_pin_name $opts(-target)]

	
	if {[string compare -nocase $clock_name ""] == 0} {
		set clock_name $opts(-target)
		set suffix $opts(-suffix)
		
		regsub {~PLL_OUTPUT_COUNTER\|divclk$} $clock_name "" clock_name
		regsub {_phy$} $clock_name "" clock_name
		regsub {[0-9]+$} $clock_name "" clock_name
		set clock_name "${clock_name}_${suffix}"
		set re [expr $opts(-period) * $opts(-phase)/360]
		set fe [expr $opts(-period) * $opts(-phase)/360 + $opts(-period)/2]
		
		create_clock \
			-name $clock_name \
			-period $opts(-period) \
			-waveform [ list $re $fe ] \
			$opts(-target)
	}
	
	return $clock_name
}

proc RLDRAMII_p0_get_or_add_clock_vseries {args} {
	array set opts { /
		-suffix "" /
		-target "" /
		-source "" /
		-multiply_by 1 /
		-divide_by 1 /
		-phase 0 }

	array set opts $args
	set target $opts(-target)

	set clock_name [RLDRAMII_p0_get_clock_name_from_pin_name $opts(-target)]
	
	if {[string compare -nocase $clock_name ""] == 0} {
		set clock_name $opts(-target)
		set suffix $opts(-suffix)
		
		regsub {~PLL_OUTPUT_COUNTER\|divclk$} $clock_name "" clock_name
		regsub {_phy$} $clock_name "" clock_name
		regsub {[0-9]+$} $clock_name "" clock_name
		regsub -all {\\} $clock_name "" clock_name
		set clock_name "${clock_name}_${suffix}"
		set source_name "\{$opts(-source)\}"

		create_generated_clock \
			-name ${clock_name} \
			-source ${source_name} \
			-multiply_by $opts(-multiply_by) \
			-divide_by $opts(-divide_by) \
			-phase $opts(-phase) \
			$target
	}
	
	return $clock_name
}

proc RLDRAMII_p0_get_or_add_clock_pre_vseries {args} {
	array set opts { /
		-suffix "" /
		-target "" /
		-source "" /
		-multiply_by 1 /
		-divide_by 1 /
		-phase 0 }

	array set opts $args
	
	set clock_name [RLDRAMII_p0_get_clock_name_from_pin_name $opts(-target)]
	
	if {[string compare -nocase $clock_name ""] == 0} {
		set clock_name $opts(-target)
		set suffix $opts(-suffix)
		
		regsub {upll_memphy\|auto_generated\|pll1\|clk\[[0-9]+\]$} $clock_name "pll" clock_name
		set clock_name "${clock_name}_${suffix}"
		
		create_generated_clock \
			-name $clock_name \
			-source $opts(-source) \
			-multiply_by $opts(-multiply_by) \
			-divide_by $opts(-divide_by) \
			-phase $opts(-phase) \
			$opts(-target)
	}
	
	return $clock_name
}


proc RLDRAMII_p0_get_source_clock_pin_name {node_name} {

	set nodename ""
	set nodes [get_nodes $node_name]
	RLDRAMII_p0_traverse_fanin_up_to_depth [RLDRAMII_p0_index_in_collection $nodes 0] RLDRAMII_p0_is_node_type_pll_clk clock results_array 10
	if {[array size results_array] == 1} {
		set pin_id [lindex [array names results_array] 0]
		if {[string compare -nocase $pin_id ""] != 0} {
			set nodename [get_node_info -name $pin_id]
		}
	}
	return $nodename
}


proc RLDRAMII_p0_find_all_keepers { mystring } {
	set allkeepers [get_keepers $mystring ]

	foreach_in_collection keeper $allkeepers {
		set keepername [ get_node_info -name $keeper ]

		puts "$keepername"
	}
}

proc RLDRAMII_p0_round_3dp { x } {
	return [expr { round($x * 1000) / 1000.0  } ]
}

proc RLDRAMII_p0_get_timequest_name {hier_name} {
	set sta_name ""
	for {set inst_start [string first ":" $hier_name]} {$inst_start != -1} {} {
		incr inst_start
		set inst_end [string first "|" $hier_name $inst_start]
		if {$inst_end == -1} {
			append sta_name [string range $hier_name $inst_start end]
			set inst_start -1
		} else {
			append sta_name [string range $hier_name $inst_start $inst_end]
			set inst_start [string first ":" $hier_name $inst_end]
		}
	}
	return $sta_name
}

proc RLDRAMII_p0_are_entity_names_on { } {
	set entity_names_on 1


	return [set_project_mode -is_show_entity]	
}

proc RLDRAMII_p0_get_core_instance_list {corename} {
	set full_instance_list [RLDRAMII_p0_get_core_full_instance_list $corename]
	set instance_list [list]

	foreach inst $full_instance_list {
		set sta_name [RLDRAMII_p0_get_timequest_name $inst]
		if {[lsearch $instance_list [escape_brackets $sta_name]] == -1} {
			lappend instance_list $sta_name
		}
	}
	return $instance_list
}

proc RLDRAMII_p0_get_core_full_instance_list {corename} {
	set allkeepers [get_keepers * ]

	set_project_mode -always_show_entity_name on

	set instance_list [list]

	set inst_regexp {(^.*}
	append inst_regexp {:[A-Za-z0-9\.\\_\[\]\-\$():]+)\|}
	append inst_regexp ${corename}
	append inst_regexp {:[A-Za-z0-9\.\\_\[\]\-\$():]+\|}
	append inst_regexp "${corename}_memphy"
        append inst_regexp {:umemphy}

	foreach_in_collection keeper $allkeepers {
		set name [ get_node_info -name $keeper ]

		if {[regexp -- $inst_regexp $name -> hier_name] == 1} {
			if {[lsearch $instance_list [escape_brackets $hier_name]] == -1} {
				lappend instance_list $hier_name
			}
		}
	}

	set_project_mode -always_show_entity_name qsf

	if {[ llength $instance_list ] == 0} {
		post_message -type error "The auto-constraining script was not able to detect any instance for core < $corename >"
		post_message -type error "Verify the following:"
		post_message -type error " The core < $corename > is instantiated within another component (wrapper)"
		post_message -type error " The core is not the top-level of the project"
		post_message -type error " The memory interface pins are exported to the top-level of the project"
		post_message -type error "Alternatively, if you are no longer instantiating core < $corename >,"
		post_message -type error " clean up any stale SDC_FILE references from the QSF/QIP files."
	}

	return $instance_list
}


proc RLDRAMII_p0_traverse_fanin_up_to_depth { node_id match_command edge_type results_array_name depth} {
	upvar 1 $results_array_name results

	if {$depth < 0} {
		error "Internal error: Bad timing netlist search depth"
	}
	set fanin_edges [get_node_info -${edge_type}_edges $node_id]
	set number_of_fanin_edges [llength $fanin_edges]
	for {set i 0} {$i != $number_of_fanin_edges} {incr i} {
		set fanin_edge [lindex $fanin_edges $i]
		set fanin_id [get_edge_info -src $fanin_edge]
		if {$match_command == "" || [eval $match_command $fanin_id] != 0} {
			set results($fanin_id) 1
		} elseif {$depth == 0} {
		} else {
			RLDRAMII_p0_traverse_fanin_up_to_depth $fanin_id $match_command $edge_type results [expr {$depth - 1}]
		}
	}
}
proc RLDRAMII_p0_is_node_type_pll_inclk { node_id } {
	set cell_id [get_node_info -cell $node_id]
	
	if {$cell_id == ""} {
		set result 0
	} else {
		set atom_type [get_cell_info -atom_type $cell_id]
		if {$atom_type == "FRACTIONAL_PLL"} {
			set node_name [get_node_info -name $node_id]
			set fanin_edges [get_node_info -clock_edges $node_id]
			if {([string match "*|refclkin" $node_name] || [string match "*|refclkin\\\[0\\\]" $node_name]) && [llength $fanin_edges] > 0} {
				set result 1
			} else {
				set result 0
			}
		} elseif {$atom_type == "HPS_SDRAM_PLL"} {
			set node_name [get_node_info -name $node_id]
			set fanin_edges [get_node_info -clock_edges $node_id]
			if {[string match "*|ref_clk" $node_name] && [llength $fanin_edges] > 0} {
				set result 1
			} else {
				set result 0
			}
		} elseif {$atom_type == "PLL"} {
			set node_name [get_node_info -name $node_id]
			set fanin_edges [get_node_info -clock_edges $node_id]
			if {([string match "*|refclk" $node_name] || [string match "*|refclk\\\[0\\\]" $node_name]) && [llength $fanin_edges] > 0} {
				set result 1
			} else {
				set result 0
			}
		} else {
			set result 0
		}
	}
	return $result
}

proc RLDRAMII_p0_is_node_type_pin { node_id } {
	set node_type [get_node_info -type $node_id]
	if {$node_type == "port"} {
		set result 1
	} else {
		set result 0
	}
	return $result
}

proc RLDRAMII_p0_get_input_clk_id { pll_output_node_id } {
	if {[RLDRAMII_p0_is_node_type_pll_clk $pll_output_node_id]} {
		array set results_array [list]
		RLDRAMII_p0_traverse_fanin_up_to_depth $pll_output_node_id RLDRAMII_p0_is_node_type_pll_inclk clock results_array 2
		if {[array size results_array] == 1} {
			# Found PLL inclk, now find the input pin
			set pll_inclk_id [lindex [array names results_array] 0]
			array unset results_array
			# If fed by a pin, it should be fed by a dedicated input pin,
			# and not a global clock network.  Limit the search depth to
			# prevent finding pins fed by global clock (only allow io_ibuf pins)
			RLDRAMII_p0_traverse_fanin_up_to_depth $pll_inclk_id RLDRAMII_p0_is_node_type_pin clock results_array 5
			if {[array size results_array] == 1} {
				# Fed by a dedicated input pin
				set pin_id [lindex [array names results_array] 0]
				set result $pin_id
			} else {
				RLDRAMII_p0_traverse_fanin_up_to_depth $pll_inclk_id RLDRAMII_p0_is_node_type_pll_clk clock pll_clk_results_array 1
				RLDRAMII_p0_traverse_fanin_up_to_depth $pll_inclk_id RLDRAMII_p0_is_node_type_pll_clk clock pll_clk_results_array2 2
				if {[array size pll_clk_results_array] == 1} {
					#  Fed by a neighboring PLL via cascade path.
					#  Should be okay as long as that PLL has its input clock
					#  fed by a dedicated input.  If there isn't, TimeQuest will give its own warning about undefined clocks.
					set source_pll_clk_id [lindex [array names pll_clk_results_array] 0]
					set source_pll_clk [get_node_info -name $source_pll_clk_id]
					set result [RLDRAMII_p0_get_input_clk_id $source_pll_clk_id]
					if {$result != -1} {
						post_message -type info "Please ensure source clock is defined for PLL with output $source_pll_clk"
					} else {
						#  Fed from core
						post_message -type critical_warning "PLL clock $source_pll_clk not driven by a dedicated clock pin.  To ensure minimum jitter on memory interface clock outputs, the PLL clock source should be a dedicated PLL input clock pin. Timing analyses may not be valid."
					}
					
				} elseif {[array size pll_clk_results_array2] == 1} {
					#  Fed by a neighboring PLL via global clocks
					#  This is not ok
					set source_pll_clk_id [lindex [array names pll_clk_results_array2] 0]
					set source_pll_clk [get_node_info -name $source_pll_clk_id]
					post_message -type critical_warning "PLL clock [get_node_info -name $pll_output_node_id] not driven by a dedicated clock pin or neighboring PLL source.  To ensure minimum jitter on memory interface clock outputs, the PLL clock source should be a dedicated PLL input clock pin or an output of the neighboring PLL, and not go through a global clock network. Timing analyses may not be valid."
					set result [RLDRAMII_p0_get_input_clk_id $source_pll_clk_id]
				
				} else {
					#  If you got here it's because there's a buffer between the PLL input and the PIN. Issue a warning
					#  but keep searching for the pin anyways, otherwise all the timing constraining scripts will
					#  crash
					post_message -type critical_warning "PLL clock [get_node_info -name $pll_output_node_id] not driven by a dedicated clock pin or neighboring PLL source.  To ensure minimum jitter on memory interface clock outputs, the PLL clock source should be a dedicated PLL input clock pin or an output of the neighboring PLL. Timing analyses may not be valid."
					RLDRAMII_p0_traverse_fanin_up_to_depth $pll_inclk_id RLDRAMII_p0_is_node_type_pin clock results_array 9
					if {[array size results_array] == 1} {
						set pin_id [lindex [array names results_array] 0]
						set result $pin_id
					} else {
						post_message -type critical_warning "Could not find PLL clock for [get_node_info -name $pll_output_node_id]"
						set result -1
					}
				}
			}
		} else {
			post_message -type critical_warning "Could not find PLL clock for [get_node_info -name $pll_output_node_id]"
			set result -1
		}
	} else {
		error "Internal error: RLDRAMII_p0_get_input_clk_id only works on PLL output clocks"
	}
	return $result
}

proc RLDRAMII_p0_is_node_type_pll_clk { node_id } {
	set cell_id [get_node_info -cell $node_id]
	
	if {$cell_id == ""} {
		set result 0
	} else {
		set atom_type [get_cell_info -atom_type $cell_id]
		if {$atom_type == "PLL_OUTPUT_COUNTER"} {
			set node_name [get_node_info -name $node_id]
			if {[string match "*|pll*~PLL_OUTPUT_COUNTER*|divclk" $node_name]} {
				set result 1
			} else {
				set result 0
			}
		} elseif {$atom_type == "HPS_SDRAM_PLL"} {
			set node_name [get_node_info -name $node_id]
			if {[string match "*|*pll|*_clk" $node_name]} {
				set result 1
			} else {
				set result 0
			}
		} elseif {$atom_type == "PLL"} {
			set node_name [get_node_info -name $node_id]
			if {[string match "*|pll*|divclk" $node_name]} {
				set result 1
			} else {
				set result 0
			}
		} else {
			set result 0
		}
	}
	return $result
}

proc RLDRAMII_p0_get_pll_clock { dest_id_list node_type clock_id_name search_depth} {
	if {$clock_id_name != ""} {
		upvar 1 $clock_id_name clock_id
	}
	set clock_id -1

	array set clk_array [list]
	foreach node_id $dest_id_list {
		RLDRAMII_p0_traverse_fanin_up_to_depth $node_id RLDRAMII_p0_is_node_type_pll_clk clock clk_array $search_depth
	}
	if {[array size clk_array] == 1} {
		set clock_id [lindex [array names clk_array] 0]
		set clk [get_node_info -name $clock_id]
	} elseif {[array size clk_array] > 1} {
		puts "Found more than 1 clock driving the $node_type"
		set clk ""
	} else {
		set clk ""
	}

	return $clk
}

proc RLDRAMII_p0_get_pll_clock_name { clock_id } {
	set clock_name [get_node_info -name $clock_id]

	return $clock_name
}

proc RLDRAMII_p0_get_pll_clock_name_for_acf { clock_id pll_output_wire_name } {
	set clock_name [get_node_info -name $clock_id]
	regexp {(.*)\|pll\d+\~PLL_OUTPUT_COUNTER} $clock_name matched clock_name
	regexp {(.*)\|pll\d+_phy\~PLL_OUTPUT_COUNTER} $clock_name matched clock_name
	set clock_name "$clock_name|$pll_output_wire_name"
	return $clock_name
}

proc RLDRAMII_p0_get_output_clock_id { ddio_output_pin_list pin_type msg_list_name {max_search_depth 20} } {
	upvar 1 $msg_list_name msg_list
	set output_clock_id -1
	
	set output_id_list [list]
	set pin_collection [get_keepers -no_duplicates $ddio_output_pin_list]
	if {[get_collection_size $pin_collection] == [llength $ddio_output_pin_list]} {
		foreach_in_collection id $pin_collection {
			lappend output_id_list $id
		}
	} elseif {[get_collection_size $pin_collection] == 0} {
		lappend msg_list "warning" "Could not find any $pin_type pins"
	} else {
		lappend msg_list "warning" "Could not find all $pin_type pins"
	}
	RLDRAMII_p0_get_pll_clock $output_id_list $pin_type output_clock_id $max_search_depth
	return $output_clock_id
}

proc RLDRAMII_p0_get_output_clock_id2 { ddio_output_pin_list pin_type msg_list_name {max_search_depth 20} } {
	upvar 1 $msg_list_name msg_list
	set output_clock_id -1
	
	set output_id_list [list]
	set pin_collection [get_pins -no_duplicates $ddio_output_pin_list]
	if {[get_collection_size $pin_collection] == [llength $ddio_output_pin_list]} {
		foreach_in_collection id $pin_collection {
			lappend output_id_list $id
		}
	} elseif {[get_collection_size $pin_collection] == 0} {
		lappend msg_list "warning" "Could not find any $pin_type pins"
	} else {
		lappend msg_list "warning" "Could not find all $pin_type pins"
	}
	RLDRAMII_p0_get_pll_clock $output_id_list $pin_type output_clock_id $max_search_depth
	return $output_clock_id
}

proc RLDRAMII_p0_is_node_type_clkbuf { node_id } {
	set cell_id [get_node_info -cell $node_id]
	if {$cell_id == ""} {
		set result 0
	} else {
		set atom_type [get_cell_info -atom_type $cell_id]
		if {$atom_type == "CLKBUF" || $atom_type == "PHY_CLKBUF"} {
			set result 1
		} else {
			set result 0
		}
	}
	return $result
}

proc RLDRAMII_p0_get_clkbuf_clock { dest_id_list node_type clock_id_name search_depth} {
	if {$clock_id_name != ""} {
		upvar 1 $clock_id_name clock_id
	}
	set clock_id -1

	array set clk_array [list]
	foreach node_id $dest_id_list {
		RLDRAMII_p0_traverse_fanin_up_to_depth $node_id RLDRAMII_p0_is_node_type_clkbuf clock clk_array $search_depth
	}
	if {[array size clk_array] == 1} {
		set clock_id [lindex [array names clk_array] 0]
		set clk [get_node_info -name $clock_id]
	} elseif {[array size clk_array] > 1} {
		set clk ""
	} else {
		set clk ""
	}

	return $clk
}

proc RLDRAMII_p0_get_output_clock_clkbuf_id { ddio_output_pin_list pin_type msg_list_name {max_search_depth 20} } {
	upvar 1 $msg_list_name msg_list
	set output_clock_id -1
	
	set output_id_list [list]
	set pin_collection [get_keepers -no_duplicates $ddio_output_pin_list]
	if {[get_collection_size $pin_collection] == [llength $ddio_output_pin_list]} {
		foreach_in_collection id $pin_collection {
			lappend output_id_list $id
		}
	} elseif {[get_collection_size $pin_collection] == 0} {
		lappend msg_list "warning" "Could not find any $pin_type pins"
	} else {
		lappend msg_list "warning" "Could not find all $pin_type pins"
	}
	RLDRAMII_p0_get_clkbuf_clock $output_id_list $pin_type output_clock_id $max_search_depth
	return $output_clock_id
}


proc RLDRAMII_p0_is_node_type_clk_phase_select { node_id } {
	set cell_id [get_node_info -cell $node_id]
	if {$cell_id == ""} {
		set result 0
	} else {
		set atom_type [get_cell_info -atom_type $cell_id]
		if {$atom_type == "CLK_PHASE_SELECT"} {
			set result 1
		} else {
			set result 0
		}
	}
	return $result
}

proc RLDRAMII_p0_get_clk_phase_select_clock { dest_id_list node_type clock_id_name search_depth} {
	if {$clock_id_name != ""} {
		upvar 1 $clock_id_name clock_id
	}
	set clock_id -1

	array set clk_array [list]
	foreach node_id $dest_id_list {
		RLDRAMII_p0_traverse_fanin_up_to_depth $node_id RLDRAMII_p0_is_node_type_clk_phase_select clock clk_array $search_depth
	}
	if {[array size clk_array] == 1} {
		set clock_id [lindex [array names clk_array] 0]
		set clk [get_node_info -name $clock_id]
	} elseif {[array size clk_array] > 1} {
		set clk ""
	} else {
		set clk ""
	}

	return $clk
}

proc RLDRAMII_p0_get_output_clock_clk_phase_select_id { ddio_output_pin_list pin_type msg_list_name {max_search_depth 20} } {
	upvar 1 $msg_list_name msg_list
	set output_clock_id -1
	
	set output_id_list [list]
	set pin_collection [get_keepers -no_duplicates $ddio_output_pin_list]
	if {[get_collection_size $pin_collection] == [llength $ddio_output_pin_list]} {
		foreach_in_collection id $pin_collection {
			lappend output_id_list $id
		}
	} elseif {[get_collection_size $pin_collection] == 0} {
		lappend msg_list "warning" "Could not find any $pin_type pins"
	} else {
		lappend msg_list "warning" "Could not find all $pin_type pins"
	}
	RLDRAMII_p0_get_clk_phase_select_clock $output_id_list $pin_type output_clock_id $max_search_depth
	return $output_clock_id
}

proc post_sdc_message {msg_type msg} {
	if { $::TimeQuestInfo(nameofexecutable) != "quartus_fit"} {
		post_message -type $msg_type $msg
	}
}

proc RLDRAMII_p0_get_names_in_collection { col } {
	set res [list]
	foreach_in_collection node $col {
		lappend res [ get_node_info -name $node ]
	}
	return $res
}

proc RLDRAMII_p0_static_map_expand_list { FH listname pinname } {
	upvar $listname local_list

	puts $FH ""
	puts $FH "   # $pinname"
	puts $FH "   set pins($pinname) \[ list \]"
	foreach pin $local_list($pinname) {
		puts $FH "   lappend pins($pinname) $pin"
	}
}

proc RLDRAMII_p0_static_map_expand_list_of_list { FH listname pinname } {
	upvar $listname local_list

	puts $FH ""
	puts $FH "   # $pinname"
	puts $FH "   set pins($pinname) \[ list \]"
	set count_groups 0
	foreach sublist $local_list($pinname) {
		puts $FH ""
		puts $FH "   # GROUP - ${count_groups}"
		puts $FH "   set group_${count_groups} \[ list \]"
		foreach pin $sublist {
			puts $FH "   lappend group_${count_groups} $pin"
		}
		puts $FH ""
		puts $FH "   lappend pins($pinname) \$group_${count_groups}"

		incr count_groups
	}
}

proc RLDRAMII_p0_static_map_expand_string { FH stringname pinname } {
	upvar $stringname local_string

	puts $FH ""
	puts $FH "   # $pinname"
	puts $FH "   set pins($pinname) $local_string($pinname)"
}

proc RLDRAMII_p0_format_3dp { x } {
	return [format %.3f $x]
}

proc RLDRAMII_p0_get_colours { x y } {

	set fcolour [list "black"]
	if {$x < 0} {
		lappend fcolour "red"
	} else {
		lappend fcolour "blue"
	}
	if {$y < 0} {
		lappend fcolour "red"
	} else {
		lappend fcolour "blue"
	}
	
	return $fcolour
}

proc min { a b } {
	if { $a == "" } { 
		return $b
	} elseif { $a < $b } {
		return $a
	} else {
		return $b
	}
}

proc max { a b } {
	if { $a == "" } { 
		return $b
	} elseif { $a > $b } {
		return $a
	} else {
		return $b
	}
}

proc RLDRAMII_p0_max_in_collection { col attribute } {
	set i 0
	set max 0
	foreach_in_collection path $col {
		if {$i == 0} {
			set max [get_path_info $path -${attribute}]
		} else {
			set temp [get_path_info $path -${attribute}]
			if {$temp > $max} {
				set max $temp
			} 
		}
		set i [expr $i + 1]
	}
	return $max
}

proc RLDRAMII_p0_min_in_collection { col attribute } {
	set i 0
	set min 0
	foreach_in_collection path $col {
		if {$i == 0} {
			set min [get_path_info $path -${attribute}]
		} else {
			set temp [get_path_info $path -${attribute}]
			if {$temp < $min} {
				set min $temp
			} 
		}
		set i [expr $i + 1]
	}
	return $min
}

proc RLDRAMII_p0_min_in_collection_to_name { col attribute name } {
	set i 0
	set min 0
	foreach_in_collection path $col {
		if {[get_node_info -name [get_path_info $path -to]] == $name} {
			if {$i == 0} {
				set min [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp < $min} {
					set min $temp
				} 
			}
			set i [expr $i + 1]		
		}
	}
	return $min
}

proc RLDRAMII_p0_min_in_collection_from_name { col attribute name } {
	set i 0
	set min 0
	foreach_in_collection path $col {
		if {[get_node_info -name [get_path_info $path -from]] == $name} {
			if {$i == 0} {
				set min [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp < $min} {
					set min $temp
				} 
			}
			set i [expr $i + 1]			
		}
	}
	return $min
}

proc RLDRAMII_p0_max_in_collection_to_name { col attribute name } {
	set i 0
	set max 0
	foreach_in_collection path $col {
		if {[get_node_info -name [get_path_info $path -to]] == $name} {
			if {$i == 0} {
				set max [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp > $max} {
					set max $temp
				} 
			}
			set i [expr $i + 1]					
		}
	}
	return $max
}

proc RLDRAMII_p0_max_in_collection_from_name { col attribute name } {
	set i 0
	set max 0
	foreach_in_collection path $col {
		if {[get_node_info -name [get_path_info $path -from]] == $name} {
			if {$i == 0} {
				set max [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp > $max} {
					set max $temp
				} 
			}
			set i [expr $i + 1]
		}
	}
	return $max
}


proc RLDRAMII_p0_min_in_collection_to_name2 { col attribute name } {
	set i 0
	set min 0
	foreach_in_collection path $col {
		if {[regexp $name [get_node_info -name [get_path_info $path -to]]]} {
			if {$i == 0} {
				set min [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp < $min} {
					set min $temp
				} 
			}
			set i [expr $i + 1]		
		}
	}
	return $min
}

proc RLDRAMII_p0_min_in_collection_from_name2 { col attribute name } {
	set i 0
	set min 0
	foreach_in_collection path $col {
		if {[regexp $name [get_node_info -name [get_path_info $path -from]]]} {
			if {$i == 0} {
				set min [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp < $min} {
					set min $temp
				} 
			}
			set i [expr $i + 1]
		}
	}
	return $min
}

proc RLDRAMII_p0_max_in_collection_to_name2 { col attribute name } {
	set i 0
	set max 0
	foreach_in_collection path $col {
		if {[regexp $name [get_node_info -name [get_path_info $path -to]]]} {
			if {$i == 0} {
				set max [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp > $max} {
					set max $temp
				} 
			}
			set i [expr $i + 1]				
		}
	}
	return $max
}

proc RLDRAMII_p0_max_in_collection_from_name2 { col attribute name } {
	set i 0
	set max 0
	foreach_in_collection path $col {
		if {[regexp $name [get_node_info -name [get_path_info $path -from]]]} {
			if {$i == 0} {
				set max [get_path_info $path -${attribute}]
			} else {
				set temp [get_path_info $path -${attribute}]
				if {$temp > $max} {
					set max $temp
				} 
			}
			set i [expr $i + 1]
		}
	}
	return $max
}


proc RLDRAMII_p0_get_max_clock_path_delay_through_clock_node {from through to} {
	set init 0
	set max_delay 0
	set paths [get_path -rise_from $through -rise_to $to]
	foreach_in_collection path1 $paths {
		set delay [get_path_info $path1 -arrival_time]
		set clock_node [get_node_info -name [get_path_info $path1 -from]]
				
		set paths2 [get_path -rise_from $from -rise_to $clock_node]
		foreach_in_collection path2 $paths2 {
			set total_delay [expr $delay + [get_path_info $path2 -arrival_time]]
			if {$init == 0 || $total_delay > $max_delay} {
				set init 1
				set max_delay $total_delay
			}
		}
	}
	return $max_delay
}

proc RLDRAMII_p0_get_min_clock_path_delay_through_clock_node {from through to} {
	set init 0
	set min_delay 0
	set paths [get_path -rise_from $through -rise_to $to -min_path]
	foreach_in_collection path1 $paths {
		set delay [get_path_info $path1 -arrival_time]
		set clock_node [get_node_info -name [get_path_info $path1 -from]]

		set paths2 [get_path -rise_from $from -rise_to $clock_node -min_path]
		foreach_in_collection path2 $paths2 {
			set total_delay [expr $delay + [get_path_info $path2 -arrival_time]]
			if {$init == 0 || $total_delay < $min_delay} {
				set init 1
				set min_delay $total_delay
			}
		}
	}
	return $min_delay
}

proc RLDRAMII_p0_get_model_corner {} {

	set operating_conditions [get_operating_conditions]
	set return_value [list]
	if {[regexp {^([0-9])_H([0-9])_([a-z]+)_([a-z0-9_\-]+)} $operating_conditions matched speedgrade transceiver model corner]} {

	} elseif {[regexp {^([A-Z0-9]+)_([a-z]+)_([a-z0-9_\-]+)} $operating_conditions matched speedgrade model corner]} {

	}
	regsub {\-} $corner "n" corner
	set return_value [list $model $corner]
	return $return_value
}

proc RLDRAMII_p0_get_min_aiot_delay {pinname} {

	set atom_id [get_atom_node_by_name -name $pinname]
	set sin_pin [create_pin_object -atom $atom_id]
	set results [get_simulation_results -pin $sin_pin -aiot]
	
	set rise 0
	set fall 0
	foreach { key value } $results {
		if {$key == "Absolute Rise Delay to Far-end"} {
			set rise $value
		} elseif {$key == "Absolute Fall Delay to Far-end"} {
			set fall $value
		}
	}
	return [min $rise $fall]
}

proc RLDRAMII_p0_get_rise_aiot_delay {pinname} {

	set atom_id [get_atom_node_by_name -name $pinname]
	set sin_pin [create_pin_object -atom $atom_id]
	set results [get_simulation_results -pin $sin_pin -aiot]
	
	set rise 0
	foreach { key value } $results {
            if {$key == "Absolute Rise Delay to Far-end"} {
               set rise $value
            }
	}
	return $rise
}

proc RLDRAMII_p0_get_fall_aiot_delay {pinname} {

	set atom_id [get_atom_node_by_name -name $pinname]
	set sin_pin [create_pin_object -atom $atom_id]
	set results [get_simulation_results -pin $sin_pin -aiot]
	
	set fall 0
	foreach { key value } $results {
            if {$key == "Absolute Fall Delay to Far-end"} {
               set fall $value
            }
	}
	return $fall
}


proc RLDRAMII_p0_get_aiot_attr {pinname attr} {

	set atom_id [get_atom_node_by_name -name $pinname]
	set sin_pin [create_pin_object -atom $atom_id]
	set results [get_simulation_results -pin $sin_pin -aiot]
	
	set value 0
	foreach { key value } $results {
		if {$key == $attr} {
			return $value
		} 
	}
	return $value
}

proc RLDRAMII_p0_get_pll_phase_shift {output_counter_name} {
	load_package atoms
	read_atom_netlist
	set phase_shift ""
	
	# Remove possible "|divclk" at the end of the name
	regsub {\|divclk$} $output_counter_name "" output_counter_name

	# Get all PLL output counters
	set pll_output_counter_atoms [get_atom_nodes -type PLL_OUTPUT_COUNTER]
	
	# Go through the output counters and find the one that matches the above and return the phase
	foreach_in_collection atom $pll_output_counter_atoms { 
		set name [get_atom_node_info -key name -node $atom] 
		regsub {^[^\:]+\:} $name "" name
		regsub -all {\|[^\:]+\:} $name "|" name
		
		# If the name matches return the phase shift
		if {$name == $output_counter_name} {
			set phase_shift [get_atom_node_info -key TIME_PHASE_SHIFT -node $atom]
			regsub { ps} $phase_shift "" phase_shift
			break
		}
	}
	return $phase_shift
}

# ----------------------------------------------------------------
#
proc RLDRAMII_p0_get_io_standard {target_pin} {
#
# Description: Gets the I/O standard of the given memory interface pin
#              This function assumes the fitter has already completed and the
#              compiler report has been loaded.
#
# ----------------------------------------------------------------
	# Look through the pin report
	set io_std [RLDRAMII_p0_get_fitter_report_pin_info $target_pin "I/O Standard" -1]
	if {$io_std == ""} {
		return "UNKNOWN"
	}
	set result ""
	switch -exact -- $io_std {
		"SSTL-2 Class I" {set result "SSTL_2_I"}
		"Differential 2.5-V SSTL Class I" {set result "DIFF_SSTL_2_I"}
		"SSTL-2 Class II" {set result "SSTL_2_II"}
		"Differential 2.5-V SSTL Class II" {set result "DIFF_SSTL_2_II"}
		"SSTL-18 Class I" {set result "SSTL_18_I"}
		"Differential 1.8-V SSTL Class I" {set result "DIFF_SSTL_18_I"}
		"SSTL-18 Class II" {set result "SSTL_18_II"}
		"Differential 1.8-V SSTL Class II" {set result "DIFF_SSTL_18_II"}
		"SSTL-15 Class I" {set result "SSTL_15_I"}
		"Differential 1.5-V SSTL Class I" {set result "DIFF_SSTL_15_I"}
		"SSTL-15 Class II" {set result "SSTL_15_II"}
		"Differential 1.5-V SSTL Class II" {set result "DIFF_SSTL_15_II"}
		"1.8-V HSTL Class I" {set result "HSTL_18_I"}
		"Differential 1.8-V HSTL Class I" {set result "DIFF_HSTL_18_I"}
		"1.8-V HSTL Class II" {set result "HSTL_18_II"}
		"Differential 1.8-V HSTL Class II" {set result "DIFF_HSTL_18_II"}
		"1.5-V HSTL Class I" {set result "HSTL_I"}
		"Differential 1.5-V HSTL Class I" {set result "DIFF_HSTL"}
		"1.5-V HSTL Class II" {set result "HSTL_II"}
		"Differential 1.5-V HSTL Class II" {set result "DIFF_HSTL_II"}
		"1.2-V HSTL Class I" {set result "SSTL_125"}
		"Differential 1.2-V HSTL Class I" {set result "DIFF_SSTL_125"}
		"1.2-V HSTL Class II" {set result "SSTL_125"}
		"Differential 1.2-V HSTL Class II" {set result "DIFF_SSTL_125"}
		"SSTL-15" {set result "SSTL_15"}
		"Differential 1.5-V SSTL" {set result "DIFF_SSTL_15"}
		"SSTL-135" {set result "SSTL_135"}
		"Differential 1.35-V SSTL" {set result "DIFF_SSTL_135"}
		"SSTL-125" {set result "SSTL_125"}
		"Differential 1.25-V SSTL" {set result "DIFF_SSTL_125"}
		"SSTL-12" {set result "DIFF_SSTL_125"}
		"Differential 1.2-V HSUL" {set result "DIFF_HSUL_12"}
		default {
			post_message -type error "Found unsupported Memory I/O standard $io_std on pin $target_pin"
			set result "UNKNOWN"
		}
	}
	return $result
}

# Routine to find the termination pins
proc RLDRAMII_p0_get_rzq_pins { instname all_rzq_pins } {
	upvar $all_rzq_pins rzqpins
	load_package atoms
	read_atom_netlist
	set rzq_pins [ list ]
	set entity_names_on [ RLDRAMII_p0_are_entity_names_on ]
	
	# Get all termination atoms, to which rzqpin should be attached
	set_project_mode -always_show_entity_name off
	set instance ${instname}*
	set atoms [get_atom_nodes -type TERMINATION -matching [escape_brackets $instance] ]
	post_message -type info "Number of Termination Atoms are [get_collection_size $atoms]"
	foreach_in_collection term_atom $atoms { 
		set rzq_pin ""
		set atom $term_atom
		set term_atom_name [get_atom_node_info -key name -node $term_atom] 
		post_message -type info "Found Termination Atom $term_atom_name"
		set type [get_atom_node_info -key type -node $term_atom] 
		
		# Check until you traverse to an IO_PAD for the RZQ Pin
		while { ![regexp IO_PAD $type ] } { 
			set name [get_atom_node_info -key name -node $atom] 
			set iterms [get_atom_iports -node $atom]
			set iterm_size [llength $iterms]
			# Check for Multiple Inputs
			if { $iterm_size > 1 } {
				post_message -type error " Multiple inputs to a node:$name attached to a  Termination_Atom:$term_atom_name "
				break
			
			}
			
			foreach iterm $iterms { 
				set fanin	[get_atom_port_info -node $atom -type iport -port_id $iterm -key fanin]
				set atom [lindex $fanin 0]
				set type [get_atom_node_info -key type -node $atom]
				set rzq_pin [get_atom_node_info -key name -node $atom]
			}		
		}
			
		lappend rzq_pins [ join $rzq_pin ]
	}

	set_project_mode -always_show_entity_name qsf
	set rzqpins $rzq_pins
}


proc RLDRAMII_p0_get_acv_read_offset { period dqs_phase dqs_period } {

	set offset [expr abs(90/360.0*$period - $dqs_phase/360.0*$dqs_period)]
	if {$offset != 0} {
		set part_period [expr $dqs_phase/360.0*$dqs_period - 0.469/2.0 - 0.12]
		set offset [max 0.120 $part_period] 
	}

	return $offset
}
# (C) 2001-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


proc RLDRAMII_p0_sort_proc {a b} {
	set idxs [list 1 2 0]
	foreach i $idxs {
		set ai [lindex $a $i]
		set bi [lindex $b $i]
		if {$ai > $bi} {
			return 1
		} elseif { $ai < $bi } {
			return -1
		}
	}
	return 0
}

proc RLDRAMII_p0_traverse_atom_path {atom_id atom_oport_id path} {
	# Return list of {atom oterm_id} pairs by tracing the atom netlist starting from the given atom_id through the given path
	# Path consists of list of {atom_type fanin|fanout|end <port_type> <-optional>}
	set result [list]
	if {[llength $path] > 0} {
		set path_point [lindex $path 0]
		set atom_type [lindex $path_point 0]
		set next_direction [lindex $path_point 1]
		set port_type [lindex $path_point 2]
		set atom_optional [lindex $path_point 3]
		if {[get_atom_node_info -key type -node $atom_id] == $atom_type} {
			if {$next_direction == "end"} {
				if {[get_atom_port_info -key type -node $atom_id -port_id $atom_oport_id -type oport] == $port_type} {
					lappend result [list $atom_id $atom_oport_id]
				}
			} elseif {$next_direction == "atom"} {
				lappend result [list $atom_id]
			} elseif {$next_direction == "fanin"} {
				set atom_iport [get_atom_iport_by_type -node $atom_id -type $port_type]
				if {$atom_iport != -1} {
					set iport_fanin [get_atom_port_info -key fanin -node $atom_id -port_id $atom_iport -type iport]
					set source_atom [lindex $iport_fanin 0]
					set source_oterm [lindex $iport_fanin 1]
					set result [RLDRAMII_p0_traverse_atom_path $source_atom $source_oterm [lrange $path 1 end]]
				} elseif {$atom_optional == "-optional"} {
					set result [RLDRAMII_p0_traverse_atom_path $atom_id $atom_oport_id [lrange $path 1 end]]
				}
			} elseif {$next_direction == "fanout"} {
				set atom_oport [get_atom_oport_by_type -node $atom_id -type $port_type]
				if {$atom_oport != -1} {
					set oport_fanout [get_atom_port_info -key fanout -node $atom_id -port_id $atom_oport -type oport]
					foreach dest $oport_fanout {
						set dest_atom [lindex $dest 0]
						set dest_iterm [lindex $dest 1]
						set fanout_result_list [RLDRAMII_p0_traverse_atom_path $dest_atom -1 [lrange $path 1 end]]
						foreach fanout_result $fanout_result_list {
							if {[lsearch $result $fanout_result] == -1} {
								lappend result $fanout_result
							}
						}
					}
				}
			} else {
				error "Unexpected path"
			}
		} elseif {$atom_optional == "-optional"} {
			set result [RLDRAMII_p0_traverse_atom_path $atom_id $atom_oport_id [lrange $path 1 end]]
		}
	}
	return $result
}

# Get the fitter name of the PLL output driving the given pin
proc RLDRAMII_p0_traverse_to_ddio_out_pll_clock {pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set result ""
	if {$pin != ""} {
		set pin_id [get_atom_node_by_name -name $pin]
		set pin_to_pll_path [list {IO_PAD fanin PADIN} {IO_OBUF fanin I} {PSEUDO_DIFF_OUT fanin I -optional} {DELAY_CHAIN fanin DATAIN -optional} {DELAY_CHAIN fanin DATAIN -optional} {DDIO_OUT fanin CLKHI -optional} {OUTPUT_PHASE_ALIGNMENT fanin CLK -optional} {CLKBUF fanin INCLK -optional} {PLL end CLK}]
		set pll_id_list [RLDRAMII_p0_traverse_atom_path $pin_id -1 $pin_to_pll_path]
		if {[llength $pll_id_list] == 1} {
			set atom_oterm_pair [lindex $pll_id_list 0]
			set result [get_atom_port_info -key name -node [lindex $atom_oterm_pair 0] -port_id [lindex $atom_oterm_pair 1] -type oport]
		} else {
			lappend msg_list "Error: PLL clock not found for $pin"
		}
	}
	return $result
}

proc RLDRAMII_p0_traverse_to_leveling_delay_chain {pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set result ""
	if {$pin != ""} {
		set pin_id [get_atom_node_by_name -name $pin]
		set pin_to_leveling_path [list {IO_PAD fanin PADIN} {IO_OBUF fanin I} {PSEUDO_DIFF_OUT fanin I -optional} {DELAY_CHAIN fanin DATAIN -optional} {DELAY_CHAIN fanin DATAIN -optional} {DDIO_OUT fanin CLK -optional} {DDIO_OUT fanin CLKHI -optional} {CLK_PHASE_SELECT fanin CLKIN -optional} {LEVELING_DELAY_CHAIN end CLKOUT} ]
		set leveling_id_list [RLDRAMII_p0_traverse_atom_path $pin_id -1 $pin_to_leveling_path]
		if {[llength $leveling_id_list] == 1} {
			set atom_oterm_pair [lindex $leveling_id_list 0]
			set result [get_atom_node_info -key name -node [lindex $atom_oterm_pair 0]]
		} else {
			lappend msg_list "Error: Leveling delay chain not found for $pin"
		}
	}

	regsub {^[^\:]+\:} $result "" result
	regsub -all {\|[^\:]+\:} $result "|" result

	return $result
}

proc RLDRAMII_p0_traverse_to_clock_phase_select {pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set result ""
	if {$pin != ""} {
		set pin_id [get_atom_node_by_name -name $pin]
		set pin_to_cps_path [list {IO_PAD fanin PADIN} {IO_OBUF fanin I} {PSEUDO_DIFF_OUT fanin I -optional} {DELAY_CHAIN fanin DATAIN -optional} {DELAY_CHAIN fanin DATAIN -optional} {DDIO_OUT fanin CLK -optional} {FF fanin CLK -optional} {DDIO_OUT fanin CLKHI -optional} {CLK_PHASE_SELECT end CLKOUT}  ]
		set cps_id_list [RLDRAMII_p0_traverse_atom_path $pin_id -1 $pin_to_cps_path]
		if {[llength $cps_id_list] == 1} {
			set atom_oterm_pair [lindex $cps_id_list 0]
			set result [get_atom_node_info -key name -node [lindex $atom_oterm_pair 0]]
		} else {
			lappend msg_list "Error: Clock phase select not found for $pin"
		}
	}

	regsub {^[^\:]+\:} $result "" result
	regsub -all {\|[^\:]+\:} $result "|" result

	return $result
}

proc RLDRAMII_p0_traverse_to_clkbuf {pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set result ""
	if {$pin != ""} {
		set pin_id [get_atom_node_by_name -name $pin]
		set pin_to_clkbuf_path [list {IO_PAD fanin PADIN} {IO_OBUF fanin I} {PSEUDO_DIFF_OUT fanin I -optional} {DELAY_CHAIN fanin DATAIN -optional} {DELAY_CHAIN fanin DATAIN -optional} {DDIO_OUT fanin CLK -optional} {FF fanin CLK -optional} {DDIO_OUT fanin CLKHI -optional} {CLKBUF end OUTCLK}  ]
		set clkbuf_id_list [RLDRAMII_p0_traverse_atom_path $pin_id -1 $pin_to_clkbuf_path]
		if {[llength $clkbuf_id_list] == 1} {
			set atom_oterm_pair [lindex $clkbuf_id_list 0]
			set result [get_atom_node_info -key name -node [lindex $atom_oterm_pair 0]]
		} else {
			lappend msg_list "Error: Clock buffer not found for $pin"
		}
	}

	regsub {^[^\:]+\:} $result "" result
	regsub -all {\|[^\:]+\:} $result "|" result

	return $result
}

proc RLDRAMII_p0_traverse_to_dll {dqs_pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set dqs_pin_id [get_atom_node_by_name -name $dqs_pin]
	set dqs_to_dll_path [list {IO_PAD fanout PADOUT} {IO_IBUF fanout O} {DQS_DELAY_CHAIN fanin DELAYCTRLIN} {DLL end DELAYCTRLOUT}]
	set dll_id_list [RLDRAMII_p0_traverse_atom_path $dqs_pin_id -1 $dqs_to_dll_path]
	set result ""
	if {[llength $dll_id_list] == 1} {
		set dll_atom_oterm_pair [lindex $dll_id_list 0]
		set result [get_atom_node_info -key name -node [lindex $dll_atom_oterm_pair 0]]
	} elseif {[llength $dll_id_list] > 1} {
		lappend msg_list "Error: Found more than 1 DLL"
	} else {
		lappend msg_list "Error: DLL not found"
	}
	return $result
}

proc RLDRAMII_p0_check_hybrid_interface { inst pins_array_name mem_if_memtype } {
	upvar $pins_array_name pins

	foreach q_group $pins(q_groups) {
		set q_group $q_group
		lappend q_groups $q_group
	}
	set all_dq_pins [ join [ join $q_groups ] ]
	set dm_pins $pins(dm_pins)

	set all_dq_dm_pins [ concat $all_dq_pins $dm_pins ]
	foreach dq_dm_pin $all_dq_dm_pins {
		set io_type [RLDRAMII_p0_get_fitter_report_pin_io_type_info $dq_dm_pin]
		if {[string compare -nocase "Column I/O" $io_type] == 0} {
			set io_types("column") 1
		} elseif {[string compare -nocase "Row I/O" $io_type] == 0} {
			set io_types("row") 1
		} else {
			post_message -type warning "Could not determine IO type for pin $dq_dm_pin"
		}
	}

	if {[llength [array names io_types]] == 0} {
		post_message -type warning "Could not determine if memory interface $inst is implemented in hybrid mode. Assuming memory interface is implemented in non-hybrid mode"
		return 0
	} elseif {[llength [array names io_types]] == 1} {
		return 0
	} elseif {[llength [array names io_types]] == 2} {
		return 1
	} else {
		post_message -type error "Internal Error: Found IO types [array names io_types]"
		qexit -error
	}

}

proc RLDRAMII_p0_verify_flexible_timing_assumptions { inst pins_array_name mem_if_memtype } {
	return 1
}

proc RLDRAMII_p0_verify_high_performance_timing_assumptions { inst pins_array_name mem_if_memtype } {
	upvar $pins_array_name pins

	set num_errors 0
	load_package verify_ddr
	set ck_ckn_pairs [list]
	set failed_assumptions [list]
	if {[llength $pins(ck_pins)] > 0 && [llength $pins(ck_pins)] == [llength $pins(ckn_pins)]} {
		for {set ck_index 0} {$ck_index != [llength $pins(ck_pins)]} {incr ck_index} {
			lappend ck_ckn_pairs [list [lindex $pins(ck_pins) $ck_index] [lindex $pins(ckn_pins) $ck_index]]
		}
	} else {
		incr num_errors
		lappend failed_assumptions "Error: Could not locate same number of CK pins as CK# pins"
	}

	set read_pins_list [list]
	set write_pins_list [list]
	set read_clock_pairs [list]
	set write_clock_pairs [list]
	foreach { dqs } $pins(qk_pins) { dqsn } $pins(qkn_pins) { dq_list } $pins(q_groups) {
		lappend read_pins_list [list $dqs $dq_list]
		lappend read_clock_pairs [list $dqs $dqsn]
	}

	foreach { k } $pins(dk_pins) { kn } $pins(dkn_pins) { dm_list } $pins(dm_pins) { d_list } $pins(d_groups) {
		lappend write_pins_list [list $k [concat $d_list $dm_list]]
		lappend write_clock_pairs [list $k $kn]
	}

	set all_write_dqs_list $pins(dk_pins)
	set all_d_list $pins(all_dq_pins)
	if {[llength $pins(q_groups)] == 0} {
		incr num_errors
		lappend failed_assumptions "Error: Could not locate DQS pins"
	}

	if {$num_errors == 0} {
		set msg_list [list]
		set dll_name [RLDRAMII_p0_traverse_to_dll $dqs msg_list]
		set clk_to_write_d [RLDRAMII_p0_traverse_to_ddio_out_pll_clock [lindex $all_d_list 0] msg_list]
		set clk_to_write_clock [RLDRAMII_p0_traverse_to_ddio_out_pll_clock [lindex $all_write_dqs_list 0] msg_list]
		set clk_to_ck_ckn [RLDRAMII_p0_traverse_to_ddio_out_pll_clock [lindex $pins(ck_pins) 0] msg_list]
		foreach msg $msg_list {
			set verify_assumptions_exception 1
			incr num_errors
			lappend failed_assumptions $msg
		}
		if {$num_errors == 0} {
			set verify_assumptions_exception 0
			set verify_assumptions_result {0}
			set verify_assumptions_exception [catch {verify_assumptions -uniphy -memory_type $mem_if_memtype \
				-read_pins_list $read_pins_list -write_pins_list $write_pins_list -ck_ckn_pairs $ck_ckn_pairs \
				-clk_to_write_d $clk_to_write_d -clk_to_write_clock $clk_to_write_clock -clk_to_ck_ckn $clk_to_ck_ckn \
				-dll $dll_name -read_clock_pairs $read_clock_pairs -write_clock_pairs $write_clock_pairs} verify_assumptions_result]
			if {$verify_assumptions_exception == 0} {
				incr num_errors [lindex $verify_assumptions_result 0]
				set failed_assumptions [concat $failed_assumptions [lrange $verify_assumptions_result 1 end]]
			}
		}
		if {$verify_assumptions_exception != 0} {
			lappend failed_assumptions "Error: MACRO timing assumptions could not be verified"
			incr num_errors
		}
	}

	if {$num_errors != 0} {
		for {set i 0} {$i != [llength $failed_assumptions]} {incr i} {
			set raw_msg [lindex $failed_assumptions $i]
			if {[regexp {^\W*(Info|Extra Info|Warning|Critical Warning|Error): (.*)$} $raw_msg -- msg_type msg]} {
				regsub " " $msg_type _ msg_type
				if {$msg_type == "Error"} {
					set msg_type "critical_warning"
				}
				post_message -type $msg_type $msg
			} else {
				post_message -type info $raw_msg
			}
		}
		post_message -type critical_warning "Read Capture and Write timing analyses may not be valid due to violated timing model assumptions"
	}

	return [expr $num_errors == 0]
}

# Return a tuple of setup,hold time for read capture
proc RLDRAMII_p0_get_tsw { mem_if_memtype dqs_list period} {
	global TimeQuestInfo
	set interface_type [RLDRAMII_p0_get_io_interface_type $dqs_list]
	set io_std [RLDRAMII_p0_get_io_standard [lindex $dqs_list 0]]
	if {$interface_type != "" && $interface_type != "UNKNOWN" && $io_std != "" && $io_std != "UNKNOWN"} {
		package require ::quartus::ddr_timing_model
		set family $TimeQuestInfo(family)
		if {[catch {get_io_standard_node_delay -dst TSU -io_standard $io_std -parameters [list IO $interface_type]} tsw_setup] != 0 \
			|| $tsw_setup == "" || $tsw_setup == 0 \
			|| [catch {get_io_standard_node_delay -dst TH -io_standard $io_std -parameters [list IO $interface_type]} tsw_hold] != 0 \
			|| $tsw_hold == "" || $tsw_hold == 0 } {
			error "Missing $family timing model for tSW of $io_std $interface_type"
		} else {
			# Derate tSW for DDR2 on VPAD in CIII Q240 parts
			# The tSW for HPADs and for other interface types on C8 devices
			# have a large guardband, so derating for them is not required
			if {[get_part_info -package -pin_count $TimeQuestInfo(part)] == "PQFP 240"} {
				if {[catch {get_io_standard_node_delay -dst TSU -io_standard $io_std \
					-parameters [list IO $interface_type Q240_DERATING]} tsw_setup_derating] != 0 \
					|| $tsw_setup_derating == 0 \
					|| [catch {get_io_standard_node_delay -dst TH -io_standard $io_std \
					-parameters [list IO $interface_type Q240_DERATING]} tsw_hold_derating] != 0 || $tsw_hold_derating == 0} {
					set f "$io_std/$interface_type/$family"
					switch -glob $f {
						"SSTL_18*/VPAD/Cyclone III" {
							set tsw_setup_derating 50
							set tsw_hold_derating 135
						}
						default {
							set tsw_setup_derating 0
							set tsw_hold_derating 0
						}
					}
				}
				incr tsw_setup $tsw_setup_derating
				incr tsw_hold $tsw_hold_derating
			}
			return [list $tsw_setup $tsw_hold]
		}
	}
}

proc RLDRAMII_p0_get_tccs { mem_if_memtype dqs_list period } {
	global TimeQuestInfo
	set interface_type [RLDRAMII_p0_get_io_interface_type $dqs_list]
	if {$interface_type == "HYBRID"} {
		set interface_type "HPAD"
	}
	set io_std [RLDRAMII_p0_get_io_standard [lindex $dqs_list 0]]
	set result [list 0 0]
	if {$interface_type != "" && $interface_type != "UNKNOWN" && $io_std != "" && $io_std != "UNKNOWN"} {
		package require ::quartus::ddr_timing_model
		if {[catch {get_io_standard_node_delay -dst TCCS_LEAD -io_standard $io_std -parameters [list IO $interface_type]} tccs_lead] != 0 \
			|| $tccs_lead == "" || $tccs_lead == 0 \
			|| [catch {get_io_standard_node_delay -dst TCCS_LAG -io_standard $io_std -parameters [list IO $interface_type]} tccs_lag] != 0 \
			|| $tccs_lag == "" || $tccs_lag == 0 } {
			set family $TimeQuestInfo(family)
			error "Missing $family timing model for tCCS of $io_std $interface_type"
		} else {
			return [list $tccs_lead $tccs_lag]
		}
	}
}

# ----------------------------------------------------------------
#
proc RLDRAMII_p0_get_fitter_report_pin_info_from_report {target_pin info_type pin_report_id} {
#
# Description: Gets the report field for the given pin in the given report
#
# ----------------------------------------------------------------
	set pin_name_column [RLDRAMII_p0_get_report_column $pin_report_id "Name"]
	set info_column [RLDRAMII_p0_get_report_column $pin_report_id $info_type]
	set result ""

	if {$pin_name_column == 0 && 0} {
		set row_index [get_report_panel_row_index -id $pin_report_id $target_pin]
		if {$row_index != -1} {
			set row [get_report_panel_row -id $pin_report_id -row $row_index]
			set result [lindex $row $info_column]
		}
	} else {
		set report_rows [get_number_of_rows -id $pin_report_id]
		for {set row_index 1} {$row_index < $report_rows && $result == ""} {incr row_index} {
			set row [get_report_panel_row -id $pin_report_id -row $row_index]
			set pin [lindex $row $pin_name_column]
			if {$pin == $target_pin} {
				set result [lindex $row $info_column]
			}
		}
	}
	return $result
}

# ----------------------------------------------------------------
#
proc RLDRAMII_p0_get_fitter_report_pin_info {target_pin info_type preferred_report_id {found_report_id_name ""}} {
#
# Description: Gets the report field for the given pin by searching through the
#              input, output and bidir pin reports
#
# ----------------------------------------------------------------
	if {$found_report_id_name != ""} {
		upvar 1 $found_report_id_name found_report_id
	}
	set found_report_id -1
	set result ""
	if {$preferred_report_id == -1} {
		set pin_report_list [list "Fitter||Resource Section||Bidir Pins" "Fitter||Resource Section||Input Pins" "Fitter||Resource Section||Output Pins"]
		for {set pin_report_index 0} {$pin_report_index != [llength $pin_report_list] && $result == ""} {incr pin_report_index} {
			set pin_report_id [get_report_panel_id [lindex $pin_report_list $pin_report_index]]
			if {$pin_report_id != -1} {
				set result [RLDRAMII_p0_get_fitter_report_pin_info_from_report $target_pin $info_type $pin_report_id]
				if {$result != ""} {
					set found_report_id $pin_report_id
				}
			} else {
				post_message -type error "RLDRAMII_p0_pin_map.tcl: Failed to find fitter report. If report timing is run after an ECO, the user must set_global_assignment -name ECO_REGENERATE_REPORT ON in RLDRAMII_p0.qsf and in RLDRAMII_p0_pin_assignment.tcl files and rerun ECO and STA"
			}
		}
	} else {
		set result [RLDRAMII_p0_get_fitter_report_pin_info_from_report $target_pin $info_type $preferred_report_id]
		if {$result != ""} {
			set found_report_id $preferred_report_id
		}
	}
	return $result
}
# ----------------------------------------------------------------
#
proc RLDRAMII_p0_get_fitter_report_pin_io_type_info {target_pin} {
#
# Description: Gets the type of IO, either column or row for
# a given pin. If none found then "" is returned.
#
# ----------------------------------------------------------------
	set result ""
	set pin_report_id [get_report_panel_id "Fitter||Resource Section||All Package Pins"]
	if {$pin_report_id != -1} {
		set pin_name_column [RLDRAMII_p0_get_report_column $pin_report_id "Pin Name/Usage"]
		set info_column [RLDRAMII_p0_get_report_column $pin_report_id "I/O Type"]
		if {$pin_name_column == 0 && 0} {
			set row_index [get_report_panel_row_index -id $pin_report_id $target_pin]
			if {$row_index != -1} {
				set row [get_report_panel_row -id $pin_report_id -row $row_index]
				set result [lindex $row $info_column]
			}
		} else {
			set report_rows [get_number_of_rows -id $pin_report_id]
			for {set row_index 1} {$row_index < $report_rows && $result == ""} {incr row_index} {
				set row [get_report_panel_row -id $pin_report_id -row $row_index]
				set pin [lindex $row $pin_name_column]
				if {$pin == $target_pin} {
					set result [lindex $row $info_column]
				}
			}
		}
	} else {
		set pin_report_id [get_report_panel_id "Fitter||Resource Section||DQS Summary"]
		if {$pin_report_id != -1} {
		
			set report_rows [get_number_of_rows -id $pin_report_id]
			set pin_name_column [RLDRAMII_p0_get_report_column $pin_report_id "Name"]
			set info_column [RLDRAMII_p0_get_report_column $pin_report_id "I/O Edge"]
			
			for {set row_index 1} {$row_index < $report_rows && $result == ""} {incr row_index} {
				set row [get_report_panel_row -id $pin_report_id -row $row_index]
				set pin [lindex $row $pin_name_column]
				regsub -all {[ \r\t\n]+} $pin "" pin_no_whitespace
				if {$pin_no_whitespace == $target_pin} {
					set result [lindex $row $info_column]
				}
			}
			
			if {($result == "Bottom") || ($result == "Top")} {
				set result "Column I/O"
			} elseif {($result == "Left") || ($result == "Right")} {
				set result "Row I/O"
			}
		}
	}

	return $result
}
# ----------------------------------------------------------------
#
proc RLDRAMII_p0_get_io_interface_type {pin_list} {
#
# Description: Gets the type of pin that the given pins are placed on
#              either (HPAD, VPAD, HYBRID, "", or UNKNOWN).
#              "" is returned if pin_list is empty
#              UNKNOWN is returned if an error was encountered
#              This function assumes the fitter has already completed and the
#              compiler report has been loaded.
#
# ----------------------------------------------------------------
	set preferred_report_id -1
	set interface_type ""
	foreach target_pin $pin_list {
		set io_bank [RLDRAMII_p0_get_fitter_report_pin_info $target_pin "I/O Bank" $preferred_report_id preferred_report_id]
		if {[regexp -- {^([0-9]+)[A-Z]*} $io_bank -> io_bank_number]} {
			if {$io_bank_number == 1 || $io_bank_number == 2 || $io_bank_number == 5 || $io_bank_number == 6} {
				# Row I/O
				if {$interface_type == ""} {
					set interface_type "HPAD"
				} elseif {$interface_type == "VIO"} {
					set interface_type "HYBRID"
				}
			} elseif {$io_bank_number == 3 || $io_bank_number == 4 || $io_bank_number == 7 || $io_bank_number == 8} {
				if {$interface_type == ""} {
					set interface_type "VPAD"
				} elseif {$interface_type == "HIO"} {
					set interface_type "HYBRID"
				}
			} else {
				post_message -type critical_warning "Unknown I/O bank $io_bank for pin $target_pin"
				# Assume worst case performance (mixed HIO/VIO interface)
				set interface_type "HYBRID"
			}
		}
	}
	return $interface_type
}


# ----------------------------------------------------------------
#
proc RLDRAMII_p0_get_report_column { report_id str} {
#
# Description: Gets the report column index with the given header string
#
# ----------------------------------------------------------------
	set target_col [get_report_panel_column_index -id $report_id $str]
	if {$target_col == -1} {
		error "Cannot find $str column"
	}
	return $target_col
}

proc RLDRAMII_p0_traverse_to_dll_id {dqs_pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set dqs_pin_id [get_atom_node_by_name -name $dqs_pin]
	set dqs_to_dll_path [list {IO_PAD fanout PADOUT} {IO_IBUF fanout O} {DQS_DELAY_CHAIN fanin DELAYCTRLIN} {DLL end DELAYCTRLOUT}]
	set dll_id_list [RLDRAMII_p0_traverse_atom_path $dqs_pin_id -1 $dqs_to_dll_path]
	set dll_id -1
	if {[llength $dll_id_list] == 1} {
		set dll_atom_oterm_pair [lindex $dll_id_list 0]
		set dll_id [lindex $dll_atom_oterm_pair 0]
	} elseif {[llength $dll_id_list] > 1} {
		lappend msg_list "Error: Found more than 1 DLL"
	} else {
		lappend msg_list "Error: DLL not found"
	}
	return $dll_id
}

proc RLDRAMII_p0_traverse_to_dqs_delaychain_id {dqs_pin msg_list_name} {
	upvar 1 $msg_list_name msg_list
	set dqs_pin_id [get_atom_node_by_name -name $dqs_pin]
	set dqs_to_delaychain_path [list {IO_PAD fanout PADOUT} {IO_IBUF fanout O} {DQS_DELAY_CHAIN atom}]
	set delaychain_id_list [RLDRAMII_p0_traverse_atom_path $dqs_pin_id -1 $dqs_to_delaychain_path]
	set delaychain_id -1
	if {[llength $delaychain_id_list] == 1} {
		set delaychain_atom_oterm_pair [lindex $delaychain_id_list 0]
		set delaychain_id [lindex $delaychain_atom_oterm_pair 0]
	} elseif {[llength $delaychain_id_list] > 1} {
		lappend msg_list "Error: Found more than 1 DQS delaychain"
	} else {
		lappend msg_list "Error: DQS delaychain not found"
	}
	return $delaychain_id
}

proc RLDRAMII_p0_get_dqs_phase { dqs_pins } {
	set dqs_phase -100
	set dqs0 [lindex $dqs_pins 0]
	if {$dqs0 != ""} {
		set dqs_delay_chain_id [RLDRAMII_p0_traverse_to_dqs_delaychain_id $dqs0 msg_list]
		if {$dqs_delay_chain_id != -1} {
			set dqs_phase [get_atom_node_info -key INT_DQS_PHASE_SHIFT -node $dqs_delay_chain_id]
		}
	}

	set dqs_phase [expr {$dqs_phase / 100}]

	if {$dqs_phase < 0} {
		set dqs_phase 90
		post_message -type critical_warning "Unable to determine DQS delay chain phase shift.  Assuming default setting of $dqs_phase"
	}

	return $dqs_phase
}

proc RLDRAMII_p0_get_dqs_period { dqs_pins } {
	set dqs_period -100
	set dqs0 [lindex $dqs_pins 0]
	if {$dqs0 != ""} {
		set dll_id [RLDRAMII_p0_traverse_to_dll_id $dqs0 msg_list]
		if {$dll_id != -1} {
			set dqs_period_str [get_atom_node_info -key TIME_INPUT_FREQUENCY -node $dll_id]
			if {[regexp {(.*) ps} $dqs_period_str matched dqs_period_ps] == 1} {
				set dqs_period [expr $dqs_period_ps/1000.0]
			} elseif {[regexp {(.*) ps} $dqs_period_str matched dqs_period_ns] == 1} {
				set dqs_period $dqs_period_ns
			}
			
		}
	}

	if {$dqs_period < 0} {
		set dqs_period 0
		post_message -type critical_warning "Unable to determine DQS delay chain period.  Assuming default setting of $dqs_period"
	}

	return $dqs_period
}

proc RLDRAMII_p0_get_operating_conditions_number {} {
	set cur_operating_condition [get_operating_conditions]
	set counter 0
	foreach_in_collection op [get_available_operating_conditions] {
		if {[string compare $cur_operating_condition $op] == 0} {
			return $counter
		}
		incr counter
	}
	return $counter
}

proc RLDRAMII_p0_find_oct_blocks { instname } {
	set blocks [ list ]
	set sd2a_0_atom ""
	set sd1a_0_atom ""
	set match_data_out ${instname}|p0|umemphy|uio_pads|dq_ddio[0].ubidir_dq_dqs|altdq_dqs2_inst|pad_gen[0].data_out
	load_package atoms
	read_atom_netlist
	set_project_mode -always_show_entity_name off
	set dataout_atoms [get_atom_nodes -matching [escape_brackets $match_data_out] ]
	if { [get_collection_size $dataout_atoms] == 1 } {
		foreach_in_collection dataout_atom $dataout_atoms { 
			set dataout_atom_name [get_atom_node_info -key name -node $dataout_atom] 
			set iterms [get_atom_iports -node $dataout_atom]
			foreach iterm $iterms { 
				set fanin	[get_atom_port_info -node $dataout_atom -type iport -port_id $iterm -key fanin]
				if { [llength $fanin] > 0 } {
					set sd2a_0_atom [lindex $fanin 0]
					set sd2a_0_atom_name [get_atom_node_info -key name -node $sd2a_0_atom]
					if { [regexp "oct0|sd2a_0" $sd2a_0_atom_name] } {
						break
					}
				}
			}
		}	
		
		set sda_2_0_iterms [get_atom_iports -node $sd2a_0_atom]
		foreach sda_2_0_iterm $sda_2_0_iterms {
			set fanin	[get_atom_port_info -node $sd2a_0_atom -type iport -port_id $sda_2_0_iterm -key fanin]
			if { [llength $fanin] > 0 } {
				set sd1a_0_atom [lindex $fanin 0]
				set sd1a_0_atom_name [get_atom_node_info -key name -node $sd1a_0_atom]
				if { [regexp "oct0|sd1a_0" $sd1a_0_atom_name] } {
					set_project_mode -always_show_entity_name on
					set sd1a_0_atom_proper_name [get_atom_node_info -key name -node $sd1a_0_atom]
					lappend blocks $sd1a_0_atom_proper_name
					break
				}
			}
		}
	} else {
		if { [get_collection_size $dataout_atoms] == 0 } {
			post_message -type warning " Correct OCT Block cannot be find as no dataout atom found for the $instname instance ";
		}
		if { [get_collection_size $dataout_atoms] > 1 } {
			post_message -type warning " Correct OCT Block cannot be find as multiple dataout atoms found for the $instname instance ";
		}
	}
	
	set_project_mode -always_show_entity_name qsf

	if { [llength $blocks] == 0 } {
		post_message -type info " Cannot make OCT assignments since the correct OCT block was not found. Please identify the OCT block and manually update the QSF file as OCT assignments may be needed for qk and qkn pins. ";
	}

	return $blocks
}

proc RLDRAMII_p0_get_ddr_pins { instname allpins } {
	# We need to make a local copy of the allpins associative array
	upvar allpins pins

	global ::GLOBAL_RLDRAMII_p0_dq_group_size
	global ::GLOBAL_RLDRAMII_p0_d_group_size
	global ::GLOBAL_RLDRAMII_p0_number_of_d_groups
	global ::GLOBAL_RLDRAMII_p0_number_of_q_groups

	set synthesis_flow 0
	set sta_flow 0
	if { $::TimeQuestInfo(nameofexecutable) == "quartus_map" } {
		set synthesis_flow 1
	} elseif { $::TimeQuestInfo(nameofexecutable) == "quartus_sta" } {
		set sta_flow 1
	}

	set qk_pins [ list ]
	set qkn_pins [ list ]
	set q_groups [ list ]
	set dqs_in_clocks [ list ]
	for { set i 0 } { $i < $::GLOBAL_RLDRAMII_p0_number_of_q_groups } { incr i } {
		
		set qk_string ${instname}|p0|umemphy|uio_pads|dq_ddio[$i].ubidir_dq_dqs|altdq_dqs2_inst|strobe_in|i
		set qk_local_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanins $qk_string ] ]
		
		load_package ddr_timing_model

		if { ![timing_netlist_exist] } {
			create_timing_netlist -post_map
		}

		if { [llength $qk_local_pins] != 1} {
			post_sdc_message critical_warning "Could not find QK pin number $i"
		} else {
			lappend qk_pins [ lindex $qk_local_pins 0 ]

			set dqs_in_clock(dqs_pin) [ lindex $qk_local_pins 0 ]
			set dqs_in_clock(div_name) "${instname}|div_clock_$i"
			set dqs_in_clock(div_pin) "${instname}|p0|umemphy|uread_datapath|read_capture_clk_div2[$i]"
			lappend dqs_in_clocks [ array get dqs_in_clock ]

			if { ! $synthesis_flow } {

				set qkn_local_pins [get_complementary_input -input [lindex $qk_local_pins 0] ]

				if { [get_collection_size [get_ports $qkn_local_pins]] == 0 } {
					post_sdc_message critical_warning "Could not find QK# pin $qkn_local_pins"
				}  else {
					lappend qkn_pins [ lindex $qkn_local_pins 0 ]
				}
			}
		}


		set q_group [ list ]
		for { set j 0 } { $j < $::GLOBAL_RLDRAMII_p0_dq_group_size } { incr j } {
			set q_string ${instname}|p0|umemphy|uio_pads|dq_ddio[$i].ubidir_dq_dqs|altdq_dqs2_inst|pad_gen[$j].data_in|i
			set tmp_q_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanins $q_string ] ]

			lappend q_group $tmp_q_pins
		}

		if { [llength $q_group] != $::GLOBAL_RLDRAMII_p0_dq_group_size} {
			post_sdc_message critical_warning "Could not find correct number of Q pins for CQ pin $i. \
				Found [llength $q_pins] pins. Expecting ${::GLOBAL_RLDRAMII_p0_dq_group_size}."
		}

		lappend q_groups [ join $q_group ]
	}

	set pins(qk_pins) $qk_pins
	set pins(qkn_pins) $qkn_pins
	set pins(q_groups) $q_groups
	set pins(all_dq_pins) [ join [ join $q_groups ] ]
	set pins(dqs_in_clocks) $dqs_in_clocks

	set dk_pins [ list ]
	set dkn_pins [ list ]
	set d_groups [ list ]
	
	if {$::GLOBAL_RLDRAMII_p0_number_of_q_groups == $::GLOBAL_RLDRAMII_p0_number_of_d_groups} {
		set first_dq_ddio_with_dk 0
		set number_of_dq_ddio_per_dk 1
		set number_of_d_pins_per_dq_ddio $::GLOBAL_RLDRAMII_p0_d_group_size
	} else {
		set first_dq_ddio_with_dk 1
		set number_of_dq_ddio_per_dk 2
		set number_of_d_pins_per_dq_ddio [ expr $::GLOBAL_RLDRAMII_p0_d_group_size / 2 ]
	}
	
	for { set i 0 } { $i < $::GLOBAL_RLDRAMII_p0_number_of_d_groups } { incr i } {
		set dq_ddio_index [ expr $first_dq_ddio_with_dk + $i * $number_of_dq_ddio_per_dk ]
		set dk_string ${instname}|p0|umemphy|uio_pads|dq_ddio[$dq_ddio_index].ubidir_dq_dqs|altdq_dqs2_inst|obuf_os_0|o
		set dkn_string ${instname}|p0|umemphy|uio_pads|dq_ddio[$dq_ddio_index].ubidir_dq_dqs|altdq_dqs2_inst|obuf_os_bar_0|o

		set dk_local_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanouts $dk_string ] ]
		set dkn_local_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanouts $dkn_string ] ]

		set d_group [ list ]
		for { set j 0 } { $j < $::GLOBAL_RLDRAMII_p0_d_group_size } { incr j } {
			set dq_ddio_index [ expr $i * $number_of_dq_ddio_per_dk + int($j / $number_of_d_pins_per_dq_ddio) ]
			set pad_index [ expr $j % $number_of_d_pins_per_dq_ddio ]
			set d_string ${instname}|p0|umemphy|uio_pads|dq_ddio[$dq_ddio_index].ubidir_dq_dqs|altdq_dqs2_inst|pad_gen[$pad_index].data_out|i

			set tmp_d_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanouts $d_string ] ]
			lappend d_group $tmp_d_pins
		}

		if { [llength $dk_local_pins] != 1} { post_sdc_message critical_warning "Could not find K pin number $i" }
		if { [llength $dkn_local_pins] != 1} { post_sdc_message critical_warning "Could not find Kn pin number $i" }
		if { [llength $d_group] != $::GLOBAL_RLDRAMII_p0_d_group_size} { post_sdc_message critical_warning "Could not find correct number of D pins for K pin $i.
			Found [llength $d_p] pins. Expecting ${::GLOBAL_RLDRAMII_p0_d_group_size}." }
			
		lappend dk_pins [ join $dk_local_pins ]
		lappend dkn_pins [ join $dkn_local_pins ]
		lappend d_groups [ join $d_group ]
	}


	set pins(dk_pins) $dk_pins
	set pins(dkn_pins) $dkn_pins
	set pins(d_groups) $d_groups

	if {$::GLOBAL_RLDRAMII_p0_number_of_q_groups == $::GLOBAL_RLDRAMII_p0_number_of_dm_pins} {
		set first_dq_ddio_with_dm 0
		set number_of_dq_ddio_per_dm 1
	} else {
		set first_dq_ddio_with_dm 1
		set number_of_dq_ddio_per_dm 2
	}
	
	set dm_pins [ list ]
	for { set i 0 } { $i < $::GLOBAL_RLDRAMII_p0_number_of_dm_pins } { incr i } {
		set dq_ddio_index [expr $first_dq_ddio_with_dm + $i * $number_of_dq_ddio_per_dm]
		set dm_string ${instname}|p0|umemphy|uio_pads|dq_ddio[$dq_ddio_index].ubidir_dq_dqs|altdq_dqs2_inst|extra_output_pad_gen[0].obuf_1|o

		set dm_local_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanouts $dm_string ] ]
		if { [llength $dm_local_pins] != 1} { post_sdc_message critical_warning "Could not find DM pin number $i" }
		lappend dm_pins [ join $dm_local_pins ]
	}

	set pins(dm_pins) $dm_pins

	set pins(all_dq_dm_pins) [ concat $pins(all_dq_pins) $pins(dm_pins) ]

	# Other Outputs

	set pins(ck_pins) [ list ]
	set pins(ckn_pins) [ list ]
	set pins(add_pins) [ list ]
	set pins(ba_pins) [ list ]
	set pins(cmd_pins) [ list ]
	set pins(reserved_pins) [ list ]

	set patterns [ list ]

	set addr_cmd_postfix "auto_generated|ddio_outa[*]|dataout"
	lappend patterns ck_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|uclk_generator|obufa_0|o
	lappend patterns ckn_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|uclk_generator|obuf_ba_0|o
	lappend patterns add_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|uaddress_pad|${addr_cmd_postfix}
	lappend patterns ba_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|ubank_pad|${addr_cmd_postfix}
	lappend patterns cmd_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|ucs_n_pad|${addr_cmd_postfix}
	lappend patterns cmd_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|uwe_n_pad|${addr_cmd_postfix}
	lappend patterns cmd_pins ${instname}|p0|umemphy|uio_pads|uaddr_cmd_pads|uref_n_pad|${addr_cmd_postfix}


	foreach {pin_type pattern} $patterns {
		set local_pins [ RLDRAMII_p0_get_names_in_collection [ get_fanouts $pattern ] ]
		if {[llength $local_pins] == 0} {
			post_message -type critical_warning "Could not find pin of type $pin_type from pattern $pattern"
		} else {
			foreach pin [lsort -unique $local_pins] {
				lappend pins($pin_type) $pin
			}
		}
	}
	

	set pins(ac_pins) [ concat $pins(add_pins) $pins(ba_pins) $pins(cmd_pins) ]
	set pins(afi_ck_pins) ${instname}|s0|*sequencer_rw_mgr_inst|rw_mgr_inst|rw_mgr_core_inst|afi_rdata_valid_r
	set pins(afi_phy_ck_pins) ${instname}|p0|umemphy|uio_pads|dq_ddio[0].ubidir_dq_dqs|altdq_dqs2_inst|output_path_gen[0].hr_to_fr_lo~DFFLO
	set prefix [string map "| |*:" $instname]
	set pins(avl_ck_pins) *:${prefix}|*:s0|*:sequencer_rw_mgr_inst|*:rw_mgr_inst|cmd_done_avl
	set pins(config_ck_pins) ${instname}|s0|sequencer_scc_mgr_inst|scc_upd[0]

	#############
	# PLL STUFF #
	#############

	set pll_ac_clock "_UNDEFINED_PIN_"
	set pll_ck_clock "_UNDEFINED_PIN_"
	set pll_afi_clock "_UNDEFINED_PIN_"
	set pll_afi_phy_clock "_UNDEFINED_PIN_"
	set pll_dk_clock "_UNDEFINED_PIN_"
	set pll_ref_clock "_UNDEFINED_PIN_"
	set pll_ref_clock_input_buffer "_UNDEFINED_PIN_"
	set ckdk_common_clkbuf "_UNDEFINED_PIN_"	
	set pll_avl_clock "_UNDEFINED_PIN_"
	set pll_config_clock "_UNDEFINED_PIN_"
	set msg_list [ list ]

	# CLOCK OUTPUT PLL
	set pll_ck_clock_id [RLDRAMII_p0_get_output_clock_id $pins(ck_pins) "CK Output" msg_list]
	if {$pll_ck_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0.sdc: Failed to find PLL clock for pins [join $pins(ck_pins)]"
	} else {
		set pll_ck_clock [RLDRAMII_p0_get_pll_clock_name $pll_ck_clock_id]
	}
	set pins(pll_ck_clock) $pll_ck_clock
	
	set ckdk_common_clkbuf_id [RLDRAMII_p0_get_output_clock_clkbuf_id [concat $pins(ck_pins) $pins(dk_pins)] "CK/DK Output" msg_list]
	if {$ckdk_common_clkbuf_id != -1} {
		set ckdk_common_clkbuf [get_node_info -name $ckdk_common_clkbuf_id]	
	}
	set pins(ckdk_common_clkbuf) $ckdk_common_clkbuf	

	# AFI CLOCK PLL
	set pll_afi_clock_id [RLDRAMII_p0_get_output_clock_id $pins(afi_ck_pins) "AFI CK" msg_list]
	if {$pll_afi_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0_pin_map.tcl: Failed to find PLL clock for pins [join $pins(afi_ck_pins)]"
	} else {
		set pll_afi_clock [RLDRAMII_p0_get_pll_clock_name $pll_afi_clock_id]
	}
	set pins(pll_afi_clock) $pll_afi_clock

	# AFI PHY CLOCK PLL
	set pll_afi_phy_clock_id [RLDRAMII_p0_get_output_clock_id $pins(afi_phy_ck_pins) "AFI CK" msg_list]
	if {$pll_afi_phy_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0_pin_map.tcl: Failed to find PLL clock for pins [join $pins(afi_phy_ck_pins)]"
	} else {
		set pll_afi_phy_clock [RLDRAMII_p0_get_pll_clock_name $pll_afi_phy_clock_id]
	}
	set pins(pll_afi_phy_clock) $pll_afi_phy_clock

	# DK PLL
	set pll_dk_clock_id [RLDRAMII_p0_get_output_clock_id [join [join $pins(d_groups)]] "DK Output" msg_list 20]
	if {$pll_dk_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0_pin_map.tcl: Failed to find PLL clock for pins [join [join $pins(d_groups)]]"
	} else {
		set pll_dk_clock [RLDRAMII_p0_get_pll_clock_name $pll_dk_clock_id]
	}
	set pins(pll_dk_clock) $pll_dk_clock

	# AC PLL
	set pll_ac_clock_id [RLDRAMII_p0_get_output_clock_id $pins(add_pins) "Address/Command Output" msg_list]
	if {$pll_ac_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0_pin_map.tcl: Failed to find PLL clock for pins [join $pins(add_pins)]"
	} else {
		set pll_ac_clock [RLDRAMII_p0_get_pll_clock_name $pll_ac_clock_id]
	}
	set pins(pll_ac_clock) $pll_ac_clock


	set pll_ref_clock_id [RLDRAMII_p0_get_input_clk_id $pll_ck_clock_id]
	if {$pll_ref_clock_id == -1} {
		post_message -type error "RLDRAMII_p0_pin_map.tcl: Failed to find PLL reference clock"
	} else {
		set pll_ref_clock [get_node_info -name $pll_ref_clock_id]
	}
	set pins(pll_ref_clock) $pll_ref_clock
	
	if {$synthesis_flow == 0} {
		if {$pll_ref_clock_id != -1} {
			set pll_ref_clock_id_fanout_edges [get_node_info -fanout_edges $pll_ref_clock_id]
			if {[llength $pll_ref_clock_id_fanout_edges] > 0} {
				for {set i 0} {$i < 1} {incr i} {
					set pll_ref_clock_input_buffer [get_node_info -name [get_edge_info -dst [get_node_info -fanout_edges [get_edge_info -dst [lindex $pll_ref_clock_id_fanout_edges $i]]]]]
				}
			} 
		}
	}
	set pins(pll_ref_clock_input_buffer) $pll_ref_clock_input_buffer		
	

	set pll_avl_clock_id [RLDRAMII_p0_get_output_clock_id $pins(avl_ck_pins) "Avalon Bus CK" msg_list]
	if {$pll_avl_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0_pin_map.tcl: Failed to find PLL clock for pins [join $pins(avl_ck_pins)]"
	} else {
		set pll_avl_clock [RLDRAMII_p0_get_pll_clock_name $pll_avl_clock_id]
	}
	set pins(pll_avl_clock) $pll_avl_clock

	set pll_config_clock_id [RLDRAMII_p0_get_output_clock_id $pins(config_ck_pins) "Config CK" msg_list]
	if {$pll_config_clock_id == -1} {
		foreach {msg_type msg} $msg_list {
			post_message -type $msg_type "RLDRAMII_p0_pin_map.tcl: $msg"
		}
		post_message -type critical_warning "RLDRAMII_p0_pin_map.tcl: Failed to find PLL clock for pins [join $pins(config_ck_pins)]"
	} else {
		set pll_config_clock [RLDRAMII_p0_get_pll_clock_name $pll_config_clock_id]
	}
	set pins(pll_config_clock) $pll_config_clock


	set entity_names_on [ RLDRAMII_p0_are_entity_names_on ]

	# Instance name prefix
	
	set prefix [ string map "| |*:" $instname ]
	set prefix "*:$prefix"

	#####################
	# READ CAPTURE DDIO #
	#####################
	set read_capture_ddio_prefix [expr { $entity_names_on ? \
		"$prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio\[*\].ubidir_dq_dqs|*:altdq_dqs2_inst|" : \
		"$instname|p0|umemphy|uio_pads|dq_ddio\[*\].ubidir_dq_dqs|altdq_dqs2_inst|" }]

	set read_capture_ddio [list "${read_capture_ddio_prefix}input_path_gen\[*\].capture_reg~DFFLO" \
	                            "${read_capture_ddio_prefix}input_path_gen\[*\].aligned_input\[*\]"]
	set pins(read_capture_ddio) $read_capture_ddio

	###################
	# RESET REGISTERS #
	###################

	# the output of this flop feeds the asynchronous clear pin of the reset registers and should be false pathed
    # since the deassertion of the reset is synchronous with the use of a reset pipeline
    # normal timing analysis will take care that
	#MarkW: does this work for both sequencers?
	set reset_reg ${prefix}|*:s0|*:sequencer_inst|seq_reset_mem_stable
	if { ! $entity_names_on } {
		set reset_reg ${instname}|s0|sequencer_inst|seq_reset_mem_stable
	}
	set pins(reset_reg) $reset_reg

    # first flop of a synchronzier
    # sequencer issues multiple resets during calibration, reset is synced over from AFI to read capture clock domain
	set sync_reg $prefix|*:p0|*:umemphy|*:uread_datapath|read_buffering[*].seq_read_fifo_reset_sync[*]
	if { ! $entity_names_on } {
		set sync_reg $instname|p0|umemphy|uread_datapath|read_buffering[*].seq_read_fifo_reset_sync[*]
	}
	set pins(sync_reg) $sync_reg


	###############################
	# DATA RESYNCHRONIZATION FIFO #
	###############################

	set fifo_wraddress_reg $prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio[*].ubidir_dq_dqs|*:altdq_dqs2_inst|input_path_gen[*].read_fifo~WRITE_ADDRESS_DFF
	if { ! $entity_names_on } {
		set fifo_wraddress_reg $instname|p0|umemphy|uio_pads|dq_ddio[*].ubidir_dq_dqs|altdq_dqs2_inst|input_path_gen[*].read_fifo~WRITE_ADDRESS_DFF
	}
	set pins(fifo_wraddress_reg) $fifo_wraddress_reg
	
	set fifo_rdaddress_reg $prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio[*].ubidir_dq_dqs|*:altdq_dqs2_inst|input_path_gen[*].read_fifo~READ_ADDRESS_DFF
	if { ! $entity_names_on } {
		set fifo_rdaddress_reg $instname|p0|umemphy|uio_pads|dq_ddio[*].ubidir_dq_dqs|altdq_dqs2_inst|input_path_gen[*].read_fifo~READ_ADDRESS_DFF
	}
	set pins(fifo_rdaddress_reg) $fifo_rdaddress_reg		

	set fifo_wrdata_reg $prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio[*].ubidir_dq_dqs|*:altdq_dqs2_inst|input_path_gen[*].read_fifo|*INPUT_DFF*
	if { ! $entity_names_on } {
		set fifo_wrdata_reg $instname|p0|umemphy|uio_pads|dq_ddio[*].ubidir_dq_dqs|altdq_dqs2_inst|input_path_gen[*].read_fifo|*INPUT_DFF*
	}
	set pins(fifo_wrdata_reg) $fifo_wrdata_reg

	set fifo_rddata_reg $prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio[*].ubidir_dq_dqs|*:altdq_dqs2_inst|input_path_gen[*].read_fifo|dout[*]
	if { ! $entity_names_on } {
		set fifo_rddata_reg $instname|p0|umemphy|uio_pads|dq_ddio[*].ubidir_dq_dqs|altdq_dqs2_inst|input_path_gen[*].read_fifo|dout[*]
	}
	set pins(fifo_rddata_reg) $fifo_rddata_reg

    ###############################
    # VALID PREDICTION FIFO       #
    ###############################

    set valid_fifo_wrdata_reg $prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio[*].ubidir_dq_dqs|*:altdq_dqs2_inst|vfifo~*QVLD_IN_DFF
    if { ! $entity_names_on } {
    	set valid_fifo_wrdata_reg $instname|p0|umemphy|uio_pads|dq_ddio[*].ubidir_dq_dqs|altdq_dqs2_inst|vfifo~*QVLD_IN_DFF
    }
    set pins(valid_fifo_wrdata_reg) $valid_fifo_wrdata_reg

    set valid_fifo_rddata_reg $prefix|*:p0|*:umemphy|*:uio_pads|*:dq_ddio[*].ubidir_dq_dqs|*:altdq_dqs2_inst|vfifo~*QVLD_OUT_DFF
    if { ! $entity_names_on } {
    	set valid_fifo_rddata_reg $instname|p0|umemphy|uio_pads|dq_ddio[*].ubidir_dq_dqs|altdq_dqs2_inst|vfifo~*QVLD_OUT_DFF
    }
    set pins(valid_fifo_rddata_reg) $valid_fifo_rddata_reg
}

proc RLDRAMII_p0_verify_pins { allpins } {
	set pins [ array get allpins ]
}

proc RLDRAMII_p0_initialize_ddr_db { ddr_db_par } {
	upvar $ddr_db_par local_ddr_db

	global ::GLOBAL_RLDRAMII_p0_corename

	post_sdc_message info "Initializing DDR database for CORE $::GLOBAL_RLDRAMII_p0_corename"
	set instance_list [RLDRAMII_p0_get_core_instance_list $::GLOBAL_RLDRAMII_p0_corename]
	# set local_ddr_db(instance_list) $instance_list

	foreach instname $instance_list {
		post_sdc_message info "Finding port-to-pin mapping for CORE: $::GLOBAL_RLDRAMII_p0_corename INSTANCE: $instname"

		RLDRAMII_p0_get_ddr_pins $instname allpins

		RLDRAMII_p0_verify_ddr_pins allpins

		set local_ddr_db($instname) [ array get allpins ]
	}
}

proc RLDRAMII_p0_verify_ddr_pins { pins_par } {
	upvar $pins_par pins

	# Verify Q groups
	set current_q_group_size -1
	foreach q_group $pins(q_groups) {
		set group_size [ llength $q_group ]
		if { $group_size == 0 } {
			post_message -type critical_warning "Q group of size 0"
		}
		if { $current_q_group_size == -1 } {
			set current_q_group_size $group_size
		} else {
			if { $current_q_group_size != $group_size } {
				post_message -type critical_warning "Inconsistent Q group size across groups"
			}
		}
	}

	# Verify DQ groups
	set current_d_group_size -1
	foreach d_group $pins(d_groups) {
		set group_size [ llength $d_group ]
		if { $group_size == 0 } {
			post_message -type critical_warning "D group of size 0"
		}
		if { $current_d_group_size == -1 } {
			set current_d_group_size $group_size
		} else {
			if { $current_d_group_size != $group_size } {
				post_message -type critical_warning "Inconsistent Q group size across groups"
			}
		}
	}

	set counted_dm_pins [ llength $pins(dm_pins) ]
	if { $::GLOBAL_RLDRAMII_p0_number_of_dm_pins != $counted_dm_pins } {
		post_message -type critical_warning "Unexpected number of detected DM pins: $counted_dm_pins"
		post_message -type critical_warning "   expected: $::GLOBAL_RLDRAMII_p0_number_of_dm_pins"
	}
	# Verify Address/Command/BA pins
	if { [ llength $pins(add_pins) ] == 0 } {
		post_message -type critical_warning "Address pins of size 0"
	}
	if { [ llength $pins(cmd_pins) ] == 0 } {
		post_message -type critical_warning "Command pins of size 0"
	}
	if { [ llength $pins(ba_pins) ] == 0 } {
		post_message -type critical_warning "BA pins of size 0"
	}
}

proc RLDRAMII_p0_get_all_instances_div_names { ddr_db_par } {
	upvar $ddr_db_par local_ddr_db

	set div_names [ list ]
	set instnames [ array names local_ddr_db ]
	foreach instance $instnames {
		array set pins $local_ddr_db($instance)

		foreach { dqs_in_clock_struct } $pins(dqs_in_clocks) {
			array set dqs_in_clock $dqs_in_clock_struct
			lappend div_names $dqs_in_clock(div_name)
		}
	}

	return $div_names
}

proc RLDRAMII_p0_get_all_instances_dqs_pins { ddr_db_par } {
	upvar $ddr_db_par local_ddr_db

	set dqs_pins [ list ]
	set instnames [ array names local_ddr_db ]
	foreach instance $instnames {
		array set pins $local_ddr_db($instance)

		foreach { qk_pin } $pins(qk_pins) {
			lappend dqs_pins $qk_pin
		}
		foreach { qkn_pin } $pins(qkn_pins) {
			lappend dqs_pins $qkn_pin
		}
		foreach { dk_pin } $pins(dk_pins) {
			lappend dqs_pins $dk_pin
		}
		foreach { dkn_pin } $pins(dkn_pins) {
			lappend dqs_pins $dkn_pin
		}
		foreach { ck_pin } $pins(ck_pins) {
			lappend dqs_pins $ck_pin
		}
		foreach { ckn_pin } $pins(ckn_pins) {
			lappend dqs_pins $ckn_pin
		}
	}

	return $dqs_pins
}

proc RLDRAMII_p0_dump_all_pins { ddr_db_par } {
	upvar $ddr_db_par local_ddr_db

	set instnames [ array names local_ddr_db ]

	set filename "${::GLOBAL_RLDRAMII_p0_corename}_all_pins.txt"
	if [ catch { open $filename w 0777 } FH ] {
		post_message -type error "Can't open file < $filename > for writing"
	}

	post_message -type info "Dumping reference pin-map file: $filename"

	set script_name [ info script ]
	puts $FH "# PIN MAP for core < $::GLOBAL_RLDRAMII_p0_corename >"
	puts $FH "#"
	puts $FH "# Generated by ${::GLOBAL_RLDRAMII_p0_corename}_pin_assignments.tcl"
	puts $FH "#"
	puts $FH "# This file is for reference only and is not used by Quartus II"
	puts $FH "#"
	puts $FH ""

	foreach instance $instnames {
		array set pins $local_ddr_db($instance)

		puts $FH "INSTANCE: $instance"
		puts $FH "QK: $pins(qk_pins)"
		puts $FH "QKn: $pins(qkn_pins)"
		puts $FH "Q: $pins(q_groups)"

		puts $FH "DK: $pins(dk_pins)"
		puts $FH "DKn: $pins(dkn_pins)"
		puts $FH "D: $pins(d_groups)"
		puts $FH "DM: $pins(dm_pins)"

		puts $FH "CK: $pins(ck_pins)"
		puts $FH "CKn: $pins(ckn_pins)"

		puts $FH "ADD: $pins(add_pins)"
		puts $FH "CMD: $pins(cmd_pins)"
		puts $FH "BA: $pins(ba_pins)"

		puts $FH "REF CLK: $pins(pll_ref_clock)"
		puts $FH "PLL CK: $pins(pll_ck_clock)"
		puts $FH "PLL AFI: $pins(pll_afi_clock)"
		puts $FH "PLL AFI PHY: $pins(pll_afi_phy_clock)"
		puts $FH "PLL DK: $pins(pll_dk_clock)"
		puts $FH "PLL AC: $pins(pll_ac_clock)"
		puts $FH "PLL AVL: $pins(pll_avl_clock)"
		puts $FH "PLL CONFIG: $pins(pll_config_clock)"

		set i 0
		foreach dqs_in_clock_struct $pins(dqs_in_clocks) {
			array set dqs_in_clock $dqs_in_clock_struct
			puts $FH "DQS_IN_CLOCK DQS_PIN ($i): $dqs_in_clock(dqs_pin)"
			puts $FH "DQS_IN_CLOCK DIV_NAME ($i): $dqs_in_clock(div_name)"
			puts $FH "DQS_IN_CLOCK DIV_PIN ($i): $dqs_in_clock(div_pin)"
			incr i
		}

		puts $FH "READ CAPTURE DDIO: $pins(read_capture_ddio)"
		puts $FH "RESET REGISTERS: $pins(reset_reg)"
		puts $FH "SYNCHRONIZERS: $pins(sync_reg)"
		puts $FH "SYNCHRONIZATION FIFO WRITE REGISTERS: $pins(fifo_wrdata_reg)"
		puts $FH "SYNCHRONIZATION FIFO READ REGISTERS: $pins(fifo_rddata_reg)"
		puts $FH "VALID PREDICTION FIFO WRITE REGISTERS: $pins(valid_fifo_wrdata_reg)"
		puts $FH "VALID PREDICTION FIFO READ REGISTERS: $pins(valid_fifo_rddata_reg)"

		puts $FH ""
		puts $FH "#"
		puts $FH "# END OF INSTANCE: $instance"
		puts $FH ""
	}

	close $FH
}
proc RLDRAMII_p0_dump_static_pin_map { ddr_db_par filename } {
	upvar $ddr_db_par local_ddr_db

	set instnames [ array names local_ddr_db ]

	if [ catch { open $filename w 0777 } FH ] {
		post_message -type error "Can't open file < $filename > for writing"
	}

	post_message -type info "Dumping static pin-map file: $filename"

	puts $FH "# AUTO-GENERATED static pin map for core < $::GLOBAL_RLDRAMII_p0_corename >"
	puts $FH ""
	puts $FH "proc ${::GLOBAL_RLDRAMII_p0_corename}_initialize_static_ddr_db { ddr_db_par } {"
	puts $FH "   upvar \$ddr_db_par local_ddr_db"
	puts $FH ""

	foreach instname $instnames {
		array set pins $local_ddr_db($instname)

		puts $FH "   # Pin Mapping for instance: $instname"

		RLDRAMII_p0_static_map_expand_list $FH pins qk_pins
		RLDRAMII_p0_static_map_expand_list $FH pins qkn_pins

		RLDRAMII_p0_static_map_expand_list_of_list $FH pins q_groups

		puts $FH ""
		puts $FH "   set pins(all_dq_pins) \[ join \[ join \$pins(q_groups) \] \]"

		RLDRAMII_p0_static_map_expand_list $FH pins dk_pins
		RLDRAMII_p0_static_map_expand_list $FH pins dkn_pins

		RLDRAMII_p0_static_map_expand_list_of_list $FH pins d_groups
		RLDRAMII_p0_static_map_expand_list $FH pins dm_pins

		RLDRAMII_p0_static_map_expand_list $FH pins ck_pins
		RLDRAMII_p0_static_map_expand_list $FH pins ckn_pins

		RLDRAMII_p0_static_map_expand_list $FH pins add_pins
		RLDRAMII_p0_static_map_expand_list $FH pins cmd_pins
		RLDRAMII_p0_static_map_expand_list $FH pins ba_pins

		puts $FH ""
		puts $FH "   set pins(ac_pins) \[ concat \$pins(add_pins) \$pins(ba_pins) \$pins(cmd_pins) \]"

		RLDRAMII_p0_static_map_expand_string $FH pins pll_ref_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_ck_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_afi_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_afi_phy_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_dk_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_ac_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_avl_clock
		RLDRAMII_p0_static_map_expand_string $FH pins pll_config_clock

		puts $FH ""
		puts $FH "   set dqs_in_clocks \[ list \]"
		set i 0
		foreach dqs_in_clock_struct $pins(dqs_in_clocks) {
			array set dqs_in_clock $dqs_in_clock_struct
			puts $FH "   # DIV Clock ($i)"
			puts $FH "   set dqs_in_clock(dqs_pin) $dqs_in_clock(dqs_pin)"
			puts $FH "   set dqs_in_clock(div_name) $dqs_in_clock(div_name)"
			puts $FH "   set dqs_in_clock(div_pin) $dqs_in_clock(div_pin)"
			puts $FH "   lappend dqs_in_clocks \[ array get dqs_in_clock \]"
			incr i
		}
		puts $FH "   set pins(dqs_in_clocks) \$dqs_in_clocks"

		RLDRAMII_p0_static_map_expand_string $FH pins read_capture_ddio
		RLDRAMII_p0_static_map_expand_string $FH pins reset_reg
		RLDRAMII_p0_static_map_expand_string $FH pins sync_reg
		RLDRAMII_p0_static_map_expand_string $FH pins fifo_wrdata_reg
		RLDRAMII_p0_static_map_expand_string $FH pins fifo_rddata_reg
		RLDRAMII_p0_static_map_expand_string $FH pins valid_fifo_wrdata_reg
		RLDRAMII_p0_static_map_expand_string $FH pins valid_fifo_rddata_reg

		puts $FH ""
		puts $FH "   set local_ddr_db($instname) \[ array get pins \]"
	}

	puts $FH "}"

	close $FH
}
