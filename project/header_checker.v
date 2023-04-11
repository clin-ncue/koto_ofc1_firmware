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
  in_counter        ,
  r_evtno           ,
  r_expevtno        ,
  r_spillno   
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
output reg [15 :0] r_evtno;
output reg [15 :0] r_expevtno;
output reg [ 9 :0] r_spillno;


//
reg        [15: 0] exp_evtno;
reg                lock_evtno;
reg                lock_spillno;

////////////////////////////////////////////
always @(posedge clk) begin

   
   ///
	/// lock the event number and spill number read from the header.
	/// can only unlock by live reset
   ///	
	if( lock_evtno == 1'b0 && evtno_err ==1'b1 ) begin
	   r_evtno <= pkg_evtno;
		r_expevtno <= exp_evtno;
		lock_evtno <= 1'b1;
	end
	
	if( lock_spillno == 1'b0 && spillno_err == 1'b1 ) begin
	   r_spillno <= pkg_spillno;
		lock_spillno <= 1'b1;
	end
	
   /// check consistency
	if( get_package == 1'b1 ) begin
	   evtno_err <= (pkg_evtno != exp_evtno) ? 1'b1 : 1'b0; 
		spillno_err <= (pkg_spillno != exp_spillno) ? 1'b1 : 1'b0;
	   exp_evtno <= exp_evtno + 1;
	   in_counter <= in_counter + 1;	
	end
	
	/// reset
	if( live_rising == 1'b1 ) begin
	   evtno_err <= 1'b0;
		spillno_err <= 1'b0;
		exp_evtno <= 1;
		in_counter <= 0;
		lock_evtno <= 1'b0;
		lock_spillno <= 1'b0;
		r_evtno <= 0;
		r_expevtno <= 0;
		r_spillno <= 0;
	end
	
end

endmodule