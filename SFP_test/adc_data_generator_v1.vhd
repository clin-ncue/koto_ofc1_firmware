library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_data_generator_v1 is
  port (
    --The clock
    clock           : in  std_logic;
    reset           : in  std_logic;
    trigger         : in  std_logic;
	 -- A counter of trigger. This is be the L1A number for each event
	 --L1A             : in  std_logic_vector(13 downto 0);
	 -- size of energy words
	 -- arithmetic progression to realize the varying size
	 intial_term     : in  std_logic_vector(10 downto 0);
	 common_diff     : in  std_logic_vector(6 downto 0);
	 number_term     : in  std_logic_vector(6 downto 0);
    --Output data	 
    ff_tx_data      : out std_logic_vector(15 downto 0);
	 error           : out std_logic;
	 --L1A_initial     : in  std_logic_vector(13 downto 0)
	 tx_number       : out std_logic_vector(15 downto 0)
    );
end adc_data_generator_v1;

architecture behavior of adc_data_generator_v1 is

  subtype word is std_logic_vector(31 downto 0);
  type state_type is (IDLE, CALCULATION, HEADER, ENERGY, FOOTER
                      );
  signal next_state         : state_type := IDLE;
  signal L1A_initial_sig    : unsigned(13 downto 0) := (others => '0');

  signal intial_term_sig    : unsigned(10 downto 0) := (others => '0');
  signal common_diff_sig    : unsigned(6 downto 0) := (others => '0');
  signal number_term_sig    : unsigned(6 downto 0) := (others => '0');
  
  --signal tx_number_sig      : unsigned(15 downto 0) := (others => '0');  
begin

  --L1A_sig <= L1A;
  intial_term_sig        <= unsigned(intial_term);
  common_diff_sig        <= unsigned(common_diff);
  number_term_sig        <= unsigned(number_term);  
  --L1A_initial_sig <= unsigned(L1A_initial); 
  
  state_machine : process(reset, clock)
    variable nstate   : state_type           := IDLE;
	 variable counter  : integer              := 0;
	 variable L1A_sig  : unsigned(13 downto 0):= (others => '0');
	 variable tx_num   : unsigned(15 downto 0):= (others => '0');
	 variable size     : unsigned(10 downto 0):= (others => '0');
	 variable term_cnt : integer              := 0;
	 
  begin
    if (reset = '1') then
      next_state              <= IDLE;
      ff_tx_data              <= (others => '0');
		L1A_sig                 := (others => '0');
		counter                 := 0;
		tx_num                  := (others => '0');
	   size                    := intial_term_sig;
		term_cnt                := 0;
		
    elsif rising_edge(clock) then
	 
      case next_state is
        when IDLE =>
          ff_tx_data          <=(others => '0');
          if (trigger = '1') then
            next_state        <= CALCULATION;
				L1A_sig           := L1A_sig + 1;
				tx_num            := tx_num  + 1;
          else
            next_state        <= IDLE;
          end if;

		  when CALCULATION =>
          next_state          <=HEADER;
			 if(term_cnt >= number_term_sig) then
			   size              := intial_term_sig;
				term_cnt          := 0;
			 end if;				 
			 size                := size + common_diff_sig;  
			 term_cnt            := term_cnt + 1;

		
        when HEADER =>
		    if(counter /= 5) then
            ff_tx_data        <= X"FFFF";
			   next_state        <= HEADER;
			   counter           := counter + 1;				
			 else
			   ff_tx_data        <= "11" & std_logic_vector(L1A_sig);
				next_state        <= ENERGY;
				counter           := 0;
			 end if;  

		  when ENERGY =>
		    ff_tx_data          <= "10" & std_logic_vector(to_unsigned(counter, ff_tx_data'length-2));
			 counter             := counter + 1;
			 if(counter = to_integer(size)) then
			   next_state        <= FOOTER;
				counter           := 0;
			 else
			   next_state        <= ENERGY;  
		  	 end if;
			 
		  when FOOTER =>	 
		    if(counter /= 6) then
            ff_tx_data        <= X"6FFF";
			   next_state        <= FOOTER;
			   counter           := counter + 1;				
			 else
			   ff_tx_data        <= (others => '0');
				next_state        <= IDLE;
				counter           := 0;
			 end if;  			 
			 
			 
			 
			 
--          if (trigger = '1') then
--            next_state <= HEADER;
--          else
--            next_state <= IDLE;
--          end if;
--     
        
      end case;
      --state <= next_state;
		tx_number               <= std_logic_vector(tx_num);
		
    end if;

  end process state_machine;

  error_detect : process(reset, clock)

  begin
    if (reset = '1') then
		error                   <= '0';
    elsif rising_edge(clock) then
	   if(trigger = '1') then
		  if( next_state /= IDLE ) then
		    error               <= '1';
		  end if;
		end if;
    end if;		
		   
  end process error_detect;
  
  
end architecture behavior;




