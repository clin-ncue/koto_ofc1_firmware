-- megafunction wizard: %RLDRAM II Controller with UniPHY v13.0%
-- GENERATION: XML
-- RLDRAMII.vhd

-- Generated using ACDS version 13.0sp1 232 at 2017.05.07.20:40:34

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RLDRAMII is
	port (
		pll_ref_clk               : in    std_logic                      := '0';             --      pll_ref_clk.clk
		global_reset_n            : in    std_logic                      := '0';             --     global_reset.reset_n
		soft_reset_n              : in    std_logic                      := '0';             --       soft_reset.reset_n
		afi_clk                   : out   std_logic;                                         --          afi_clk.clk
		afi_half_clk              : out   std_logic;                                         --     afi_half_clk.clk
		afi_reset_n               : out   std_logic;                                         --        afi_reset.reset_n
		afi_reset_export_n        : out   std_logic;                                         -- afi_reset_export.reset_n
		mem_a                     : out   std_logic_vector(18 downto 0);                     --           memory.mem_a
		mem_ba                    : out   std_logic_vector(2 downto 0);                      --                 .mem_ba
		mem_ck                    : out   std_logic;                                         --                 .mem_ck
		mem_ck_n                  : out   std_logic;                                         --                 .mem_ck_n
		mem_cs_n                  : out   std_logic_vector(0 downto 0);                      --                 .mem_cs_n
		mem_dk                    : out   std_logic_vector(1 downto 0);                      --                 .mem_dk
		mem_dk_n                  : out   std_logic_vector(1 downto 0);                      --                 .mem_dk_n
		mem_dm                    : out   std_logic_vector(0 downto 0);                      --                 .mem_dm
		mem_dq                    : inout std_logic_vector(35 downto 0)  := (others => '0'); --                 .mem_dq
		mem_qk                    : in    std_logic_vector(1 downto 0)   := (others => '0'); --                 .mem_qk
		mem_qk_n                  : in    std_logic_vector(1 downto 0)   := (others => '0'); --                 .mem_qk_n
		mem_ref_n                 : out   std_logic;                                         --                 .mem_ref_n
		mem_we_n                  : out   std_logic;                                         --                 .mem_we_n
		avl_size                  : in    std_logic_vector(2 downto 0)   := (others => '0'); --              avl.burstcount
		avl_wdata                 : in    std_logic_vector(143 downto 0) := (others => '0'); --                 .writedata
		avl_rdata_valid           : out   std_logic;                                         --                 .readdatavalid
		avl_rdata                 : out   std_logic_vector(143 downto 0);                    --                 .readdata
		avl_ready                 : out   std_logic;                                         --                 .waitrequest_n
		avl_write_req             : in    std_logic                      := '0';             --                 .write
		avl_read_req              : in    std_logic                      := '0';             --                 .read
		avl_addr                  : in    std_logic_vector(21 downto 0)  := (others => '0'); --                 .address
		local_init_done           : out   std_logic;                                         --           status.local_init_done
		local_cal_success         : out   std_logic;                                         --                 .local_cal_success
		local_cal_fail            : out   std_logic;                                         --                 .local_cal_fail
		oct_rzqin                 : in    std_logic                      := '0';             --              oct.rzqin
		pll_mem_clk               : out   std_logic;                                         --      pll_sharing.pll_mem_clk
		pll_write_clk             : out   std_logic;                                         --                 .pll_write_clk
		pll_write_clk_pre_phy_clk : out   std_logic;                                         --                 .pll_write_clk_pre_phy_clk
		pll_addr_cmd_clk          : out   std_logic;                                         --                 .pll_addr_cmd_clk
		pll_locked                : out   std_logic;                                         --                 .pll_locked
		pll_avl_clk               : out   std_logic;                                         --                 .pll_avl_clk
		pll_config_clk            : out   std_logic;                                         --                 .pll_config_clk
		pll_mem_phy_clk           : out   std_logic;                                         --                 .pll_mem_phy_clk
		afi_phy_clk               : out   std_logic;                                         --                 .afi_phy_clk
		pll_avl_phy_clk           : out   std_logic                                          --                 .pll_avl_phy_clk
	);
end entity RLDRAMII;

