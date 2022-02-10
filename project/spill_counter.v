/* 
   spill_counter
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.23
	Preliminary version.
*/

module spill_counter
(
// input 
  clk               , // system clock
  
  // inputs
  reset             ,
  live_rising       ,
  
  // output
  spillno
);


input wire         clk;

// inputs
input wire         reset;
input wire         live_rising;

// output
output reg [11 :0] spillno;

////////////////////////////////////////////
always @(posedge clk) begin

   /// system reset ///
	if( reset == 1'b1 ) begin
	   spillno <= 0;
	end

	/// spill number is incremented at LIVE rising edge
   if( live_rising == 1'b1 ) begin
	   spillno <= spillno + 1;
	end
	
end

endmodule