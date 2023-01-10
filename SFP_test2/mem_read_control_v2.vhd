library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- 2019/11/22
-- We seperate the special_dram into two true_ram
-- The data has been splitted into two parts and stored in ram_a and ram_b seperately
-- rd_a and rd_b are independent now
-- also add upper limit
-- ram[25000:0] so addr_a[14:0] should reset once reach 25000

entity mem_read_control_v2 is
  port (
    --The clock
    clock            : in  std_logic;
    --Asynchronous reset
    reset            : in  std_logic;
    --From control_center. A one-clock pulse to initiate reading of one adc_ram
	 start_read_pulse : in  std_logic;
    --Interface to es_ram	
    es_rd_req        : out std_logic;
    es_rd_addr       : out std_logic_vector(7 downto 0)   := (others => '0');
	 event_size			: in  std_logic_vector(10 downto 0);
    --# of clock cycles between rdreq going high and data_in being valid
    FIFO_in_dly      : in  std_logic_vector (3 downto 0)  := "0101";
    ram_upper_limit	: in  std_logic_vector(14 downto 0)  := (others => '0');	 
	 --Interface to data_ram. The memory is a 2-port ram so we need two rd_req and rd_addr
	 data_rd_req_a	   : out std_logic;
	 data_rd_addr_a	: out std_logic_vector(14 downto 0)  := (others => '0');
	 data_rd_req_b	   : out std_logic;
	 data_rd_addr_b	: out std_logic_vector(14 downto 0)  := (others => '0');
	 error				: out std_logic := '0'
    );
end mem_read_control_v2;

architecture behaviour of mem_read_control_v2 is 



  --signal event_size_sig  : std_logic_vector(12 downto 0);
  signal event_size_sig        : unsigned (10 downto 0);  
  --signal FIFO_in_dly_sig : std_logic_vector(3 downto 0);
  signal in_fifo_delay         : unsigned (3 downto 0)  := "0101"; 
  signal ram_upper_limit_sig   : unsigned (14 downto 0) := "110000110101000";  --25000
  --signal es_rd_addr_sig  : std_logic_vector(7 downto 0);
  type state_type is (IDLE, GET_SIZE, WAIT_SIZE, CALCULATE_ADDR,
							 GET_DATA--, DONE
                      );
							 
  signal next_state : state_type := IDLE;
  
begin  -- architecture behaviour
  
  event_size_sig      <= unsigned(event_size);
  in_fifo_delay       <= unsigned(FIFO_in_dly);
  ram_upper_limit_sig <= unsigned(ram_upper_limit);
  --es_rd_addr      <= es_rd_addr_sig;
  
  state_machine : process(reset, clock)
    variable nstate           : state_type           := IDLE; 
	 variable mod2             : integer              := 0;
    variable delay_counter    : integer              := 0;
	 variable addr_counter     : integer              := 0;
	 variable es_rd_addr_sig   : unsigned(7 downto 0) := (others => '0');
	 variable half_size        : integer              := 0;
	 -- addr control for port a in the dual_port_ram
	 variable a_addr           : unsigned(14 downto 0):= (others => '0');
	 -- addr control for port b in the dual_port_ram
	 variable b_addr           : unsigned(14 downto 0):= (others => '0');
	 
  begin
    if (reset = '1') then
	   -- interface
      next_state        <= IDLE;
      es_rd_addr        <= (others => '0');
		data_rd_addr_a    <= (others => '0');
		data_rd_addr_a		<= (others => '0');
      es_rd_req         <= '0';
      data_rd_req_a     <= '0';
		data_rd_req_b     <= '0';
		-- internal logic
		mod2              := 0;
		delay_counter     := 0;
		addr_counter      := 0;
		a_addr            := (others => '0');
		b_addr            := (others => '0');
		es_rd_addr_sig		:= (others => '0');
		
    elsif rising_edge(clock) then
      case next_state is
		  when IDLE =>
			 next_state        <= IDLE;
          es_rd_req         <= '0';
          data_rd_req_a     <= '0';
		    data_rd_req_b     <= '0';
			 delay_counter     := 0;
			 addr_counter      := 0;
			 mod2              := 0;			 
			 if (start_read_pulse = '1') then
            next_state      <= GET_SIZE;
          else
            next_state      <= IDLE;
          end if;
  
        when GET_SIZE =>
			 es_rd_addr_sig    := es_rd_addr_sig+1;
			 es_rd_addr        <= std_logic_vector (es_rd_addr_sig);
          es_rd_req         <= '1';
			 next_state        <= WAIT_SIZE;  

        when WAIT_SIZE =>
		    es_rd_req         <= '0';
			 delay_counter     := delay_counter+1;	
          if (delay_counter >= to_integer(in_fifo_delay)) then
            next_state      <= CALCULATE_ADDR;
          end if;			
			
        when CALCULATE_ADDR =>
		    mod2              := to_integer(event_size_sig) MOD 2;
			 half_size         := to_integer(event_size_sig)/2;
			 next_state        <= GET_DATA;

        when GET_DATA =>	    
		    if(addr_counter<half_size) then
			   data_rd_req_a   <= '1';
				data_rd_req_b	 <= '1';			
		      data_rd_addr_a  <= std_logic_vector (a_addr);
		      data_rd_addr_b  <= std_logic_vector (b_addr);
				a_addr          := a_addr+1;
				b_addr          := b_addr+1;
			   if(a_addr>ram_upper_limit_sig) then
				  a_addr        := (others => '0');
				end if;
			   if(b_addr>ram_upper_limit_sig) then
				  b_addr        := (others => '0');
				end if;				
				addr_counter    := addr_counter+1;
		    elsif(addr_counter=half_size and mod2 = 1 ) then
				--if(mod2 = 1) then
				data_rd_req_a   <= '1'; 
				data_rd_addr_a  <= std_logic_vector (a_addr);
				a_addr          := a_addr+1;    -- now increment by 1 not 2
			   if(a_addr>ram_upper_limit_sig) then
				  a_addr        := (others => '0');
				end if;				
				data_rd_req_b   <= '0'; 
				data_rd_addr_b  <= (others => '0');	
				addr_counter    := addr_counter+1;
			 else  				
			   next_state      <= IDLE;
				addr_counter    := 0;
				data_rd_req_a   <= '0';
				data_rd_req_b	 <= '0';   
				data_rd_addr_a  <= (others => '0');
				data_rd_addr_b  <= (others => '0');				
			 end if;	
--		  when DONE =>
--			   data_rd_req_a   <= '0';
--				data_rd_req_b	 <= '0';   
--				data_rd_addr_a  <= (others => '0');
--				data_rd_addr_b  <= (others => '0');
--				next_state      <= IDLE;
 
      end case;
    end if;

  end process state_machine;  
  
  error_detect : process(reset, clock) 
  begin
    if (reset = '1') then		
		error     <= '0';
    elsif rising_edge(clock) then
	   if(start_read_pulse='1' and next_state /= IDLE) then
		  error   <= '1';
		end if;
    end if;		
		
  end process error_detect;
  
end architecture behaviour;