architecture rtl of RLDRAMII is
	component RLDRAMII_0002 is
		port (
			pll_ref_clk               : in    std_logic                      := 'X';             -- clk
			global_reset_n            : in    std_logic                      := 'X';             -- reset_n
			soft_reset_n              : in    std_logic                      := 'X';             -- reset_n
			afi_clk                   : out   std_logic;                                         -- clk
			afi_half_clk              : out   std_logic;                                         -- clk
			afi_reset_n               : out   std_logic;                                         -- reset_n
			afi_reset_export_n        : out   std_logic;                                         -- reset_n
			mem_a                     : out   std_logic_vector(18 downto 0);                     -- mem_a
			mem_ba                    : out   std_logic_vector(2 downto 0);                      -- mem_ba
			mem_ck                    : out   std_logic;                                         -- mem_ck
			mem_ck_n                  : out   std_logic;                                         -- mem_ck_n
			mem_cs_n                  : out   std_logic_vector(0 downto 0);                      -- mem_cs_n
			mem_dk                    : out   std_logic_vector(1 downto 0);                      -- mem_dk
			mem_dk_n                  : out   std_logic_vector(1 downto 0);                      -- mem_dk_n
			mem_dm                    : out   std_logic_vector(0 downto 0);                      -- mem_dm
			mem_dq                    : inout std_logic_vector(35 downto 0)  := (others => 'X'); -- mem_dq
			mem_qk                    : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- mem_qk
			mem_qk_n                  : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- mem_qk_n
			mem_ref_n                 : out   std_logic;                                         -- mem_ref_n
			mem_we_n                  : out   std_logic;                                         -- mem_we_n
			avl_size                  : in    std_logic_vector(2 downto 0)   := (others => 'X'); -- burstcount
			avl_wdata                 : in    std_logic_vector(143 downto 0) := (others => 'X'); -- writedata
			avl_rdata_valid           : out   std_logic;                                         -- readdatavalid
			avl_rdata                 : out   std_logic_vector(143 downto 0);                    -- readdata
			avl_ready                 : out   std_logic;                                         -- waitrequest_n
			avl_write_req             : in    std_logic                      := 'X';             -- write
			avl_read_req              : in    std_logic                      := 'X';             -- read
			avl_addr                  : in    std_logic_vector(21 downto 0)  := (others => 'X'); -- address
			local_init_done           : out   std_logic;                                         -- local_init_done
			local_cal_success         : out   std_logic;                                         -- local_cal_success
			local_cal_fail            : out   std_logic;                                         -- local_cal_fail
			oct_rzqin                 : in    std_logic                      := 'X';             -- rzqin
			pll_mem_clk               : out   std_logic;                                         -- pll_mem_clk
			pll_write_clk             : out   std_logic;                                         -- pll_write_clk
			pll_write_clk_pre_phy_clk : out   std_logic;                                         -- pll_write_clk_pre_phy_clk
			pll_addr_cmd_clk          : out   std_logic;                                         -- pll_addr_cmd_clk
			pll_locked                : out   std_logic;                                         -- pll_locked
			pll_avl_clk               : out   std_logic;                                         -- pll_avl_clk
			pll_config_clk            : out   std_logic;                                         -- pll_config_clk
			pll_mem_phy_clk           : out   std_logic;                                         -- pll_mem_phy_clk
			afi_phy_clk               : out   std_logic;                                         -- afi_phy_clk
			pll_avl_phy_clk           : out   std_logic                                          -- pll_avl_phy_clk
		);
	end component RLDRAMII_0002;

