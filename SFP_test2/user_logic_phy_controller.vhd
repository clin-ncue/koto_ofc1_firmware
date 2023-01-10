library ieee;
use ieee.std_logic_1164.all;

entity user_logic_phy_controller is
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
end entity user_logic_phy_controller;

architecture behavioral of user_logic_phy_controller is
	type phy_mgmt_fsm_type is (idle,requestsync);
	signal phy_mgmt_fsm : phy_mgmt_fsm_type := idle;
begin
-- concurrent signal assignments
	proc_sync : process (phy_mgmt_clk, phy_mgmt_clk_reset, phy_mgmt_waitrequest, phy_mgmt_fsm) is
	begin
		if (phy_mgmt_clk_reset = '1') then
			phy_mgmt_address <= "000000000";
			phy_mgmt_read <= '0';
			phy_mgmt_write <= '0';
			phy_mgmt_writedata <= x"00000000";
			phy_mgmt_fsm <= idle;
		elsif (phy_mgmt_waitrequest = '1') then -- This might be a problem, since the phy_mgmt_* values need to be constant during phy_mgmt_waitrequest=1
			phy_mgmt_address <= "000000000";
			phy_mgmt_read <= '0';
			phy_mgmt_write <= '0';
			phy_mgmt_writedata <= x"00000000";
			phy_mgmt_fsm <= idle;
		else
			case phy_mgmt_fsm is
				when idle =>
					phy_mgmt_address <= "000000000";
					phy_mgmt_read <= '0';
					phy_mgmt_write <= '0';
					phy_mgmt_writedata <= x"00000000";
					phy_mgmt_fsm <= requestsync;
				when requestsync =>
					phy_mgmt_address		<= "010000101"; -- 0x085
					phy_mgmt_read			<= '0';
					phy_mgmt_write			<= '1';
					phy_mgmt_writedata	<= x"00000001";
					phy_mgmt_fsm			<= requestsync;
			end case;
		end if;
	end process proc_sync;
end architecture behavioral;