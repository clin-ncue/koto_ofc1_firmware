library ieee;
use ieee.std_logic_1164.all;

entity user_logic_phy_controller_dummy is
  port (
    phy_mgmt_clk          : in  std_logic                     := '0';
    phy_mgmt_clk_reset    : in  std_logic                     :='0';
    phy_mgmt_address      : out std_logic_vector(8 downto 0)  := (others => '0');
    phy_mgmt_read         : out std_logic                     := '0';
    phy_mgmt_readdata     : in  std_logic_vector(31 downto 0);
    phy_mgmt_waitrequest  : in  std_logic;
    phy_mgmt_write        : out std_logic;
    phy_mgmt_writedata    : out std_logic_vector(31 downto 0) := (others => '0')
	 );
end entity user_logic_phy_controller_dummy;

architecture behavioral of user_logic_phy_controller_dummy is
begin
-- concurrent signal assignments
	proc_sync : process (phy_mgmt_clk, phy_mgmt_clk_reset, phy_mgmt_waitrequest) is
	begin
		phy_mgmt_address <= "000000000";
		phy_mgmt_read <= '0';
		phy_mgmt_write <= '0';
		phy_mgmt_writedata <= x"00000000";
	end process proc_sync;
end architecture behavioral;