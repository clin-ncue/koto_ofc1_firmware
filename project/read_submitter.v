/* 
   read_submitter
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.20
	Preliminary version.
	
	2021.12.22
	Update due to bug in pending error. See comment below.
	
	2021.12.29
	Update algorithm: Originally, "read_submit" is 1'b1 if pre_request != ~input_mask 
	and request == ~input_mask. Now, the requirement for the previous word is removed.
	A 30-clock "lock" is added to avoid continuous read_submit issuing.
*/

module read_submitter
#( parameter MAX_PENDING_TIME = 1000,
   parameter LOCK_TIME = 30 )
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  request           ,
  input_mask        ,
  
  // output
  read_submit       ,
  pending_err         
);


input wire         clk;

// inputs
input wire         live_rising;
input wire [15 :0] request;
input wire [15 :0] input_mask;       

// output
output reg         read_submit;
output reg         pending_err;

//
reg        [9  :0] pending_time = 0;
reg        [4  :0] lock_cnt = 0;
reg                lock = 1'b0;

////////////////////////////////////////////
always @(posedge clk) begin

   /// lock the read submit judgement for 30 clocks 
	if( lock_cnt < LOCK_TIME ) begin
	   lock_cnt <= lock_cnt + 1;
	end
	else begin
	   lock <= 1'b0;
	end

   /// submit "read" for the next event while all 16 input complete the event-writing.
	if(    pending_err == 1'b0 
	    && lock == 1'b0
		 && request == ~input_mask ) begin
      read_submit <= 1'b1;
		pending_time <= 0;
		lock <= 1'b1;
		lock_cnt <= 0;
   end
   else begin
      read_submit <= 1'b0;
   end	
	
	/// start counting the pending time when read request is received.
   if( request == 0 ) begin
	   pending_time <= 0;
	end
   else if( pending_err == 1'b0 && request > 0 ) begin
	   pending_time <= pending_time + 1;
	end
	
	/// issue error when pending time larger than limitation.
	if( pending_time > MAX_PENDING_TIME ) begin
	   pending_err <= 1'b1;
	end
	
	/// clear error while LIVE is back.
	/// This must be put in buttom to overwrite the result from "if(pending_time > MAX_PENDING_TIME) clause".
	if( live_rising == 1'b1 ) begin
	   pending_time <= 0;
		pending_err <= 1'b0;
	end
	
end

endmodule