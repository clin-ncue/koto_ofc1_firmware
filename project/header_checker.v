/* 
   header_checker
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.23
	Preliminary version.
	Evtno counts from 1, according to signal tag result.
	
	2022.11.02
	Update for the ADC firmware v2464 or above.
	- spill number length is extended to 10 bits.
	- event number length is extended to 16 bits.
	
*/

module header_checker
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  exp_spillno       ,
  pkg_evtno         ,
  pkg_spillno       ,
  get_package       ,
  
  // output
  evtno_err         ,
  spillno_err       ,
  in_counter  
);


input wire         clk;

// inputs
input wire         live_rising;
input wire [9  :0] exp_spillno;
input wire [15 :0] pkg_evtno;
input wire [9  :0] pkg_spillno;
input wire         get_package;

// output
output reg         evtno_err;
output reg         spillno_err;
output reg [15 :0] in_counter;

//
reg        [15: 0] exp_evtno;

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset
	if( live_rising == 1'b1 ) begin
	   evtno_err <= 1'b0;
		spillno_err <= 1'b0;
		exp_evtno <= 1;
		in_counter <= 0;
	end

   /// check consistency
	if( get_package == 1'b1 ) begin
	   evtno_err <= (pkg_evtno != exp_evtno) ? 1'b1 : 1'b0; 
		spillno_err <= (pkg_spillno != exp_spillno) ? 1'b1 : 1'b0;
	   exp_evtno <= exp_evtno + 1;
	   in_counter <= in_counter + 1;	
	end
	
end

endmodule