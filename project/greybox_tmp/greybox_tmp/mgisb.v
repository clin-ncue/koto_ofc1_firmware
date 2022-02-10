//lpm_mux CBX_SINGLE_OUTPUT_FILE="ON" LPM_PIPELINE=1 LPM_SIZE=2 LPM_TYPE="LPM_MUX" LPM_WIDTH=12 LPM_WIDTHS=1 clock data result sel
//VERSION_BEGIN 15.0 cbx_mgl 2015:04:22:18:06:50:SJ cbx_stratixii 2015:04:22:18:04:08:SJ cbx_util_mgl 2015:04:22:18:04:08:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, the Altera Quartus II License Agreement,
//  the Altera MegaCore Function License Agreement, or other 
//  applicable license agreement, including, without limitation, 
//  that your use is for the sole purpose of programming logic 
//  devices manufactured by Altera and sold by Altera or its 
//  authorized distributors.  Please refer to the applicable 
//  agreement for further details.



//synthesis_resources = lpm_mux 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mgisb
	( 
	clock,
	data,
	result,
	sel) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   [23:0]  data;
	output   [11:0]  result;
	input   [0:0]  sel;

	wire  [11:0]   wire_mgl_prim1_result;

	lpm_mux   mgl_prim1
	( 
	.clock(clock),
	.data(data),
	.result(wire_mgl_prim1_result),
	.sel(sel));
	defparam
		mgl_prim1.lpm_pipeline = 1,
		mgl_prim1.lpm_size = 2,
		mgl_prim1.lpm_type = "LPM_MUX",
		mgl_prim1.lpm_width = 12,
		mgl_prim1.lpm_widths = 1;
	assign
		result = wire_mgl_prim1_result;
endmodule //mgisb
//VALID FILE