begin

	rldramii_inst : component RLDRAMII_0002
		port map (
			pll_ref_clk               => pll_ref_clk,               --      pll_ref_clk.clk
			global_reset_n            => global_reset_n,            --     global_reset.reset_n
			soft_reset_n              => soft_reset_n,              --       soft_reset.reset_n
			afi_clk                   => afi_clk,                   --          afi_clk.clk
			afi_half_clk              => afi_half_clk,              --     afi_half_clk.clk
			afi_reset_n               => afi_reset_n,               --        afi_reset.reset_n
			afi_reset_export_n        => afi_reset_export_n,        -- afi_reset_export.reset_n
			mem_a                     => mem_a,                     --           memory.mem_a
			mem_ba                    => mem_ba,                    --                 .mem_ba
			mem_ck                    => mem_ck,                    --                 .mem_ck
			mem_ck_n                  => mem_ck_n,                  --                 .mem_ck_n
			mem_cs_n                  => mem_cs_n,                  --                 .mem_cs_n
			mem_dk                    => mem_dk,                    --                 .mem_dk
			mem_dk_n                  => mem_dk_n,                  --                 .mem_dk_n
			mem_dm                    => mem_dm,                    --                 .mem_dm
			mem_dq                    => mem_dq,                    --                 .mem_dq
			mem_qk                    => mem_qk,                    --                 .mem_qk
			mem_qk_n                  => mem_qk_n,                  --                 .mem_qk_n
			mem_ref_n                 => mem_ref_n,                 --                 .mem_ref_n
			mem_we_n                  => mem_we_n,                  --                 .mem_we_n
			avl_size                  => avl_size,                  --              avl.burstcount
			avl_wdata                 => avl_wdata,                 --                 .writedata
			avl_rdata_valid           => avl_rdata_valid,           --                 .readdatavalid
			avl_rdata                 => avl_rdata,                 --                 .readdata
			avl_ready                 => avl_ready,                 --                 .waitrequest_n
			avl_write_req             => avl_write_req,             --                 .write
			avl_read_req              => avl_read_req,              --                 .read
			avl_addr                  => avl_addr,                  --                 .address
			local_init_done           => local_init_done,           --           status.local_init_done
			local_cal_success         => local_cal_success,         --                 .local_cal_success
			local_cal_fail            => local_cal_fail,            --                 .local_cal_fail
			oct_rzqin                 => oct_rzqin,                 --              oct.rzqin
			pll_mem_clk               => pll_mem_clk,               --      pll_sharing.pll_mem_clk
			pll_write_clk             => pll_write_clk,             --                 .pll_write_clk
			pll_write_clk_pre_phy_clk => pll_write_clk_pre_phy_clk, --                 .pll_write_clk_pre_phy_clk
			pll_addr_cmd_clk          => pll_addr_cmd_clk,          --                 .pll_addr_cmd_clk
			pll_locked                => pll_locked,                --                 .pll_locked
			pll_avl_clk               => pll_avl_clk,               --                 .pll_avl_clk
			pll_config_clk            => pll_config_clk,            --                 .pll_config_clk
			pll_mem_phy_clk           => pll_mem_phy_clk,           --                 .pll_mem_phy_clk
			afi_phy_clk               => afi_phy_clk,               --                 .afi_phy_clk
			pll_avl_phy_clk           => pll_avl_phy_clk            --                 .pll_avl_phy_clk
		);

