library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_split_v2 is
  port (
    --The clock
    clock           : in  std_logic;
    reset           : in  std_logic;
    wr_ena          : in  std_logic;
	 data_in         : in  std_logic_vector(15 downto 0);
	 -- the addr is 15 bit wide but we can't reach 7FFF because of the limit of Ram
	 -- If the mem is defined as ram[200:0] then the upper limit of addr should be 200
    mem_upper_lim   : in  std_logic_vector(14 downto 0);		 
    --Output data
    data_out        : out std_logic_vector(15 downto 0);
	 wr_ena_a        : out std_logic;
	 wr_ena_b        : out std_logic;
	 wr_addr_a       : out std_logic_vector(14 downto 0);
	 wr_addr_b       : out std_logic_vector(14 downto 0);
	 limit_a         : out std_logic_vector(9 downto 0);
	 limit_b         : out std_logic_vector(9 downto 0) 
    );
end data_split_v2;

architecture behavior of data_split_v2 is


  type   state_type is (Port_A,Port_B);
  signal mem_upper_lim_sig   : unsigned (14 downto 0) := (others => '0');   
  signal next_state          : state_type             := Port_A;
  

begin


  mem_upper_lim_sig <= unsigned(mem_upper_lim);

  state_machine : process(reset, clock)
    variable nstate          : state_type           := Port_A;
    variable counter_a       : unsigned(14 downto 0):= (others => '0');
    variable counter_b       : unsigned(14 downto 0):= (others => '0');   	 
    variable number_a        : unsigned(9 downto 0) := (others => '0');
    variable number_b        : unsigned(9 downto 0) := (others => '0');	 
	 --variable counter_a: integer    := 0;
	 --variable counter_b: integer    := 0;	 
  begin
    if (reset = '1') then
      next_state   <= Port_A;
		wr_ena_a     <= '0';
		wr_ena_b     <= '0';		
      data_out     <=(others => '0');
		wr_addr_a    <=(others => '0');
		wr_addr_b    <=(others => '0');	
	   counter_a    :=(others => '0');	
	   counter_b    :=(others => '0');	
	   number_a     :=(others => '0');	
	   number_b     :=(others => '0');			
    elsif rising_edge(clock) then
	   if(wr_ena='1') then
		  data_out <= data_in;
        case next_state is
        when Port_A =>
		    wr_ena_a     <= '1';
		    wr_ena_b     <= '0';		
			 
			 -- modified by Qisen on 2019/11/25/14:34
			 if(counter_a > mem_upper_lim_sig) then
			   counter_a    := (others => '0');	
				number_a     := number_a + 1;
			 end if;	               
		    wr_addr_a    <= std_logic_vector(counter_a);
			 -- Modified on 2019/11/24:11:18 pm			 
		    -- wr_addr_b    <= (others => '0');
			 --wr_addr_b    <= wr_addr_b;
			 next_state   <= Port_B;
			 counter_a    := counter_a+1;

			 
        when Port_B =>
		    wr_ena_a     <= '0';
		    wr_ena_b     <= '1';		
               
		    --wr_addr_a    <= (others => '0');
			 -- Modified on 2019/11/24:11:18 pm
			 --wr_addr_a    <= wr_addr_a;
			 
			 if(counter_b > mem_upper_lim_sig) then
			   counter_b    := (others => '0');	
				number_b     := number_b + 1;				
			 end if;			 
		    wr_addr_b    <= std_logic_vector(counter_b);
			 next_state   <= Port_A;
			 counter_b    := counter_b+1;	

			 
        end case;
      else
		  next_state <= Port_A;
		  wr_ena_a     <= '0';
		  wr_ena_b     <= '0';		
        data_out     <=(others => '0');
		  -- modified by Qisen on 2019/11/25: we need the wr_addr to calculate mem_usage
		  --wr_addr_a    <=(others => '0');
		  --wr_addr_b    <=(others => '0');			
	   end if;	
		
    end if;

	 limit_a <= std_logic_vector(number_a);
	 limit_b <= std_logic_vector(number_b);
  end process state_machine;



end architecture behavior;




