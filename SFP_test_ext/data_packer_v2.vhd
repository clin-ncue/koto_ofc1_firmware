-- The orignal data_packer is not efficient: too many if-else
-- Switch to state-machine (case)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_packer_v2 is
  port (
    --The clock
    clock            : in  std_logic;
    --Asynchronous reset
    reset            : in  std_logic;
    --Interface to data_ram	
	 data_port_a_00   : in  std_logic_vector (15 downto 0);
	 data_port_b_00	: in  std_logic_vector (15 downto 0);
    dval_port_a_00   : in  std_logic;
	 dval_port_b_00	: in  std_logic;

	 data_port_a_01   : in  std_logic_vector (15 downto 0);
	 data_port_b_01	: in  std_logic_vector (15 downto 0);
    dval_port_a_01   : in  std_logic;
	 dval_port_b_01	: in  std_logic;

	 data_port_a_02   : in  std_logic_vector (15 downto 0);
	 data_port_b_02	: in  std_logic_vector (15 downto 0);
    dval_port_a_02   : in  std_logic;
	 dval_port_b_02	: in  std_logic;

	 data_port_a_03   : in  std_logic_vector (15 downto 0);
	 data_port_b_03	: in  std_logic_vector (15 downto 0);
    dval_port_a_03   : in  std_logic;
	 dval_port_b_03	: in  std_logic;
	 
	 data_port_a_04   : in  std_logic_vector (15 downto 0);
	 data_port_b_04	: in  std_logic_vector (15 downto 0);
    dval_port_a_04   : in  std_logic;
	 dval_port_b_04	: in  std_logic;

	 data_port_a_05   : in  std_logic_vector (15 downto 0);
	 data_port_b_05	: in  std_logic_vector (15 downto 0);
    dval_port_a_05   : in  std_logic;
	 dval_port_b_05	: in  std_logic;

	 data_port_a_06   : in  std_logic_vector (15 downto 0);
	 data_port_b_06	: in  std_logic_vector (15 downto 0);
    dval_port_a_06   : in  std_logic;
	 dval_port_b_06	: in  std_logic;

	 data_port_a_07   : in  std_logic_vector (15 downto 0);
	 data_port_b_07	: in  std_logic_vector (15 downto 0);
    dval_port_a_07   : in  std_logic;
	 dval_port_b_07	: in  std_logic;
	 
	 data_port_a_08   : in  std_logic_vector (15 downto 0);
	 data_port_b_08	: in  std_logic_vector (15 downto 0);
    dval_port_a_08   : in  std_logic;
	 dval_port_b_08	: in  std_logic;

	 data_port_a_09   : in  std_logic_vector (15 downto 0);
	 data_port_b_09	: in  std_logic_vector (15 downto 0);
    dval_port_a_09   : in  std_logic;
	 dval_port_b_09	: in  std_logic;

	 data_port_a_10   : in  std_logic_vector (15 downto 0);
	 data_port_b_10	: in  std_logic_vector (15 downto 0);
    dval_port_a_10   : in  std_logic;
	 dval_port_b_10	: in  std_logic;

	 data_port_a_11   : in  std_logic_vector (15 downto 0);
	 data_port_b_11	: in  std_logic_vector (15 downto 0);
    dval_port_a_11   : in  std_logic;
	 dval_port_b_11	: in  std_logic;
	 
	 data_port_a_12   : in  std_logic_vector (15 downto 0);
	 data_port_b_12	: in  std_logic_vector (15 downto 0);
    dval_port_a_12   : in  std_logic;
	 dval_port_b_12	: in  std_logic;

	 data_port_a_13   : in  std_logic_vector (15 downto 0);
	 data_port_b_13	: in  std_logic_vector (15 downto 0);
    dval_port_a_13   : in  std_logic;
	 dval_port_b_13	: in  std_logic;

	 data_port_a_14   : in  std_logic_vector (15 downto 0);
	 data_port_b_14	: in  std_logic_vector (15 downto 0);
    dval_port_a_14   : in  std_logic;
	 dval_port_b_14	: in  std_logic;

	 data_port_a_15   : in  std_logic_vector (15 downto 0);
	 data_port_b_15	: in  std_logic_vector (15 downto 0);
    dval_port_a_15   : in  std_logic;
	 dval_port_b_15	: in  std_logic;	 

	 start_read_pulse : in  std_logic_vector (15 downto 0);
	 
	 L1A              : in  std_logic_vector (13 downto 0);
	 data_out         : out std_logic_vector (31 downto 0) := (others => '0')
   );
	
