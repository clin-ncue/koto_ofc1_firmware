library ieee;
use ieee.std_logic_1164.all;

entity user_logic_reconfig_controller is
  port (
    reconfig_busy             : in  std_logic;
    mgmt_clk_clk              : in  std_logic                     := '0';
    mgmt_rst_reset            : in  std_logic                     := '0';
    reconfig_mgmt_address     : out std_logic_vector(6 downto 0)  := (others => '0');
    reconfig_mgmt_read        : out std_logic                     := '0';
    reconfig_mgmt_readdata    : in  std_logic_vector(31 downto 0);
    reconfig_mgmt_waitrequest : in std_logic;
    reconfig_mgmt_write       : out std_logic                     := '0';
    reconfig_mgmt_writedata   : out std_logic_vector(31 downto 0) := (others => '0')
  );
end entity user_logic_reconfig_controller;

architecture behavioral of user_logic_reconfig_controller is
begin
  -- concurrent signal assignments
  reconfig_mgmt_address   <= "0000000";
  reconfig_mgmt_read      <= '0';
  reconfig_mgmt_write     <= '0';
  reconfig_mgmt_writedata <=  X"00000000";
end architecture behavioral;