/* 
   busy_control
   C. Lin, chiehlin@uchicago.edu
		
	2023.03.17 updated version
*/

module busy_control
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  MAX_NEVENT        ,
  trig              ,
  global_n_read     ,
   
  // output
  busy              ,
  read_overflow     ,
  n_trig 
);


input wire         clk;

// inputs
input wire         live_rising;
input wire [5  :0] MAX_NEVENT;
input wire         trig;
input wire [15 :0] global_n_read;

// output
output reg         busy;
output reg         read_overflow;
output reg [15 :0] n_trig;

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( live_rising == 1'b1 ) begin
      busy <=  1'b0;
		read_overflow <= 1'b0;
	    n_trig <= 0;
	end
		
	
	//
	// if #read > #trig, something is wrong, read_overflow is HIGH.
	//
	if( global_n_read > n_trig ) begin
	   read_overflow <= 1'b1;
	end
	
	// 
	// if (#trig - #read) = MAX_NEVENT - 1, busy is asserted
	// this is deassrted when #L1A - #read when two more events are digested.
   //	
	if( n_trig - global_n_read > MAX_NEVENT - 2 ) begin
      busy <= 1'b1;
   end
   else if( n_trig - global_n_read < MAX_NEVENT-2 ) begin
      busy <= 1'b0;
   end	
	
	
end

endmodule