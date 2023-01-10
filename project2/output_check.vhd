library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity output_check is
  port (
    --The clock
    clock               : in  std_logic;
    --Asynchronous reset
    reset               : in  std_logic;
    LIVE                : in  std_logic;	 
	 data_in		   	   : in  std_logic_vector(31 downto 0);
	  

    packet_number       : out std_logic_vector(15 downto 0) := (others => '0');
	 error               : out std_logic                     := '0'	; 
    Current_L1A         : out std_logic_vector(13 downto 0) := (others => '0')
	 
    );
end output_check;

architecture behaviour of output_check is 

  type state_type is (layer1_header, adc_header, adc_energy, adc_footer, layer1_footer
                      );
							 
  signal next_state   : state_type := layer1_header;
  --signal event_in_progress_sig  : std_logic;
  --signal L1A_sig    : unsigned(13 downto 0) := (others => '0');

begin

  state_machine : process(reset, clock)
  
    variable nstate                 : state_type                    := layer1_header; 

	 
	 --variable event_in_progress_sig  : std_logic;
	 
    variable cnt_adc_header         : integer                       := 0;
    variable cnt_adc_footer         : integer                       := 0;	 
    variable cnt_adc_packet         : integer                       := 0;	 	 
 
    variable packet_number_sig      : unsigned(15 downto 0)         := (others => '0');	 
    variable L1A_sig                : unsigned(13 downto 0)         := (others => '0');
	 
	 begin
    if (reset = '1') then
	   -- interface
      packet_number        <= (others => '0');	
		packet_number_sig    := (others => '0'); 
		--error             <= (others => '0');	

		
		-- internal logic
      next_state            <= layer1_header;				
      cnt_adc_header        := 0;
      cnt_adc_footer        := 0;
		cnt_adc_packet        := 0;
		
		L1A_sig               := to_unsigned(1, L1A_sig'length);
		
    elsif rising_edge(clock) then
	 
	   --data_pipe           <= data_in;

		--data_out            <= data_in;
		
      case next_state is
		
		  when layer1_header =>
	  
		    if( data_in(31 downto 26) = "001111" ) then			
			   next_state            <= adc_header;				
			 end if;	

		  when adc_header =>		
		  
	       if( data_in(31 downto 30) = "11" and data_in(15 downto 14) = "11" ) then
			
				cnt_adc_header       := cnt_adc_header + 1;
				if(cnt_adc_header = 3) then
				  next_state         <= adc_energy;		
--data_in[13:0] == current_L1A
              if( data_in(13 downto 0) = std_logic_vector(L1A_sig) ) then
                L1A_sig          := L1A_sig + 1;
				  end if; 
				end if;
			 end if;		  
			 
		  when adc_energy =>			 
		  --EF	
		    if( data_in(31 downto 30) = "10" and data_in(15 downto 12) = "0110" ) then
				next_state           <= adc_footer;	
		  --FF		
		    elsif( data_in(31 downto 28) = "0110" and data_in(15 downto 12) = "0110" ) then
			   cnt_adc_footer       := 1;	
				next_state           <= adc_footer;	
				
		    end if;		
				
		  when adc_footer =>		
 		  
			 if(  data_in(31 downto 28) = "0110" and ( data_in(15 downto 12) = "0110" or data_in(15 downto 0) = X"0000" ) )then
				cnt_adc_footer       := cnt_adc_footer + 1;			
			 end if;
	  
	       if(cnt_adc_footer = 3) then
			   cnt_adc_packet       := cnt_adc_packet + 1;
				-- receive packets from one crate = 16 adc 
				if(cnt_adc_packet = 16) then 
				  next_state         <= layer1_footer;	  
				else
				  next_state         <= adc_header;	
				  cnt_adc_header     := 0;
				  cnt_adc_footer     := 0;				  
				end if;
			 end if;
			 
		  when layer1_footer =>
		  
			 if(  data_in(31 downto 26) = "001001" ) then
				cnt_adc_header       := 0;
				cnt_adc_footer       := 0;
				cnt_adc_packet       := 0;				
			   next_state           <= layer1_header;	
				
				if(LIVE = '1') then
				  packet_number_sig  := packet_number_sig + 1;
				end if;  
				
		    end if;

      end case;
		

	 packet_number <= std_logic_vector (packet_number_sig);
    Current_L1A	<= std_logic_vector (L1A_sig); 
    end if;

  end process state_machine;  			 
			 
			 
  error_detect : process(reset, clock) 
  begin
	 if( reset = '1') then
      error         <= '0';		 
    elsif rising_edge(clock) then
	 
	   if( data_in(31 downto 26) = "001111" ) then
		  if( next_state /= layer1_header ) then
		    error     <= '1';
		  end if;	 
		end if;
    end if;
		
  end process error_detect;			 

			 
end architecture behaviour;




