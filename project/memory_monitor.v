/* 
   memory_monitor
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.30
	preliminary version
	
*/

module memory_monitor
#( parameter MAX_NEVENT = 46 )
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  trig_accepted     ,
  read_complete     ,
   
  // output
  read_overflow     ,
  n_pileup          ,
  stop              
);


input wire         clk;

// inputs
input wire         live_rising;
input wire         trig_accepted;
input wire         read_complete;

// output
output reg         read_overflow;
output reg [5  :0] n_pileup;
output reg         stop;

// 
                       

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( live_rising == 1'b1 ) begin
	   n_pileup <= 0;
		stop <= 1'b0;
		read_overflow <= 1'b0;
	end
	
   if( trig_accepted == 1'b1 ) begin
	   n_pileup <= n_pileup + 1;
	end
	
	if( read_complete == 1'b1 ) begin
	   n_pileup <= n_pileup - 1;
	end
	
	/// if #read > #trig, the npileup becomes negative.
   /// OFC-I might not be able to obtain "L1A" correctly. 
	if( n_pileup == 6'h3F ) begin
	   read_overflow <= 1'b1;
	end
	
	stop <= ( n_pileup >= MAX_NEVENT ) ? 1'b1 : 1'b0;
	   
end

endmodule