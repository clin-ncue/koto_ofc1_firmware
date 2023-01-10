library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_packer is
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

	 data_out         : out std_logic_vector (31 downto 0) := (others => '0')
   );
	
end data_packer;

architecture behaviour of data_packer is 

begin

  state_machine : process(reset, clock)
  begin
    if (reset = '1') then
		data_out <= (others => '0');	
	 --end if;	
    elsif rising_edge(clock) then
      if(dval_port_a_00='1') then
        if(dval_port_b_00='1') then
	       data_out <= data_port_a_00 & data_port_b_00;
	     else
		    data_out <= data_port_a_00 & X"0000";
		  end if;
		  
      elsif(dval_port_a_01='1') then
        if(dval_port_b_01='1') then
	       data_out <= data_port_a_01 & data_port_b_01;
	     else
		    data_out <= data_port_a_01 & X"0000";	
		  end if;
		
      elsif(dval_port_a_02='1') then
        if(dval_port_b_02='1') then
	       data_out <= data_port_a_02 & data_port_b_02;
	     else
		    data_out <= data_port_a_02 & X"0000";
		  end if;
		
      elsif(dval_port_a_03='1') then
        if(dval_port_b_03='1') then
	       data_out <= data_port_a_03 & data_port_b_03;
	     else
		    data_out <= data_port_a_03 & X"0000";
		  end if;

      elsif(dval_port_a_04='1') then
        if(dval_port_b_04='1') then
	       data_out <= data_port_a_04 & data_port_b_04;
	     else
		    data_out <= data_port_a_04 & X"0000";
		  end if;
		
      elsif(dval_port_a_05='1') then
        if(dval_port_b_05='1') then
	       data_out <= data_port_a_05 & data_port_b_05;
	     else
		    data_out <= data_port_a_05 & X"0000";
		  end if;		  

      elsif(dval_port_a_06='1') then
        if(dval_port_b_06='1') then
	       data_out <= data_port_a_06 & data_port_b_06;
	     else
		    data_out <= data_port_a_06 & X"0000";
		  end if;
		
      elsif(dval_port_a_07='1') then
        if(dval_port_b_07='1') then
	       data_out <= data_port_a_07 & data_port_b_07;
	     else
		    data_out <= data_port_a_07 & X"0000";
		  end if;		  

      elsif(dval_port_a_08='1') then
        if(dval_port_b_08='1') then
	       data_out <= data_port_a_08 & data_port_b_08;
	     else
		    data_out <= data_port_a_08 & X"0000";
		  end if;
		
      elsif(dval_port_a_09='1') then
        if(dval_port_b_09='1') then
	       data_out <= data_port_a_09 & data_port_b_09;
	     else
		    data_out <= data_port_a_09 & X"0000";
		  end if;		  

      elsif(dval_port_a_10='1') then
        if(dval_port_b_10='1') then
	       data_out <= data_port_a_10 & data_port_b_10;
	     else
		    data_out <= data_port_a_10 & X"0000";
		  end if;
		
      elsif(dval_port_a_11='1') then
        if(dval_port_b_11='1') then
	       data_out <= data_port_a_11 & data_port_b_11;
	     else
		    data_out <= data_port_a_11 & X"0000";
		  end if;				  		  
		  
      elsif(dval_port_a_12='1') then
        if(dval_port_b_12='1') then
	       data_out <= data_port_a_12 & data_port_b_12;
	     else
		    data_out <= data_port_a_12 & X"0000";
		  end if;
		
      elsif(dval_port_a_13='1') then
        if(dval_port_b_13='1') then
	       data_out <= data_port_a_13 & data_port_b_13;
	     else
		    data_out <= data_port_a_13 & X"0000";
		  end if;		  

      elsif(dval_port_a_14='1') then
        if(dval_port_b_14='1') then
	       data_out <= data_port_a_14 & data_port_b_14;
	     else
		    data_out <= data_port_a_14 & X"0000";
		  end if;
		
      elsif(dval_port_a_15='1') then
        if(dval_port_b_15='1') then
	       data_out <= data_port_a_15 & data_port_b_15;
	     else
		    data_out <= data_port_a_15 & X"0000";
		  end if;			  
      else
        data_out <= (others => '0');	
	   end if;
    end if;	 
  end process state_machine;

end architecture behaviour;