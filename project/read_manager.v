/* 
   read_manager
   C. Lin, chiehlin@uchicago.edu
		
	2023.03.17 updated version
	merge read_submit and read_control blocks
	use n_write and n_read to control ram read off.
*/

module read_manager
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
input wire [14 :0] MEMORY_DEPTH;
input wire [5  :0] MAX_NEVENT;
input wire [15 :0] input_ena;

// output
output reg         ren;
output reg [14 :0] raddr;
output reg [15 :0] n_write;
output reg [15 :0] n_read;
output reg         timeout;
output reg         buffer_full;
output reg [3  :0] read_input_id;

// 
reg        [14 :0] init_addr;
reg        [11 :0] cnt; 
reg        [15 :0] w_tag;                        

reg        [9 : 0] timeout_cnt;

////////////////////////////////////////////
always @(posedge clk) begin
	
	//
	// read logic
	//
	// if no timeout err & not reading & #write > #read, 
	// enable the reading from the RAM
	// when reading is done, n_read is incremented and init_addr is updated
	// for the next event.
	//
	if( timeout==1'b0 && ren == 1'b0 && n_write > n_read ) begin
      ren <= 1'b1;
		raddr <= init_addr;
		read_input_id <= 0;
		cnt <= 0;
   end	
	
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
	end
		
	
end

endmodule