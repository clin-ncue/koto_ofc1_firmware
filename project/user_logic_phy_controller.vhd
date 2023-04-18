library ieee;
use ieee.std_logic_1164.all;
-- 
-- 20230416a     LTI      Made synchonous. 
-- 
-- 

entity user_logic_phy_controller is
  port (
    phy_mgmt_clk          : in  std_logic;
    phy_mgmt_clk_reset    : in  std_logic;
    phy_mgmt_address      : out std_logic_vector(8 downto 0);
    phy_mgmt_read         : out std_logic;
    phy_mgmt_readdata     : in  std_logic_vector(31 downto 0);
    phy_mgmt_waitrequest  : in  std_logic;
    phy_mgmt_write        : out std_logic;
    phy_mgmt_writedata    : out std_logic_vector(31 downto 0)
     );
end entity user_logic_phy_controller;

architecture rtl of user_logic_phy_controller is

    type phy_mgmt_fsm_type is (idle,requestsync,requestsync_done);
    signal phy_mgmt_fsm : phy_mgmt_fsm_type := idle;
    
    signal sync_reset_n_vec  : std_logic_vector(7 downto 0);
    
    
    
begin
-- concurrent signal assignments
    proc_sync : process (phy_mgmt_clk, phy_mgmt_clk_reset) is
    begin
       if (phy_mgmt_clk_reset = '1') then
           phy_mgmt_address   <= "000000000";
           phy_mgmt_read      <= '0';
           phy_mgmt_write     <= '0';
           phy_mgmt_writedata <= x"00000000";
           phy_mgmt_fsm       <= idle;
           
           sync_reset_n_vec   <= (others => '0');
           
       elsif phy_mgmt_clk'event and phy_mgmt_clk = '1' then
       
          sync_reset_n_vec   <= sync_reset_n_vec(sync_reset_n_vec'left-1 downto 0) & '1';
          
                 
                 
          if (sync_reset_n_vec(sync_reset_n_vec'left) = '0') then 
              phy_mgmt_address   <= "000000000";
              phy_mgmt_read      <= '0';
              phy_mgmt_write     <= '0';
              phy_mgmt_writedata <= x"00000000";
              phy_mgmt_fsm       <= idle;
                           
          else
              case phy_mgmt_fsm is
              
                  when idle =>
                      phy_mgmt_address   <= "010000101";
                      phy_mgmt_read      <= '0';
                      --phy_mgmt_write     <= '0';
                      phy_mgmt_writedata <= x"00000001";
                      
                      --if (phy_mgmt_waitrequest = '0') then
                      phy_mgmt_write  <= '1';
                      phy_mgmt_fsm    <= requestsync;
                      --end if;
                      
                  when requestsync =>
                      
                      if (phy_mgmt_waitrequest = '0') then       
                         phy_mgmt_write    <= '0';
                         phy_mgmt_fsm      <= requestsync_done;
                      end if;
                      
                  when requestsync_done =>
                  
                      phy_mgmt_fsm         <= requestsync_done;
     
              end case;
          end if;     
       end if;
       
       
    end process proc_sync;
    
end architecture rtl;