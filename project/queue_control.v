/* 
   queue_control
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.20
	
	2022.03.23
	Change to blocking method. If w_complte and r_submit happen at the same time. 
	The non-blocking method will cause error.
*/

module queue_control
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  w_complete        ,
  r_submit          ,
   
  // output
  r_request         ,
  nqueue    
);


input wire         clk;

// inputs
input wire         live_rising;
input wire         w_complete;
input wire         r_submit;

// output
output reg         r_request;
output reg [5  :0] nqueue; 

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( live_rising == 1'b1 ) begin
	   nqueue = 0;
		r_request = 1'b0;
	end
	
   /// when write complete is received, nqueue is incremented
	if( w_complete == 1'b1 ) begin
	   nqueue = nqueue + 1;
	end
	
	/// if a reading request submits to read control, nqueue - 1
	if( r_submit == 1'b1 ) begin
	   nqueue = nqueue - 1;
	end
	
	/// when an event is saved in queue, always request read out.
	r_request = ( nqueue > 0 ) ? 1'b1 : 1'b0;
	
end

endmodule