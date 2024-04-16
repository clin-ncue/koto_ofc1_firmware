/* 
   read_manager_v2
   C. Lin, chiehlin@uchicago.edu
	
   This module assigns the input ID and the reading address of the even/odd RAM.
	
	-------------------------------------------------------	
		
	2023.03.17 updated version
	merge read_submit and read_control blocks
	use n_write and n_read to control ram read off.
	
	2024.01.04 (v1.01.01)
	Update the bus widths to fit the two-OFC-II system design.
	
	2024.04.14 (v1.01.12)
	Introduce the snooze logic to the piled events.
	(To deal with the OFC-II flapping issue.)
	
*/

module read_manager_v2
#( parameter MAX_WAITING_TIME = 1000 )
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  HALF_PACKAGE_LENGTH    ,
  MEMORY_DEPTH      ,
  MAX_NEVENT        ,
  input_ena         ,
  w_complete        ,
  snooze_threshold  ,
   
  // output
  raddr             ,
  ren               ,
  n_write           ,
  n_read            ,
  timeout           ,
  buffer_full       ,
  read_input_id          
);


input wire         clk;

// inputs
input wire         live_rising;
input wire [15 :0] w_complete;
input wire [9  :0] HALF_PACKAGE_LENGTH;
input wire [13 :0] MEMORY_DEPTH;
input wire [4  :0] MAX_NEVENT;
input wire [15 :0] input_ena;
input wire [15 :0] snooze_threshold;

// output
output reg         ren;
output reg [13 :0] raddr;
output reg [15 :0] n_write;
output reg [15 :0] n_read;
output reg         timeout;
output reg         buffer_full;
output reg [3  :0] read_input_id;

// 
reg        [13 :0] init_addr;
reg        [11 :0] cnt; 
reg        [15 :0] w_tag;                        

reg        [9 : 0] timeout_cnt;
reg        [15: 0] snooze_cnt;

////////////////////////////////////////////
always @(posedge clk) begin
	
	//
	// snooze counter
	//
	snooze_cnt <= ( snooze_cnt<16'hFFFF ) ? (snooze_cnt + 1) : snooze_cnt;
	
	//
	// read logic
	//
	// if no timeout err & not reading & #write > #read, 
	// enable the reading from the RAM
	// when reading is done, n_read is incremented and init_addr is updated
	// for the next event.
	//
	// 2024.04.14 
	// - Add snooze requirement.
	// 
	//
	if( timeout==1'b0 && ren == 1'b0 && n_write > n_read && snooze_cnt >= snooze_threshold ) begin
      ren <= 1'b1;
		raddr <= init_addr;
		read_input_id <= 0;
		cnt <= 0;
   end	
	
	//
	// 2024.04.14
	// Reset snooze counter when the reading is completed.
	//
	
	if( ren ==1'b1 ) begin
	   if( cnt < HALF_PACKAGE_LENGTH - 1 ) begin
		   raddr <= (raddr < MEMORY_DEPTH - 1 ) ? raddr + 1 : 0;
			cnt <= cnt + 1;
		end
		else if( read_input_id < 4'hF ) begin
		   cnt <= 0;
		   raddr <= init_addr;
		   read_input_id <= read_input_id + 1;
		end
		else begin
		   ren <= 1'b0;
			n_read <= n_read + 1;
			init_addr <= (init_addr + HALF_PACKAGE_LENGTH) % MEMORY_DEPTH;
			
			snooze_cnt <= 0;
		end
	end
	
	// n_write counter logic
	// w_tag is the tag representing which input finishes writing.
	// when receiving w_complete from all enabled channel, n_write
	// is incremented. 
	//
	// When it happens, w_tag is also reset for the next coming event.
	//	
	//
   if( (w_complete | w_tag) == input_ena ) begin
	   n_write <= n_write + 1;
	   w_tag <= 0;
	end 
	else begin
	   w_tag <= (w_complete | w_tag);
	end
	
	// time out error
	// If w_tag is non-zero for more than 1000 clocks, time out eror shows
	//
	if( w_tag > 0 ) begin
	   timeout_cnt <= timeout_cnt + 1;   
	end
	else begin
	   timeout_cnt <= 0;
	end
	
	if( timeout_cnt > MAX_WAITING_TIME ) begin
	   timeout <= 1'b1;
	end
	
	// memory full
	// #events written in queue should be less than the RAM depth.
	//                                                 (MAX_NEVENT)
	// if it somehow happens, this memory_full error is raised.
	//
	if( n_write > n_read + MAX_NEVENT ) begin
	   buffer_full <= 1'b1;
	end
	
	///
   /// reset 
	/// put in the bottom to ensure the reset
	///
   if( live_rising == 1'b1 ) begin
	   read_input_id <= 0;
		ren <= 1'b0;
		raddr <= 0;
		n_write <= 0;
		n_read <= 0;
		timeout <= 1'b0;
		buffer_full <= 1'b0;
		init_addr <= 0;
		w_tag <= 0;
		cnt <= 0;
		timeout_cnt <= 0;
		snooze_cnt <= 16'hFFFF;
	end
		
	
end

endmodule