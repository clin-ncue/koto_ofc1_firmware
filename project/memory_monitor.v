/* 
   memory_monitor
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.30
	preliminary version
	
	2022.03.23
	Change to blocking method. 
	If w_complte and r_submit happen at the same time, 
	the non-blocking method will cause error.
	
	2022.03.24
	Introduce two threhsolds to stop (>45) / continue (<45) collecting data.
	
	2022.11.04
	Introduce MAX_NEVENT instead of parameter.
	
*/

module memory_monitor
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  trig_accepted     ,
  read_complete     ,
  MAX_NEVENT        ,
   
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
input wire [5  :0] MAX_NEVENT;

// output
output reg         read_overflow;
output reg [5  :0] n_pileup;
output reg         stop;

// 
                       

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( live_rising == 1'b1 ) begin
	   n_pileup = 0;
		stop = 1'b0;
		read_overflow = 1'b0;
	end
	
   if( trig_accepted == 1'b1 ) begin
	   n_pileup = n_pileup + 1;
	end
	
	if( read_complete == 1'b1 ) begin
	   n_pileup = n_pileup - 1;
	end
	
	/// if #read > #trig, the npileup becomes negative.
   /// OFC-I might not be able to obtain "L1A" correctly. 
	if( n_pileup > MAX_NEVENT ) begin
	   read_overflow = 1'b1;
	end
	
	if( n_pileup > MAX_NEVENT-2 ) begin
	   stop = 1'b1;
	end
	else if( n_pileup < MAX_NEVENT-2 ) begin
	   stop = 1'b0;
	end
	   
end

endmodule