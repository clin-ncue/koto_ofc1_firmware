/* 
   read_control
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.13
	preliminary version
	
	2021.12.16
	In line with the updated memory depth, new logic is introduced.
*/

module read_control
#( parameter PACKAGE_LENGTH = 518,
   parameter MEMORY_DEPTH = 24576 )
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  read_start        ,
   
  // output
  input_id          ,
  ren               ,
  raddr             ,
  n_mem_queue       
);


input wire         clk;

// inputs
input wire         live_rising;
input wire         read_start;

// output
output reg [3  :0] input_id;
output reg         ren;
output reg [14 :0] raddr;
output reg [5  :0] n_mem_queue;

// 
reg        [14 :0] init_addr;
reg        [11 :0] cnt;                         

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( live_rising == 1'b1 ) begin
	   input_id <= 0;
		ren <= 1'b0;
		raddr <= 0;
		n_mem_queue <= 0;
		init_addr <= 0;
	end
		
	if( read_start == 1'b1 ) begin
	   n_mem_queue <= n_mem_queue + 1;
	end
	
	if( ren == 1'b0 && n_mem_queue > 0 ) begin
      ren <= 1'b1;
		raddr <= init_addr;
		input_id <= 0;
		cnt = 0;
   end	
	
	if( ren ==1'b1 ) begin
	   if( cnt < PACKAGE_LENGTH - 1 ) begin
		   raddr <= (raddr < MEMORY_DEPTH - 1 ) ? raddr + 1 : 0;
			cnt <= cnt + 1;
		end
		else if( input_id < 4'hF ) begin
		   cnt = 0;
		   raddr <= init_addr;
		   input_id <= input_id + 1;
		end
		else begin
		   ren <= 1'b0;
			n_mem_queue <= n_mem_queue - 1;
			init_addr <= (init_addr + PACKAGE_LENGTH) % MEMORY_DEPTH;
		end
	end
	
end

endmodule