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
# This file specifies the timing properties of the memory device and
# of the memory interface


package require ::quartus::ddr_timing_model

###################
#                 #
# TIMING SETTINGS #
#                 #
###################

# Interface Clock Period
set t(CK) 4.0

# Reference Clock Period
set t(refCK) 8.0

# Minimum Clock Period
set t(min_CK) 2.5

##########################
# Memory timing parameters
##########################

# Clock high time
set t(CKH) [expr { 45 / 100.0 }]
set t(QKH) [expr { 90 / 100.0 }]

# A/C Setup/Hold
# NOTE:
#    t(CS) = tAS
#    t(CH) = tAH
set t(AS) [expr { 300 / 1000.0 }]
set t(AH) [expr { 350 / 1000.0 }]

# Data Setup/Hold
set t(DS) [expr { 175 / 1000.0 }]
set t(DH) [expr { 213 / 1000.0 }]

# QK clock edge to DQ data edge (in same group)
set t(QKQ_max) [expr { 200 / 1000.0 }]
set t(QKQ_min) [expr { -200 / 1000.0 }]

# Clock to Input Clock
set t(CKDK_max) [expr { 500 / 1000.0 }]
set t(CKDK_min) [expr { -450 / 1000.0 }]

# Clock to Output Clock
set t(CKQK_max) [expr { 250 / 1000.0 }]

# FPGA Duty Cycle Distortion
set t(DCD) [expr { 0.0 / 1000.0 }]

##########################
# Controller parameters
##########################

set t(BL) 4
set t(rd_to_wr_turnaround) 2

#####################
# FPGA specifications
#####################

# Sequencer VCALIB width. Determins multicycle length
set vcalib_count_width 2

set fpga(tPLL_PSERR) [expr { 0.0 / 1000.0 }]
set fpga(tPLL_JITTER) [expr { 0.0 / 1000.0 }]

# Systematic DCD in the Write Levelling delay chains
set t(WL_DCD) [expr [get_micro_node_delay -micro WL_DCD -parameters {IO VPAD} -in_fitter]/1000.0]
# Non-systematic DC jitter in the Write Levelling delay chains
set t(WL_DCJ) [expr [get_micro_node_delay -micro WL_DC_JITTER -parameters {IO VPAD} -in_fitter]/1000.0]
# Phase shift error in the Write Levelling delay chains between DQ and DQS
set t(WL_PSE) [expr [get_micro_node_delay -micro WL_PSERR -parameters {IO VPAD} -in_fitter]/1000.0]
# Jitter in the Write Levelling delay chains
set t(WL_JITTER) [expr [get_micro_node_delay -micro WL_JITTER -parameters {IO QCLK} -in_fitter]/1000.0]
set t(WL_JITTER_DIVISION) [expr [get_micro_node_delay -micro WL_JITTER_DIVISION -parameters {IO QCLK} -in_fitter]/100.0]

###############
# SSN Info
###############

set SSN(pushout_o) [expr [get_micro_node_delay -micro SSO -parameters [list IO DQDQSABSOLUTE NONLEVELED MAX] -in_fitter]/1000.0]
set SSN(pullin_o)  [expr [get_micro_node_delay -micro SSO -parameters [list IO DQDQSABSOLUTE NONLEVELED MIN] -in_fitter]/-1000.0]
set SSN(pushout_i) [expr [get_micro_node_delay -micro SSI -parameters [list IO DQDQSABSOLUTE NONLEVELED MAX] -in_fitter]/1000.0]
set SSN(pullin_i)  [expr [get_micro_node_delay -micro SSI -parameters [list IO DQDQSABSOLUTE NONLEVELED MIN] -in_fitter]/-1000.0]
set SSN(rel_pushout_o) [expr [get_micro_node_delay -micro SSO -parameters [list IO DQDQSRELATIVE NONLEVELED MAX] -in_fitter]/1000.0]
set SSN(rel_pullin_o)  [expr [get_micro_node_delay -micro SSO -parameters [list IO DQDQSRELATIVE NONLEVELED MIN] -in_fitter]/-1000.0]
set SSN(rel_pushout_i) [expr [get_micro_node_delay -micro SSI -parameters [list IO DQDQSRELATIVE NONLEVELED MAX] -in_fitter]/1000.0]
set SSN(rel_pullin_i)  [expr [get_micro_node_delay -micro SSI -parameters [list IO DQDQSRELATIVE NONLEVELED MIN] -in_fitter]/-1000.0]

###############
# Board Effects
###############

# Intersymbol Interference
set ISI(addresscmd_setup) [expr { 0 / 1000.0 }]
set ISI(addresscmd_hold) [expr { 0 / 1000.0 }]
set ISI(DQ) [expr { 0 / 1000.0 }]
set ISI(DQS) [expr { 0 / 1000.0 }]
set ISI(READ_DQ) [expr { 0.0 / 1000.0 }]
set ISI(READ_DQS) [expr { 0.0 / 1000.0 }]

# Board skews
set board(abs_max_CK_delay) [expr { 600 / 1000.0 }]
set board(abs_max_DK_delay) [expr { 600 / 1000.0 }]
set board(minCK_DK_skew) [expr { 0 / 1000.0 }]
set board(maxCK_DK_skew) [expr { 0 / 1000.0 }]
set board(tpd_inter_DIMM) [expr { 0 / 1000.0 }]
set board(intra_DQS_group_skew) [expr { 20 / 1000.0 }]
set board(inter_DQS_group_skew) [expr { 20 / 1000.0 }]
set board(addresscmd_CK_skew) [expr { 0 / 1000.0 }]
set board(data_DK_skew)   [expr { 0 / 1000.0 }]
set board(data_QK_skew)   [expr { 0 / 1000.0 }]
set board(intra_addr_ctrl_skew) [expr { 20 / 1000.0 }]

