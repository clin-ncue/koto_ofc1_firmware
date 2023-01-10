-- megafunction wizard: %ALTSYNCRAM%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altsyncram 

-- ============================================================
-- File Name: vme_buffer.vhd
-- Megafunction Name(s):
-- 			altsyncram
--
-- Simulation Library Files(s):
-- 			altera_mf
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 7.2 Build 207 03/18/2008 SP 3 SJ Full Version
-- ************************************************************


--Copyright (C) 1991-2007 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY vme_buffer IS
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (255 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (12 DOWNTO 0);
		rdclock		: IN STD_LOGIC ;
		rdclocken		: IN STD_LOGIC  := '1';
		wraddress		: IN STD_LOGIC_VECTOR (12 DOWNTO 0);
		wrclock		: IN STD_LOGIC ;
		wrclocken		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (255 DOWNTO 0)
	);
END vme_buffer;


ARCHITECTURE SYN OF vme_buffer IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (255 DOWNTO 0);



	COMPONENT altsyncram
	GENERIC (
		address_reg_b		: STRING;
		clock_enable_input_a		: STRING;
		clock_enable_input_b		: STRING;
		clock_enable_output_a		: STRING;
		clock_enable_output_b		: STRING;
		intended_device_family		: STRING;
		lpm_type		: STRING;
		numwords_a		: NATURAL;
		numwords_b		: NATURAL;
		operation_mode		: STRING;
		outdata_aclr_b		: STRING;
		outdata_reg_b		: STRING;
		power_up_uninitialized		: STRING;
		widthad_a		: NATURAL;
		widthad_b		: NATURAL;
		width_a		: NATURAL;
		width_b		: NATURAL;
		width_byteena_a		: NATURAL
	);
	PORT (
			clocken0	: IN STD_LOGIC ;
			clocken1	: IN STD_LOGIC ;
			wren_a	: IN STD_LOGIC ;
			clock0	: IN STD_LOGIC ;
			clock1	: IN STD_LOGIC ;
			address_a	: IN STD_LOGIC_VECTOR (12 DOWNTO 0);
			address_b	: IN STD_LOGIC_VECTOR (12 DOWNTO 0);
			q_b	: OUT STD_LOGIC_VECTOR (255 DOWNTO 0);
			data_a	: IN STD_LOGIC_VECTOR (255 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	q    <= sub_wire0(255 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_reg_b => "CLOCK1",
		clock_enable_input_a => "NORMAL",
		clock_enable_input_b => "NORMAL",
		clock_enable_output_a => "BYPASS",
		clock_enable_output_b => "NORMAL",
		intended_device_family => "Stratix II",
		lpm_type => "altsyncram",
		numwords_a => 5120,
		numwords_b => 5120,
		operation_mode => "DUAL_PORT",
		outdata_aclr_b => "NONE",
		outdata_reg_b => "CLOCK1",
		power_up_uninitialized => "FALSE",
		widthad_a => 13,
		widthad_b => 13,
		width_a => 256,
		width_b => 256,
		width_byteena_a => 1
	)
	PORT MAP (
		clocken0 => wrclocken,
		clocken1 => rdclocken,
		wren_a => wren,
		clock0 => wrclock,
		clock1 => rdclock,
		address_a => wraddress,
		address_b => rdaddress,
		data_a => data,
		q_b => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
-- Retrieval info: PRIVATE: ADDRESSSTALL_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_B NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_B NUMERIC "1"
-- Retrieval info: PRIVATE: CLRdata NUMERIC "0"
-- Retrieval info: PRIVATE: CLRq NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrren NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwraddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwren NUMERIC "0"
-- Retrieval info: PRIVATE: Clock NUMERIC "1"
-- Retrieval info: PRIVATE: Clock_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clock_B NUMERIC "0"
-- Retrieval info: PRIVATE: ECC NUMERIC "0"
-- Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "0"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_B"
-- Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix II"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
-- Retrieval info: PRIVATE: MEMSIZE NUMERIC "1310720"
-- Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "0"
-- Retrieval info: PRIVATE: MIFfilename STRING "sigma_delta.mif"
-- Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "2"
-- Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "2"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_B NUMERIC "3"
-- Retrieval info: PRIVATE: REGdata NUMERIC "1"
-- Retrieval info: PRIVATE: REGq NUMERIC "0"
-- Retrieval info: PRIVATE: REGrdaddress NUMERIC "1"
-- Retrieval info: PRIVATE: REGrren NUMERIC "1"
-- Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
-- Retrieval info: PRIVATE: REGwren NUMERIC "1"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: USE_DIFF_CLKEN NUMERIC "0"
-- Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
-- Retrieval info: PRIVATE: VarWidth NUMERIC "0"
-- Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "256"
-- Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "256"
-- Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "256"
-- Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "256"
-- Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "0"
-- Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: enable NUMERIC "1"
-- Retrieval info: PRIVATE: rden NUMERIC "0"
-- Retrieval info: CONSTANT: ADDRESS_REG_B STRING "CLOCK1"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "NORMAL"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_B STRING "NORMAL"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_B STRING "NORMAL"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix II"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "5120"
-- Retrieval info: CONSTANT: NUMWORDS_B NUMERIC "5120"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "DUAL_PORT"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_B STRING "CLOCK1"
-- Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "13"
-- Retrieval info: CONSTANT: WIDTHAD_B NUMERIC "13"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "256"
-- Retrieval info: CONSTANT: WIDTH_B NUMERIC "256"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
-- Retrieval info: USED_PORT: data 0 0 256 0 INPUT NODEFVAL data[255..0]
-- Retrieval info: USED_PORT: q 0 0 256 0 OUTPUT NODEFVAL q[255..0]
-- Retrieval info: USED_PORT: rdaddress 0 0 13 0 INPUT NODEFVAL rdaddress[12..0]
-- Retrieval info: USED_PORT: rdclock 0 0 0 0 INPUT NODEFVAL rdclock
-- Retrieval info: USED_PORT: rdclocken 0 0 0 0 INPUT VCC rdclocken
-- Retrieval info: USED_PORT: wraddress 0 0 13 0 INPUT NODEFVAL wraddress[12..0]
-- Retrieval info: USED_PORT: wrclock 0 0 0 0 INPUT NODEFVAL wrclock
-- Retrieval info: USED_PORT: wrclocken 0 0 0 0 INPUT VCC wrclocken
-- Retrieval info: USED_PORT: wren 0 0 0 0 INPUT VCC wren
-- Retrieval info: CONNECT: @data_a 0 0 256 0 data 0 0 256 0
-- Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
-- Retrieval info: CONNECT: q 0 0 256 0 @q_b 0 0 256 0
-- Retrieval info: CONNECT: @address_a 0 0 13 0 wraddress 0 0 13 0
-- Retrieval info: CONNECT: @address_b 0 0 13 0 rdaddress 0 0 13 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 wrclock 0 0 0 0
-- Retrieval info: CONNECT: @clocken0 0 0 0 0 wrclocken 0 0 0 0
-- Retrieval info: CONNECT: @clock1 0 0 0 0 rdclock 0 0 0 0
-- Retrieval info: CONNECT: @clocken1 0 0 0 0 rdclocken 0 0 0 0
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer.inc TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer.cmp FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer_inst.vhd FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer_waveforms.html TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL vme_buffer_wave*.jpg FALSE
-- Retrieval info: LIB_FILE: altera_mf