end data_packer_v2;

architecture behaviour of data_packer_v2 is 
  
  
signal start_read_pulse_sig : std_logic_vector(15 downto 0) := (others => '0');
signal dval_port_a_15_pipe  : std_logic                     := '0';
type state_type is (  IDLE,  LAYER1_HEADER, 
							 ADC00, ADC01, ADC02, ADC03,
                      ADC04, ADC05, ADC06, ADC07,
							 ADC08, ADC09, ADC10, ADC11,
                      ADC12, ADC13, ADC14, ADC15,
							 LAYER1_FOOTER
                      );

signal next_state : state_type := IDLE;

begin

  start_read_pulse_sig    <= start_read_pulse;

  state_machine : process(reset, clock)
  begin
    if (reset = '1') then
	   next_state   <= IDLE;
		data_out <= (others => '0');	
	 --end if;	
    elsif rising_edge(clock) then
      case next_state is
        when IDLE =>
          data_out        <= (others => '0');	
			 --next_state      <= next_state;

          if(start_read_pulse_sig(0) = '1') then
            next_state    <= LAYER1_HEADER;
          else
            next_state    <= IDLE;
          end if;
			 
        when LAYER1_HEADER =>
          data_out        <= "001111" & X"000" & L1A;
			 next_state      <= ADC00;

        when ADC00 =>
          if(dval_port_a_00='1') then
            if(dval_port_b_00='1') then
	           data_out    <= data_port_a_00 & data_port_b_00;
	         else
		        data_out    <= data_port_a_00 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(1) = '1') then
            next_state    <= ADC01;
          else
            next_state    <= ADC00;
          end if; 
			 
        when ADC01 =>
          if(dval_port_a_01='1') then
            if(dval_port_b_01='1') then
	           data_out    <= data_port_a_01 & data_port_b_01;
	         else
		        data_out    <= data_port_a_01 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(2) = '1') then
            next_state    <= ADC02;
          else
            next_state    <= ADC01;
          end if; 			 
			 
        when ADC02 =>
          if(dval_port_a_02='1') then
            if(dval_port_b_02='1') then
	           data_out    <= data_port_a_02 & data_port_b_02;
	         else
		        data_out    <= data_port_a_02 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(3) = '1') then
            next_state    <= ADC03;
          else
            next_state    <= ADC02;
          end if; 
			 
        when ADC03 =>
          if(dval_port_a_03='1') then
            if(dval_port_b_03='1') then
	           data_out    <= data_port_a_03 & data_port_b_03;
	         else
		        data_out    <= data_port_a_03 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(4) = '1') then
            next_state    <= ADC04;
          else
            next_state    <= ADC03;
          end if; 

        when ADC04 =>
          if(dval_port_a_04='1') then
            if(dval_port_b_04='1') then
	           data_out    <= data_port_a_04 & data_port_b_04;
	         else
		        data_out    <= data_port_a_04 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(5) = '1') then
            next_state    <= ADC05;
          else
            next_state    <= ADC04;
          end if; 			 
			 
        when ADC05 =>
          if(dval_port_a_05='1') then
            if(dval_port_b_05='1') then
	           data_out    <= data_port_a_05 & data_port_b_05;
	         else
		        data_out    <= data_port_a_05 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(6) = '1') then
            next_state    <= ADC06;
          else
            next_state    <= ADC05;
          end if; 
			 
        when ADC06 =>
          if(dval_port_a_06='1') then
            if(dval_port_b_06='1') then
	           data_out    <= data_port_a_06 & data_port_b_06;
	         else
		        data_out    <= data_port_a_06 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(7) = '1') then
            next_state    <= ADC07;
          else
            next_state    <= ADC06;
          end if; 			 
			 			 
        when ADC07 =>
          if(dval_port_a_07='1') then
            if(dval_port_b_07='1') then
	           data_out    <= data_port_a_07 & data_port_b_07;
	         else
		        data_out    <= data_port_a_07 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(8) = '1') then
            next_state    <= ADC08;
          else
            next_state    <= ADC07;
          end if; 

        when ADC08 =>
          if(dval_port_a_08='1') then
            if(dval_port_b_08='1') then
	           data_out    <= data_port_a_08 & data_port_b_08;
	         else
		        data_out    <= data_port_a_08 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(9) = '1') then
            next_state    <= ADC09;
          else
            next_state    <= ADC08;
          end if; 			 
			 
        when ADC09 =>
          if(dval_port_a_09='1') then
            if(dval_port_b_09='1') then
	           data_out    <= data_port_a_09 & data_port_b_09;
	         else
		        data_out    <= data_port_a_09 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(10) = '1') then
            next_state    <= ADC10;
          else
            next_state    <= ADC09;
          end if; 
			 
        when ADC10 =>
          if(dval_port_a_10='1') then
            if(dval_port_b_10='1') then
	           data_out    <= data_port_a_10 & data_port_b_10;
	         else
		        data_out    <= data_port_a_10 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(11) = '1') then
            next_state    <= ADC11;
          else
            next_state    <= ADC10;
          end if; 			 	

        when ADC11 =>
          if(dval_port_a_11='1') then
            if(dval_port_b_11='1') then
	           data_out    <= data_port_a_11 & data_port_b_11;
	         else
		        data_out    <= data_port_a_11 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(12) = '1') then
            next_state    <= ADC12;
          else
            next_state    <= ADC11;
          end if; 
			 
        when ADC12 =>
          if(dval_port_a_12='1') then
            if(dval_port_b_12='1') then
	           data_out    <= data_port_a_12 & data_port_b_12;
	         else
		        data_out    <= data_port_a_12 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(13) = '1') then
            next_state    <= ADC13;
          else
            next_state    <= ADC12;
          end if; 				 

        when ADC13 =>
          if(dval_port_a_13='1') then
            if(dval_port_b_13='1') then
	           data_out    <= data_port_a_13 & data_port_b_13;
	         else
		        data_out    <= data_port_a_13 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(14) = '1') then
            next_state    <= ADC14;
          else
            next_state    <= ADC13;
          end if; 
			 
        when ADC14 =>
          if(dval_port_a_14='1') then
            if(dval_port_b_14='1') then
	           data_out    <= data_port_a_14 & data_port_b_14;
	         else
		        data_out    <= data_port_a_14 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;
			 
			 if (start_read_pulse_sig(15) = '1') then
            next_state    <= ADC15;
          else
            next_state    <= ADC14;
          end if; 

		  when ADC15 =>
          if(dval_port_a_15='1') then
            if(dval_port_b_15='1') then
	           data_out    <= data_port_a_15 & data_port_b_15;
	         else
		        data_out    <= data_port_a_15 & X"0000";
		      end if; 
          else 
			   data_out      <= (others => '0');	  
			 end if;

			 if(dval_port_a_15_pipe='1' and dval_port_a_15='0') then   -- falling edge means this event finishes
			   next_state    <= LAYER1_FOOTER;
			 else 
				next_state    <= ADC15;
			 end if;
			 
			 dval_port_a_15_pipe <= dval_port_a_15;
			 
			 when LAYER1_FOOTER =>
            data_out        <= "001001" & X"000000" & "00";
			   next_state      <= IDLE;
			 
       end case;

    end if;	 
  end process state_machine;

end architecture behaviour;