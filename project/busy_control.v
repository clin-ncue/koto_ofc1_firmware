/* 
   busy_control
   C. Lin, chiehlin@uchicago.edu
		
	2023.03.17 updated version
	
	2024.01.04 (v1.01.01) 
	- update the bus width for two-OFC-II system.
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
input wire [4  :0] MAX_NEVENT;
input wire         trig;
input wire [15 :0] global_n_read;

// output
output reg         busy;
output reg         read_overflow;
output reg [15 :0] n_trig;

////////////////////////////////////////////
always @(posedge clk) begin
	
	//
	// n_trig is driven by trig.
	//
	if( trig==1'b1 ) begin
	   n_trig <= n_trig + 1;
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
	
	
   ///
   /// reset 
	/// put in the bottom to ensure the reset
	///
   if( live_rising == 1'b1 ) begin
      busy <=  1'b0;
		read_overflow <= 1'b0;
	   n_trig <= 0;
	end
	
end

endmodule