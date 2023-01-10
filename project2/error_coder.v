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
	
	2022.03.22
	- Remove energy word error coding.
	- Add prioritrization logic: 
*/

module error_coder
#( parameter ERROR_LENGTH = 3 )
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  pending_err       ,
  evtno_err         ,
  spillno_err       ,
  stop_rising       ,
  stop_falling      , 
  read_overflow     ,
	
  // outputs
  err_out  
);


input wire         clk;

// inputs
input wire         live_rising;
input wire         pending_err;
input wire         evtno_err;
input wire         spillno_err;
input wire         stop_rising;
input wire         stop_falling;
input wire         read_overflow;

// output
output reg         err_out;

// 
reg        [1  :0] level;
reg                lock;
reg        [2  :0] cnt;
reg                err_sent = 1'b0;

wire err;
assign err = ( pending_err || evtno_err || spillno_err || read_overflow );

////////////////////////////////////////////
always @(posedge clk) begin

    // Reset
    if( live_rising == 1'b1 ) begin
        err_sent <= 1'b0;
        lock <= 1'b0;
        cnt <= 0;
    end

   /// error output logic
   if( cnt == ERROR_LENGTH ) begin
	   lock <= 1'b0;
	   err_out <= 1'b0;
		cnt <= 0;
	end 
	else if( lock == 1'b1 ) begin
	   err_out <= ( cnt < level ) ? 1'b1 : 1'b0;
	   cnt <= cnt + 1;
	end
	else begin
	   err_out <= 1'b0;
   end

	 //
    // Send error / stop if it is not locked and no error is sent in this spill.
    // 
    // 1.   "err" signal keeps 1'b1 during the entire spill.
    //      If the output is locked due to STOP, ERROR is pending.
    // 
    // 2.   ERROR has a higher priority than STOP.
    //      If the output is locked due to ERROR, the STOP signal will NOT be sent.
    //      However, it is okay because no trigger will be issued toward ERROR.
    //
    if( lock == 1'b0 && err_sent == 1'b0 && err == 1'b1 ) begin
        lock <= 1'b1;
        err_sent <= 1'b1;
        level <= 1;
        cnt <= 0;
    end
    else if( lock == 1'b0 && (stop_rising==1'b1 || stop_falling==1'b1) ) begin
        lock <= 1'b1;
        level <= 2;
        cnt <= 0;
    end
	
end

endmodule