end architecture rtl; -- of RLDRAMII
-- Retrieval info: <?xml version="1.0"?>
--<!--
--	Generated by Altera MegaWizard Launcher Utility version 1.0
--	************************************************************
--	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--	************************************************************
--	Copyright (C) 1991-2017 Altera Corporation
--	Any megafunction design, and related net list (encrypted or decrypted),
--	support information, device programming or simulation file, and any other
--	associated documentation or information provided by Altera or a partner
--	under Altera's Megafunction Partnership Program may be used only to
--	program PLD devices (but not masked PLD devices) from Altera.  Any other
--	use of such megafunction design, net list, support information, device
--	programming or simulation file, or any other related documentation or
--	information is prohibited for any other purpose, including, but not
--	limited to modification, reverse engineering, de-compiling, or use with
--	any other silicon devices, unless such use is explicitly licensed under
--	a separate agreement with Altera or a megafunction partner.  Title to
--	the intellectual property, including patents, copyrights, trademarks,
--	trade secrets, or maskworks, embodied in any such megafunction design,
--	net list, support information, device programming or simulation file, or
--	any other related documentation or information provided by Altera or a
--	megafunction partner, remains with Altera, the megafunction partner, or
--	their respective licensors.  No other licenses, including any licenses
--	needed under any third party's intellectual property, are provided herein.
---->
-- Retrieval info: <instance entity-name="altera_mem_if_rldramii_emif" version="13.0" >
-- Retrieval info: 	<generic name="MEM_ADDR_WIDTH" value="19" />
-- Retrieval info: 	<generic name="MEM_BURST_LENGTH" value="4" />
-- Retrieval info: 	<generic name="MEM_DQ_WIDTH" value="36" />
-- Retrieval info: 	<generic name="MEM_BANKADDR_WIDTH" value="3" />
-- Retrieval info: 	<generic name="MEM_DM_WIDTH" value="1" />
-- Retrieval info: 	<generic name="MEM_READ_DQS_WIDTH" value="2" />
-- Retrieval info: 	<generic name="MEM_WRITE_DQS_WIDTH" value="2" />
-- Retrieval info: 	<generic name="MRS_CONFIGURATION" value="3" />
-- Retrieval info: 	<generic name="MRS_IMPEDANCE_MATCHING" value="0" />
-- Retrieval info: 	<generic name="MRS_ODT" value="1" />
-- Retrieval info: 	<generic name="MEM_IF_DM_PINS_EN" value="true" />
-- Retrieval info: 	<generic name="MEM_CS_WIDTH" value="1" />
-- Retrieval info: 	<generic name="MEM_CONTROL_WIDTH" value="1" />
-- Retrieval info: 	<generic name="DEVICE_WIDTH" value="1" />
-- Retrieval info: 	<generic name="DEVICE_DEPTH" value="1" />
-- Retrieval info: 	<generic name="MEM_USE_DENALI_MODEL" value="false" />
-- Retrieval info: 	<generic name="MEM_DENALI_SOMA_FILE" value="rldramii.soma" />
-- Retrieval info: 	<generic name="MEM_DEVICE_MAX_ADDR_WIDTH" value="22" />
-- Retrieval info: 	<generic name="MEM_IF_BOARD_BASE_DELAY" value="10" />
-- Retrieval info: 	<generic name="MEM_VERBOSE" value="true" />
-- Retrieval info: 	<generic name="PINGPONGPHY_EN" value="false" />
-- Retrieval info: 	<generic name="MEM_CLK_FREQ_MAX" value="400.0" />
-- Retrieval info: 	<generic name="MEM_REFRESH_INTERVAL_NS" value="244" />
-- Retrieval info: 	<generic name="TIMING_TCKH" value="45" />
-- Retrieval info: 	<generic name="TIMING_TQKH" value="90" />
-- Retrieval info: 	<generic name="TIMING_TAS" value="400" />
-- Retrieval info: 	<generic name="TIMING_TAH" value="400" />
-- Retrieval info: 	<generic name="TIMING_TDS" value="250" />
-- Retrieval info: 	<generic name="TIMING_TDH" value="250" />
-- Retrieval info: 	<generic name="TIMING_TQKQ_MAX" value="200" />
-- Retrieval info: 	<generic name="TIMING_TQKQ_MIN" value="-200" />
-- Retrieval info: 	<generic name="TIMING_TCKDK_MAX" value="500" />
-- Retrieval info: 	<generic name="TIMING_TCKDK_MIN" value="-450" />
-- Retrieval info: 	<generic name="TIMING_TCKQK_MAX" value="250" />
-- Retrieval info: 	<generic name="SYS_INFO_DEVICE_FAMILY" value="Arria V" />
-- Retrieval info: 	<generic name="PARSE_FRIENDLY_DEVICE_FAMILY_PARAM_VALID" value="false" />
-- Retrieval info: 	<generic name="PARSE_FRIENDLY_DEVICE_FAMILY_PARAM" value="" />
-- Retrieval info: 	<generic name="DEVICE_FAMILY_PARAM" value="" />
-- Retrieval info: 	<generic name="SPEED_GRADE" value="4" />
-- Retrieval info: 	<generic name="IS_ES_DEVICE" value="false" />
-- Retrieval info: 	<generic name="DISABLE_CHILD_MESSAGING" value="false" />
-- Retrieval info: 	<generic name="HARD_EMIF" value="false" />
-- Retrieval info: 	<generic name="HHP_HPS" value="false" />
-- Retrieval info: 	<generic name="HHP_HPS_VERIFICATION" value="false" />
-- Retrieval info: 	<generic name="HHP_HPS_SIMULATION" value="false" />
-- Retrieval info: 	<generic name="HPS_PROTOCOL" value="DEFAULT" />
-- Retrieval info: 	<generic name="CUT_NEW_FAMILY_TIMING" value="true" />
-- Retrieval info: 	<generic name="POWER_OF_TWO_BUS" value="false" />
-- Retrieval info: 	<generic name="SOPC_COMPAT_RESET" value="false" />
-- Retrieval info: 	<generic name="AVL_MAX_SIZE" value="4" />
-- Retrieval info: 	<generic name="BYTE_ENABLE" value="false" />
-- Retrieval info: 	<generic name="CTL_LATENCY" value="2" />
-- Retrieval info: 	<generic name="USER_REFRESH" value="false" />
-- Retrieval info: 	<generic name="ERROR_DETECTION_PARITY" value="false" />
-- Retrieval info: 	<generic name="ENABLE_CTRL_AVALON_INTERFACE" value="true" />
-- Retrieval info: 	<generic name="ENABLE_EMIT_BFM_MASTER" value="false" />
-- Retrieval info: 	<generic name="FORCE_SEQUENCER_TCL_DEBUG_MODE" value="false" />
-- Retrieval info: 	<generic name="ENABLE_SEQUENCER_MARGINING_ON_BY_DEFAULT" value="false" />
-- Retrieval info: 	<generic name="REF_CLK_FREQ" value="125.0" />
-- Retrieval info: 	<generic name="REF_CLK_FREQ_PARAM_VALID" value="false" />
-- Retrieval info: 	<generic name="REF_CLK_FREQ_MIN_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="REF_CLK_FREQ_MAX_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_DR_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_DR_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_DR_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_DR_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_DR_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_DR_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_MEM_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_MEM_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_MEM_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_MEM_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_MEM_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_MEM_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_AFI_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_AFI_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_AFI_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_WRITE_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_WRITE_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_WRITE_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_WRITE_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_WRITE_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_WRITE_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_ADDR_CMD_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_HALF_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_NIOS_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_NIOS_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_NIOS_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_NIOS_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_NIOS_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_NIOS_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_CONFIG_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_CONFIG_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_CONFIG_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_CONFIG_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_CONFIG_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_CONFIG_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_P2C_READ_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_P2C_READ_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_P2C_READ_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_P2C_READ_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_P2C_READ_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_P2C_READ_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_C2P_WRITE_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_HR_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_HR_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_HR_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_HR_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_HR_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_HR_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_PHY_CLK_FREQ_PARAM" value="0.0" />
-- Retrieval info: 	<generic name="PLL_AFI_PHY_CLK_FREQ_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_AFI_PHY_CLK_PHASE_PS_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_PHY_CLK_PHASE_PS_SIM_STR_PARAM" value="" />
-- Retrieval info: 	<generic name="PLL_AFI_PHY_CLK_MULT_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_AFI_PHY_CLK_DIV_PARAM" value="0" />
-- Retrieval info: 	<generic name="PLL_CLK_PARAM_VALID" value="false" />
-- Retrieval info: 	<generic name="ENABLE_EXTRA_REPORTING" value="false" />
-- Retrieval info: 	<generic name="NUM_EXTRA_REPORT_PATH" value="10" />
-- Retrieval info: 	<generic name="ENABLE_ISS_PROBES" value="false" />
-- Retrieval info: 	<generic name="CALIB_REG_WIDTH" value="8" />
-- Retrieval info: 	<generic name="USE_SEQUENCER_BFM" value="false" />
-- Retrieval info: 	<generic name="DEFAULT_FAST_SIM_MODEL" value="true" />
-- Retrieval info: 	<generic name="PLL_SHARING_MODE" value="None" />
-- Retrieval info: 	<generic name="NUM_PLL_SHARING_INTERFACES" value="1" />
-- Retrieval info: 	<generic name="EXPORT_AFI_HALF_CLK" value="false" />
-- Retrieval info: 	<generic name="ABSTRACT_REAL_COMPARE_TEST" value="false" />
-- Retrieval info: 	<generic name="INCLUDE_BOARD_DELAY_MODEL" value="false" />
-- Retrieval info: 	<generic name="INCLUDE_MULTIRANK_BOARD_DELAY_MODEL" value="false" />
-- Retrieval info: 	<generic name="USE_FAKE_PHY" value="false" />
-- Retrieval info: 	<generic name="FORCE_MAX_LATENCY_COUNT_WIDTH" value="0" />
-- Retrieval info: 	<generic name="ENABLE_NON_DESTRUCTIVE_CALIB" value="false" />
-- Retrieval info: 	<generic name="TRACKING_ERROR_TEST" value="false" />
-- Retrieval info: 	<generic name="TRACKING_WATCH_TEST" value="false" />
-- Retrieval info: 	<generic name="MARGIN_VARIATION_TEST" value="false" />
-- Retrieval info: 	<generic name="EXTRA_SETTINGS" value="" />
-- Retrieval info: 	<generic name="MEM_DEVICE" value="MISSING_MODEL" />
-- Retrieval info: 	<generic name="FORCE_SYNTHESIS_LANGUAGE" value="" />
-- Retrieval info: 	<generic name="AFI_DEBUG_INFO_WIDTH" value="32" />
-- Retrieval info: 	<generic name="ADVERTIZE_SEQUENCER_SW_BUILD_FILES" value="false" />
-- Retrieval info: 	<generic name="PHY_ONLY" value="false" />
-- Retrieval info: 	<generic name="COMMAND_PHASE" value="0" />
-- Retrieval info: 	<generic name="MEM_CK_PHASE" value="0.0" />
-- Retrieval info: 	<generic name="P2C_READ_CLOCK_ADD_PHASE" value="0.0" />
-- Retrieval info: 	<generic name="C2P_WRITE_CLOCK_ADD_PHASE" value="0.0" />
-- Retrieval info: 	<generic name="ACV_PHY_CLK_ADD_FR_PHASE" value="0.0" />
-- Retrieval info: 	<generic name="HCX_COMPAT_MODE" value="false" />
-- Retrieval info: 	<generic name="PLL_LOCATION" value="Top_Bottom" />
-- Retrieval info: 	<generic name="IO_STANDARD" value="1.8-V HSTL" />
-- Retrieval info: 	<generic name="SEQUENCER_TYPE" value="NIOS" />
-- Retrieval info: 	<generic name="SKIP_MEM_INIT" value="true" />
-- Retrieval info: 	<generic name="CALIBRATION_MODE" value="Skip" />
-- Retrieval info: 	<generic name="MEM_IF_DQSN_EN" value="true" />
-- Retrieval info: 	<generic name="MEM_LEVELING" value="false" />
-- Retrieval info: 	<generic name="READ_DQ_DQS_CLOCK_SOURCE" value="INVERTED_DQS_BUS" />
-- Retrieval info: 	<generic name="DQ_INPUT_REG_USE_CLKN" value="false" />
-- Retrieval info: 	<generic name="DQS_DQSN_MODE" value="none" />
-- Retrieval info: 	<generic name="READ_FIFO_SIZE" value="8" />
-- Retrieval info: 	<generic name="NIOS_ROM_DATA_WIDTH" value="32" />
-- Retrieval info: 	<generic name="PHY_CSR_ENABLED" value="false" />
-- Retrieval info: 	<generic name="RLDRAMII_AV_EMIF_INVERT_CAPTURE_STROBE" value="false" />
-- Retrieval info: 	<generic name="TIMING_BOARD_AC_EYE_REDUCTION_SU" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_AC_EYE_REDUCTION_H" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_DQ_EYE_REDUCTION" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_DELTA_DQS_ARRIVAL_TIME" value="0" />
-- Retrieval info: 	<generic name="PACKAGE_DESKEW" value="false" />
-- Retrieval info: 	<generic name="AC_PACKAGE_DESKEW" value="false" />
-- Retrieval info: 	<generic name="TIMING_BOARD_MAX_CK_DELAY" value="600" />
-- Retrieval info: 	<generic name="TIMING_BOARD_MAX_DQS_DELAY" value="600" />
-- Retrieval info: 	<generic name="TIMING_BOARD_SKEW_CKDQS_DIMM_MIN" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_SKEW_CKDQS_DIMM_MAX" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_SKEW_BETWEEN_DIMMS" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_SKEW_WITHIN_DQS" value="20" />
-- Retrieval info: 	<generic name="TIMING_BOARD_SKEW_BETWEEN_DQS" value="20" />
-- Retrieval info: 	<generic name="TIMING_ADDR_CTRL_SKEW" value="20" />
-- Retrieval info: 	<generic name="TIMING_BOARD_AC_TO_CK_SKEW" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_DATA_TO_DK_SKEW" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_DATA_TO_QK_SKEW" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TAS" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TAS_VIH" value="-100" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TAH" value="0" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TAH_VIH" value="-50" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TDS" value="25" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TDS_VIH" value="-100" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TDH" value="13" />
-- Retrieval info: 	<generic name="TIMING_BOARD_TDH_VIH" value="-50" />
-- Retrieval info: 	<generic name="TIMING_BOARD_SKEW" value="20" />
-- Retrieval info: 	<generic name="USER_DEBUG_LEVEL" value="1" />
-- Retrieval info: 	<generic name="RATE" value="Half" />
-- Retrieval info: 	<generic name="MEM_CLK_FREQ" value="250.0" />
-- Retrieval info: 	<generic name="USE_MEM_CLK_FREQ" value="false" />
-- Retrieval info: 	<generic name="FORCE_DQS_TRACKING" value="AUTO" />
-- Retrieval info: 	<generic name="FORCE_SHADOW_REGS" value="AUTO" />
-- Retrieval info: 	<generic name="MRS_MIRROR_PING_PONG_ATSO" value="false" />
-- Retrieval info: 	<generic name="ENABLE_EXPORT_SEQ_DEBUG_BRIDGE" value="false" />
-- Retrieval info: 	<generic name="CORE_DEBUG_CONNECTION" value="EXPORT" />
-- Retrieval info: 	<generic name="ADD_EXTERNAL_SEQ_DEBUG_NIOS" value="false" />
-- Retrieval info: 	<generic name="ED_EXPORT_SEQ_DEBUG" value="false" />
-- Retrieval info: 	<generic name="ADD_EFFICIENCY_MONITOR" value="false" />
-- Retrieval info: 	<generic name="ENABLE_ABS_RAM_MEM_INIT" value="false" />
-- Retrieval info: 	<generic name="ABS_RAM_MEM_INIT_FILENAME" value="meminit" />
-- Retrieval info: 	<generic name="DLL_SHARING_MODE" value="None" />
-- Retrieval info: 	<generic name="NUM_DLL_SHARING_INTERFACES" value="1" />
-- Retrieval info: 	<generic name="OCT_SHARING_MODE" value="None" />
-- Retrieval info: 	<generic name="NUM_OCT_SHARING_INTERFACES" value="1" />
-- Retrieval info: 	<generic name="AUTO_DEVICE" value="Unknown" />
-- Retrieval info: </instance>
-- IPFS_FILES : RLDRAMII.vho
-- RELATED_FILES: RLDRAMII.vhd, RLDRAMII_0002.v, RLDRAMII_pll0.sv, RLDRAMII_p0_clock_pair_generator.v, RLDRAMII_p0_read_valid_selector.v, RLDRAMII_p0_addr_cmd_datapath.v, RLDRAMII_p0_reset.v, RLDRAMII_p0_acv_ldc.v, RLDRAMII_p0_memphy.sv, RLDRAMII_p0_reset_sync.v, RLDRAMII_p0_new_io_pads.v, RLDRAMII_p0_flop_mem.v, RLDRAMII_p0_fr_cycle_shifter.v, RLDRAMII_p0_fr_cycle_extender.v, RLDRAMII_p0_read_datapath.sv, RLDRAMII_p0_write_datapath.v, RLDRAMII_p0_simple_ddio_out.sv, RLDRAMII_p0_addr_cmd_pads.v, RLDRAMII_p0.sv, RLDRAMII_p0_altdqdqs.v, altdq_dqs2_acv_arriav.sv, RLDRAMII_p0_altdqdqs_r.v, afi_mux_rldramx.v, RLDRAMII_s0.v, altera_avalon_mm_bridge.v, altera_mem_if_sequencer_cpu_no_ifdef_params_synth_cpu_inst.v, altera_mem_if_sequencer_cpu_no_ifdef_params_synth_cpu_inst_test_bench.v, altera_mem_if_sequencer_mem_no_ifdef_params.sv, altera_mem_if_sequencer_rst.sv, altera_merlin_arbitrator.sv, altera_merlin_burst_uncompressor.sv, altera_merlin_master_agent.sv, altera_merlin_slave_agent.sv, altera_merlin_traffic_limiter.sv, RLDRAMII_s0_addr_router.sv, RLDRAMII_s0_addr_router_001.sv, RLDRAMII_s0_addr_router_002.sv, RLDRAMII_s0_cmd_xbar_demux.sv, RLDRAMII_s0_cmd_xbar_demux_001.sv, RLDRAMII_s0_cmd_xbar_demux_002.sv, RLDRAMII_s0_cmd_xbar_mux_003.sv, RLDRAMII_s0_cmd_xbar_mux_005.sv, RLDRAMII_s0_id_router.sv, RLDRAMII_s0_id_router_003.sv, RLDRAMII_s0_id_router_005.sv, RLDRAMII_s0_irq_mapper.sv, RLDRAMII_s0_rsp_xbar_demux_003.sv, RLDRAMII_s0_rsp_xbar_demux_005.sv, RLDRAMII_s0_rsp_xbar_mux.sv, RLDRAMII_s0_rsp_xbar_mux_001.sv, rw_manager_ac_ROM_no_ifdef_params.v, rw_manager_ac_ROM_reg.v, rw_manager_bitcheck.v, rw_manager_core.sv, rw_manager_datamux.v, rw_manager_data_broadcast.v, rw_manager_data_decoder.v, rw_manager_di_buffer.v, rw_manager_di_buffer_wrap.v, rw_manager_dm_decoder.v, rw_manager_generic.sv, rw_manager_inst_ROM_no_ifdef_params.v, rw_manager_inst_ROM_reg.v, rw_manager_jumplogic.v, rw_manager_lfsr12.v, rw_manager_lfsr36.v, rw_manager_lfsr72.v, rw_manager_pattern_fifo.v, rw_manager_ram.v, rw_manager_ram_csr.v, rw_manager_read_datapath.v, rw_manager_rldram.v, rw_manager_write_decoder.v, sequencer_data_mgr.sv, sequencer_phy_mgr.sv, sequencer_reg_file.sv, sequencer_scc_acv_phase_decode.v, sequencer_scc_acv_wrapper.sv, sequencer_scc_mgr.sv, sequencer_scc_reg_file.v, sequencer_scc_siii_phase_decode.v, sequencer_scc_siii_wrapper.sv, sequencer_scc_sv_phase_decode.v, sequencer_scc_sv_wrapper.sv, RLDRAMII_dmaster.v, alt_rld_controller_ctl_bl_is_one.sv, alt_rld_controller_top_ctl_bl_is_one.sv, alt_rld_afi_ctl_bl_is_one.sv, alt_rld_fsm_ctl_bl_is_one.sv, alt_rld_bank_timer.sv, alt_rld_timers.sv, alt_rld_refresh.sv, memctl_beat_valid_fifo.sv, memctl_parity.sv, memctl_reset_sync.v, memctl_wdata_fifo.sv, memctl_wdata_rdata_logic.sv, memctl_burst_latency_shifter_ctl_bl_is_one.sv, memctl_data_if_ctl_bl_is_one_rldramii.sv, altera_mem_if_oct_arriav.sv, altera_mem_if_dll_arriav.sv, altera_merlin_master_translator.sv, altera_merlin_slave_translator.sv, altera_avalon_st_jtag_interface.v, altera_jtag_dc_streaming.v, altera_jtag_sld_node.v, altera_jtag_streaming.v, altera_pli_streaming.v, altera_avalon_st_clock_crosser.v, altera_avalon_st_pipeline_base.v, altera_avalon_st_idle_remover.v, altera_avalon_st_idle_inserter.v, RLDRAMII_dmaster_timing_adt.v, altera_avalon_sc_fifo.v, altera_avalon_st_bytes_to_packets.v, altera_avalon_st_packets_to_bytes.v, altera_avalon_packets_to_master.v, RLDRAMII_dmaster_b2p_adapter.v, RLDRAMII_dmaster_p2b_adapter.v, altera_reset_controller.v, altera_reset_synchronizer.v
