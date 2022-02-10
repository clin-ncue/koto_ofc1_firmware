/* 
   header_checker
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.23
	Preliminary version.
	Evtno counts from 1, according to signal tag result.
	
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
  spillno_err            
);


input wire         clk;

// inputs
input wire         live_rising;
input wire [11 :0] exp_spillno;
input wire [13 :0] pkg_evtno;
input wire [8  :0] pkg_spillno;
input wire         get_package;

// output
output reg         evtno_err;
output reg         spillno_err;

//
reg        [13: 0] exp_evtno;

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset
	if( live_rising == 1'b1 ) begin
	   evtno_err <= 1'b0;
		spillno_err <= 1'b0;
		exp_evtno <= 1;
	end

   /// check consistency
	if( get_package == 1'b1 ) begin
	   evtno_err <= (pkg_evtno != exp_evtno) ? 1'b1 : 1'b0; 
		spillno_err <= (pkg_spillno != exp_spillno) ? 1'b1 : 1'b0;
	   exp_evtno <= exp_evtno + 1;	
	end
	
end

endmodule