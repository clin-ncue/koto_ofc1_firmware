-- megafunction wizard: %LPM_MUX%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_MUX 

-- ============================================================
-- File Name: mux16_16.vhd
-- Megafunction Name(s):
-- 			LPM_MUX
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 15.0.0 Build 145 04/22/2015 SJ Full Version
-- ************************************************************


--Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, the Altera Quartus II License Agreement,
--the Altera MegaCore Function License Agreement, or other 
--applicable license agreement, including, without limitation, 
--that your use is for the sole purpose of programming logic 
--devices manufactured by Altera and sold by Altera or its 
--authorized distributors.  Please refer to the applicable 
--agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY mux16_16 IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		data0x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data10x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data11x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data12x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data13x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data14x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data15x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data3x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data4x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data5x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data6x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data7x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data8x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data9x		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		sel		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END mux16_16;


ARCHITECTURE SYN OF mux16_16 IS

--	type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_2D (15 DOWNTO 0, 15 DOWNTO 0);
	SIGNAL sub_wire2	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire6	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire7	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire8	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire9	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire10	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire11	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire12	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire13	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire14	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire15	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire16	: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL sub_wire17	: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
	sub_wire16    <= data0x(15 DOWNTO 0);
	sub_wire15    <= data1x(15 DOWNTO 0);
	sub_wire14    <= data2x(15 DOWNTO 0);
	sub_wire13    <= data3x(15 DOWNTO 0);
	sub_wire12    <= data4x(15 DOWNTO 0);
	sub_wire11    <= data5x(15 DOWNTO 0);
	sub_wire10    <= data6x(15 DOWNTO 0);
	sub_wire9    <= data7x(15 DOWNTO 0);
	sub_wire8    <= data8x(15 DOWNTO 0);
	sub_wire7    <= data9x(15 DOWNTO 0);
	sub_wire6    <= data10x(15 DOWNTO 0);
	sub_wire5    <= data11x(15 DOWNTO 0);
	sub_wire4    <= data12x(15 DOWNTO 0);
	sub_wire3    <= data13x(15 DOWNTO 0);
	sub_wire2    <= data14x(15 DOWNTO 0);
	sub_wire0    <= data15x(15 DOWNTO 0);
	sub_wire1(15, 0)    <= sub_wire0(0);
	sub_wire1(15, 1)    <= sub_wire0(1);
	sub_wire1(15, 2)    <= sub_wire0(2);
	sub_wire1(15, 3)    <= sub_wire0(3);
	sub_wire1(15, 4)    <= sub_wire0(4);
	sub_wire1(15, 5)    <= sub_wire0(5);
	sub_wire1(15, 6)    <= sub_wire0(6);
	sub_wire1(15, 7)    <= sub_wire0(7);
	sub_wire1(15, 8)    <= sub_wire0(8);
	sub_wire1(15, 9)    <= sub_wire0(9);
	sub_wire1(15, 10)    <= sub_wire0(10);
	sub_wire1(15, 11)    <= sub_wire0(11);
	sub_wire1(15, 12)    <= sub_wire0(12);
	sub_wire1(15, 13)    <= sub_wire0(13);
	sub_wire1(15, 14)    <= sub_wire0(14);
	sub_wire1(15, 15)    <= sub_wire0(15);
	sub_wire1(14, 0)    <= sub_wire2(0);
	sub_wire1(14, 1)    <= sub_wire2(1);
	sub_wire1(14, 2)    <= sub_wire2(2);
	sub_wire1(14, 3)    <= sub_wire2(3);
	sub_wire1(14, 4)    <= sub_wire2(4);
	sub_wire1(14, 5)    <= sub_wire2(5);
	sub_wire1(14, 6)    <= sub_wire2(6);
	sub_wire1(14, 7)    <= sub_wire2(7);
	sub_wire1(14, 8)    <= sub_wire2(8);
	sub_wire1(14, 9)    <= sub_wire2(9);
	sub_wire1(14, 10)    <= sub_wire2(10);
	sub_wire1(14, 11)    <= sub_wire2(11);
	sub_wire1(14, 12)    <= sub_wire2(12);
	sub_wire1(14, 13)    <= sub_wire2(13);
	sub_wire1(14, 14)    <= sub_wire2(14);
	sub_wire1(14, 15)    <= sub_wire2(15);
	sub_wire1(13, 0)    <= sub_wire3(0);
	sub_wire1(13, 1)    <= sub_wire3(1);
	sub_wire1(13, 2)    <= sub_wire3(2);
	sub_wire1(13, 3)    <= sub_wire3(3);
	sub_wire1(13, 4)    <= sub_wire3(4);
	sub_wire1(13, 5)    <= sub_wire3(5);
	sub_wire1(13, 6)    <= sub_wire3(6);
	sub_wire1(13, 7)    <= sub_wire3(7);
	sub_wire1(13, 8)    <= sub_wire3(8);
	sub_wire1(13, 9)    <= sub_wire3(9);
	sub_wire1(13, 10)    <= sub_wire3(10);
	sub_wire1(13, 11)    <= sub_wire3(11);
	sub_wire1(13, 12)    <= sub_wire3(12);
	sub_wire1(13, 13)    <= sub_wire3(13);
	sub_wire1(13, 14)    <= sub_wire3(14);
	sub_wire1(13, 15)    <= sub_wire3(15);
	sub_wire1(12, 0)    <= sub_wire4(0);
	sub_wire1(12, 1)    <= sub_wire4(1);
	sub_wire1(12, 2)    <= sub_wire4(2);
	sub_wire1(12, 3)    <= sub_wire4(3);
	sub_wire1(12, 4)    <= sub_wire4(4);
	sub_wire1(12, 5)    <= sub_wire4(5);
	sub_wire1(12, 6)    <= sub_wire4(6);
	sub_wire1(12, 7)    <= sub_wire4(7);
	sub_wire1(12, 8)    <= sub_wire4(8);
	sub_wire1(12, 9)    <= sub_wire4(9);
	sub_wire1(12, 10)    <= sub_wire4(10);
	sub_wire1(12, 11)    <= sub_wire4(11);
	sub_wire1(12, 12)    <= sub_wire4(12);
	sub_wire1(12, 13)    <= sub_wire4(13);
	sub_wire1(12, 14)    <= sub_wire4(14);
	sub_wire1(12, 15)    <= sub_wire4(15);
	sub_wire1(11, 0)    <= sub_wire5(0);
	sub_wire1(11, 1)    <= sub_wire5(1);
	sub_wire1(11, 2)    <= sub_wire5(2);
	sub_wire1(11, 3)    <= sub_wire5(3);
	sub_wire1(11, 4)    <= sub_wire5(4);
	sub_wire1(11, 5)    <= sub_wire5(5);
	sub_wire1(11, 6)    <= sub_wire5(6);
	sub_wire1(11, 7)    <= sub_wire5(7);
	sub_wire1(11, 8)    <= sub_wire5(8);
	sub_wire1(11, 9)    <= sub_wire5(9);
	sub_wire1(11, 10)    <= sub_wire5(10);
	sub_wire1(11, 11)    <= sub_wire5(11);
	sub_wire1(11, 12)    <= sub_wire5(12);
	sub_wire1(11, 13)    <= sub_wire5(13);
	sub_wire1(11, 14)    <= sub_wire5(14);
	sub_wire1(11, 15)    <= sub_wire5(15);
	sub_wire1(10, 0)    <= sub_wire6(0);
	sub_wire1(10, 1)    <= sub_wire6(1);
	sub_wire1(10, 2)    <= sub_wire6(2);
	sub_wire1(10, 3)    <= sub_wire6(3);
	sub_wire1(10, 4)    <= sub_wire6(4);
	sub_wire1(10, 5)    <= sub_wire6(5);
	sub_wire1(10, 6)    <= sub_wire6(6);
	sub_wire1(10, 7)    <= sub_wire6(7);
	sub_wire1(10, 8)    <= sub_wire6(8);
	sub_wire1(10, 9)    <= sub_wire6(9);
	sub_wire1(10, 10)    <= sub_wire6(10);
	sub_wire1(10, 11)    <= sub_wire6(11);
	sub_wire1(10, 12)    <= sub_wire6(12);
	sub_wire1(10, 13)    <= sub_wire6(13);
	sub_wire1(10, 14)    <= sub_wire6(14);
	sub_wire1(10, 15)    <= sub_wire6(15);
	sub_wire1(9, 0)    <= sub_wire7(0);
	sub_wire1(9, 1)    <= sub_wire7(1);
	sub_wire1(9, 2)    <= sub_wire7(2);
	sub_wire1(9, 3)    <= sub_wire7(3);
	sub_wire1(9, 4)    <= sub_wire7(4);
	sub_wire1(9, 5)    <= sub_wire7(5);
	sub_wire1(9, 6)    <= sub_wire7(6);
	sub_wire1(9, 7)    <= sub_wire7(7);
	sub_wire1(9, 8)    <= sub_wire7(8);
	sub_wire1(9, 9)    <= sub_wire7(9);
	sub_wire1(9, 10)    <= sub_wire7(10);
	sub_wire1(9, 11)    <= sub_wire7(11);
	sub_wire1(9, 12)    <= sub_wire7(12);
	sub_wire1(9, 13)    <= sub_wire7(13);
	sub_wire1(9, 14)    <= sub_wire7(14);
	sub_wire1(9, 15)    <= sub_wire7(15);
	sub_wire1(8, 0)    <= sub_wire8(0);
	sub_wire1(8, 1)    <= sub_wire8(1);
	sub_wire1(8, 2)    <= sub_wire8(2);
	sub_wire1(8, 3)    <= sub_wire8(3);
	sub_wire1(8, 4)    <= sub_wire8(4);
	sub_wire1(8, 5)    <= sub_wire8(5);
	sub_wire1(8, 6)    <= sub_wire8(6);
	sub_wire1(8, 7)    <= sub_wire8(7);
	sub_wire1(8, 8)    <= sub_wire8(8);
	sub_wire1(8, 9)    <= sub_wire8(9);
	sub_wire1(8, 10)    <= sub_wire8(10);
	sub_wire1(8, 11)    <= sub_wire8(11);
	sub_wire1(8, 12)    <= sub_wire8(12);
	sub_wire1(8, 13)    <= sub_wire8(13);
	sub_wire1(8, 14)    <= sub_wire8(14);
	sub_wire1(8, 15)    <= sub_wire8(15);
	sub_wire1(7, 0)    <= sub_wire9(0);
	sub_wire1(7, 1)    <= sub_wire9(1);
	sub_wire1(7, 2)    <= sub_wire9(2);
	sub_wire1(7, 3)    <= sub_wire9(3);
	sub_wire1(7, 4)    <= sub_wire9(4);
	sub_wire1(7, 5)    <= sub_wire9(5);
	sub_wire1(7, 6)    <= sub_wire9(6);
	sub_wire1(7, 7)    <= sub_wire9(7);
	sub_wire1(7, 8)    <= sub_wire9(8);
	sub_wire1(7, 9)    <= sub_wire9(9);
	sub_wire1(7, 10)    <= sub_wire9(10);
	sub_wire1(7, 11)    <= sub_wire9(11);
	sub_wire1(7, 12)    <= sub_wire9(12);
	sub_wire1(7, 13)    <= sub_wire9(13);
	sub_wire1(7, 14)    <= sub_wire9(14);
	sub_wire1(7, 15)    <= sub_wire9(15);
	sub_wire1(6, 0)    <= sub_wire10(0);
	sub_wire1(6, 1)    <= sub_wire10(1);
	sub_wire1(6, 2)    <= sub_wire10(2);
	sub_wire1(6, 3)    <= sub_wire10(3);
	sub_wire1(6, 4)    <= sub_wire10(4);
	sub_wire1(6, 5)    <= sub_wire10(5);
	sub_wire1(6, 6)    <= sub_wire10(6);
	sub_wire1(6, 7)    <= sub_wire10(7);
	sub_wire1(6, 8)    <= sub_wire10(8);
	sub_wire1(6, 9)    <= sub_wire10(9);
	sub_wire1(6, 10)    <= sub_wire10(10);
	sub_wire1(6, 11)    <= sub_wire10(11);
	sub_wire1(6, 12)    <= sub_wire10(12);
	sub_wire1(6, 13)    <= sub_wire10(13);
	sub_wire1(6, 14)    <= sub_wire10(14);
	sub_wire1(6, 15)    <= sub_wire10(15);
	sub_wire1(5, 0)    <= sub_wire11(0);
	sub_wire1(5, 1)    <= sub_wire11(1);
	sub_wire1(5, 2)    <= sub_wire11(2);
	sub_wire1(5, 3)    <= sub_wire11(3);
	sub_wire1(5, 4)    <= sub_wire11(4);
	sub_wire1(5, 5)    <= sub_wire11(5);
	sub_wire1(5, 6)    <= sub_wire11(6);
	sub_wire1(5, 7)    <= sub_wire11(7);
	sub_wire1(5, 8)    <= sub_wire11(8);
	sub_wire1(5, 9)    <= sub_wire11(9);
	sub_wire1(5, 10)    <= sub_wire11(10);
	sub_wire1(5, 11)    <= sub_wire11(11);
	sub_wire1(5, 12)    <= sub_wire11(12);
	sub_wire1(5, 13)    <= sub_wire11(13);
	sub_wire1(5, 14)    <= sub_wire11(14);
	sub_wire1(5, 15)    <= sub_wire11(15);
	sub_wire1(4, 0)    <= sub_wire12(0);
	sub_wire1(4, 1)    <= sub_wire12(1);
	sub_wire1(4, 2)    <= sub_wire12(2);
	sub_wire1(4, 3)    <= sub_wire12(3);
	sub_wire1(4, 4)    <= sub_wire12(4);
	sub_wire1(4, 5)    <= sub_wire12(5);
	sub_wire1(4, 6)    <= sub_wire12(6);
	sub_wire1(4, 7)    <= sub_wire12(7);
	sub_wire1(4, 8)    <= sub_wire12(8);
	sub_wire1(4, 9)    <= sub_wire12(9);
	sub_wire1(4, 10)    <= sub_wire12(10);
	sub_wire1(4, 11)    <= sub_wire12(11);
	sub_wire1(4, 12)    <= sub_wire12(12);
	sub_wire1(4, 13)    <= sub_wire12(13);
	sub_wire1(4, 14)    <= sub_wire12(14);
	sub_wire1(4, 15)    <= sub_wire12(15);
	sub_wire1(3, 0)    <= sub_wire13(0);
	sub_wire1(3, 1)    <= sub_wire13(1);
	sub_wire1(3, 2)    <= sub_wire13(2);
	sub_wire1(3, 3)    <= sub_wire13(3);
	sub_wire1(3, 4)    <= sub_wire13(4);
	sub_wire1(3, 5)    <= sub_wire13(5);
	sub_wire1(3, 6)    <= sub_wire13(6);
	sub_wire1(3, 7)    <= sub_wire13(7);
	sub_wire1(3, 8)    <= sub_wire13(8);
	sub_wire1(3, 9)    <= sub_wire13(9);
	sub_wire1(3, 10)    <= sub_wire13(10);
	sub_wire1(3, 11)    <= sub_wire13(11);
	sub_wire1(3, 12)    <= sub_wire13(12);
	sub_wire1(3, 13)    <= sub_wire13(13);
	sub_wire1(3, 14)    <= sub_wire13(14);
	sub_wire1(3, 15)    <= sub_wire13(15);
	sub_wire1(2, 0)    <= sub_wire14(0);
	sub_wire1(2, 1)    <= sub_wire14(1);
	sub_wire1(2, 2)    <= sub_wire14(2);
	sub_wire1(2, 3)    <= sub_wire14(3);
	sub_wire1(2, 4)    <= sub_wire14(4);
	sub_wire1(2, 5)    <= sub_wire14(5);
	sub_wire1(2, 6)    <= sub_wire14(6);
	sub_wire1(2, 7)    <= sub_wire14(7);
	sub_wire1(2, 8)    <= sub_wire14(8);
	sub_wire1(2, 9)    <= sub_wire14(9);
	sub_wire1(2, 10)    <= sub_wire14(10);
	sub_wire1(2, 11)    <= sub_wire14(11);
	sub_wire1(2, 12)    <= sub_wire14(12);
	sub_wire1(2, 13)    <= sub_wire14(13);
	sub_wire1(2, 14)    <= sub_wire14(14);
	sub_wire1(2, 15)    <= sub_wire14(15);
	sub_wire1(1, 0)    <= sub_wire15(0);
	sub_wire1(1, 1)    <= sub_wire15(1);
	sub_wire1(1, 2)    <= sub_wire15(2);
	sub_wire1(1, 3)    <= sub_wire15(3);
	sub_wire1(1, 4)    <= sub_wire15(4);
	sub_wire1(1, 5)    <= sub_wire15(5);
	sub_wire1(1, 6)    <= sub_wire15(6);
	sub_wire1(1, 7)    <= sub_wire15(7);
	sub_wire1(1, 8)    <= sub_wire15(8);
	sub_wire1(1, 9)    <= sub_wire15(9);
	sub_wire1(1, 10)    <= sub_wire15(10);
	sub_wire1(1, 11)    <= sub_wire15(11);
	sub_wire1(1, 12)    <= sub_wire15(12);
	sub_wire1(1, 13)    <= sub_wire15(13);
	sub_wire1(1, 14)    <= sub_wire15(14);
	sub_wire1(1, 15)    <= sub_wire15(15);
	sub_wire1(0, 0)    <= sub_wire16(0);
	sub_wire1(0, 1)    <= sub_wire16(1);
	sub_wire1(0, 2)    <= sub_wire16(2);
	sub_wire1(0, 3)    <= sub_wire16(3);
	sub_wire1(0, 4)    <= sub_wire16(4);
	sub_wire1(0, 5)    <= sub_wire16(5);
	sub_wire1(0, 6)    <= sub_wire16(6);
	sub_wire1(0, 7)    <= sub_wire16(7);
	sub_wire1(0, 8)    <= sub_wire16(8);
	sub_wire1(0, 9)    <= sub_wire16(9);
	sub_wire1(0, 10)    <= sub_wire16(10);
	sub_wire1(0, 11)    <= sub_wire16(11);
	sub_wire1(0, 12)    <= sub_wire16(12);
	sub_wire1(0, 13)    <= sub_wire16(13);
	sub_wire1(0, 14)    <= sub_wire16(14);
	sub_wire1(0, 15)    <= sub_wire16(15);
	result    <= sub_wire17(15 DOWNTO 0);

	LPM_MUX_component : LPM_MUX
	GENERIC MAP (
		lpm_pipeline => 3,
		lpm_size => 16,
		lpm_type => "LPM_MUX",
		lpm_width => 16,
		lpm_widths => 4
	)
	PORT MAP (
		clock => clock,
		data => sub_wire1,
		sel => sel,
		result => sub_wire17
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Arria V"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_PIPELINE NUMERIC "3"
-- Retrieval info: CONSTANT: LPM_SIZE NUMERIC "16"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "16"
-- Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "4"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
-- Retrieval info: USED_PORT: data0x 0 0 16 0 INPUT NODEFVAL "data0x[15..0]"
-- Retrieval info: USED_PORT: data10x 0 0 16 0 INPUT NODEFVAL "data10x[15..0]"
-- Retrieval info: USED_PORT: data11x 0 0 16 0 INPUT NODEFVAL "data11x[15..0]"
-- Retrieval info: USED_PORT: data12x 0 0 16 0 INPUT NODEFVAL "data12x[15..0]"
-- Retrieval info: USED_PORT: data13x 0 0 16 0 INPUT NODEFVAL "data13x[15..0]"
-- Retrieval info: USED_PORT: data14x 0 0 16 0 INPUT NODEFVAL "data14x[15..0]"
-- Retrieval info: USED_PORT: data15x 0 0 16 0 INPUT NODEFVAL "data15x[15..0]"
-- Retrieval info: USED_PORT: data1x 0 0 16 0 INPUT NODEFVAL "data1x[15..0]"
-- Retrieval info: USED_PORT: data2x 0 0 16 0 INPUT NODEFVAL "data2x[15..0]"
-- Retrieval info: USED_PORT: data3x 0 0 16 0 INPUT NODEFVAL "data3x[15..0]"
-- Retrieval info: USED_PORT: data4x 0 0 16 0 INPUT NODEFVAL "data4x[15..0]"
-- Retrieval info: USED_PORT: data5x 0 0 16 0 INPUT NODEFVAL "data5x[15..0]"
-- Retrieval info: USED_PORT: data6x 0 0 16 0 INPUT NODEFVAL "data6x[15..0]"
-- Retrieval info: USED_PORT: data7x 0 0 16 0 INPUT NODEFVAL "data7x[15..0]"
-- Retrieval info: USED_PORT: data8x 0 0 16 0 INPUT NODEFVAL "data8x[15..0]"
-- Retrieval info: USED_PORT: data9x 0 0 16 0 INPUT NODEFVAL "data9x[15..0]"
-- Retrieval info: USED_PORT: result 0 0 16 0 OUTPUT NODEFVAL "result[15..0]"
-- Retrieval info: USED_PORT: sel 0 0 4 0 INPUT NODEFVAL "sel[3..0]"
-- Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @data 1 0 16 0 data0x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 10 16 0 data10x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 11 16 0 data11x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 12 16 0 data12x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 13 16 0 data13x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 14 16 0 data14x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 15 16 0 data15x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 1 16 0 data1x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 2 16 0 data2x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 3 16 0 data3x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 4 16 0 data4x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 5 16 0 data5x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 6 16 0 data6x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 7 16 0 data7x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 8 16 0 data8x 0 0 16 0
-- Retrieval info: CONNECT: @data 1 9 16 0 data9x 0 0 16 0
-- Retrieval info: CONNECT: @sel 0 0 4 0 sel 0 0 4 0
-- Retrieval info: CONNECT: result 0 0 16 0 @result 0 0 16 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL mux16_16.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mux16_16.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mux16_16.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mux16_16.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mux16_16_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm
