/* 
   error_coder
   C. Lin, chiehlin@uchicago.edu
	
	2022.01.03
	Three levels of errors:
	         |  Priority  | types
   -----------------------------------------------------				
	- ERROR  | 1st	       | pending, spill no, event no
	- STOP   | 2nd        | memory almost full
	- WARNING| 3rd        | energy word error
*/

module error_coder
#( parameter ERROR_LENGTH = 3 )
(
// input 
  clk               , // system clock
  
  // inputs
  pending_err       ,
  evtno_err         ,
  spillno_err       ,
  eneword_err       ,
  stop_rising       ,
  stop_falling      , 
	
  // outputs
  err_out  
);


input wire         clk;

// inputs
input wire         pending_err;
input wire         evtno_err;
input wire         spillno_err;
input wire         eneword_err;
input wire         stop_rising;
input wire         stop_falling;

// output
output reg         err_out;

// 
reg        [1  :0] level;
reg                lock;
reg        [2  :0] cnt;

////////////////////////////////////////////
always @(posedge clk) begin

   /// receives errors 
	if( pending_err == 1'b1 || evtno_err == 1'b1 || spillno_err == 1'b1 ) begin
	    level <= 0;
		cnt <= 0;
		lock <= 1'b1;
	end
	else if( stop_rising == 1'b1 || stop_falling == 1'b1 ) begin
	    level <= 1;
		cnt <= 0;
		lock <= 1'b1;
	end
	else if( eneword_err == 1'b1 ) begin
	    level <= 2;
		cnt <= 0;
		lock <= 1'b1;
	end

	if( cnt == ERROR_LENGTH ) begin
	   lock <= 1'b0;
	   err_out <= 1'b0;
	end 
	else if( lock == 1'b1 ) begin
	   err_out <= ( cnt <= level ) ? 1'b1 : 1'b0;
	   cnt <= cnt + 1;
	end
	else begin
	   err_out <= 1'b0;
	end
   
	
end

endmodule