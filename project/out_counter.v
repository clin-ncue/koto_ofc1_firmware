/* 
  
*/

// LOCK_TIME: The required time not listening to "ena" after ena is asserted.
//            Because "ena" is driven by the ADC header, and an event consists
//            of 16 ADC packages. The LOCK_TIME should be longer than 15 half 
//            ADC packages length and less or equal to the total output length.
//            (total length = 8256 words)                
//

module out_counter
#(
   parameter LOCK_TIME=8250
)
(
// input 
  clk               , // system clock
  
  // inputs
  reset             ,
  ena               ,
   
  // output
  out_cnt            
);


input wire         clk;

// inputs
input wire         reset;
input wire         ena;

// output
output reg [15 :0] out_cnt;

//
reg [14 :0] lock_cnt;
reg         lock;

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( reset == 1'b1 ) begin
	   out_cnt <= 0;
		lock <= 1'b0;
		lock_cnt <= 0;
	end
	
	if( lock==1'b0 && ena == 1'b1 ) begin
	   out_cnt <= out_cnt + 1;
		lock <= 1'b1;
	end
	
	// when lock_cnt reaches LOCK_TIME,
	// unlock the "ena" and reset lock_cnt.
	//
	if( lock_cnt==LOCK_TIME ) begin
	   lock <= 1'b0;
	   lock_cnt <= 0;	
	end
	
	// when locked, lock_cnt is incremented as the elapsed time.
	if( lock <= 1'b1 ) begin
	   lock_cnt <= lock_cnt + 1;
	end
	
end

endmodule