/* 
   spy_control
   C. Lin, chiehlin@uchicago.edu
*/

module spy_control
(
// input 
  clk               , // system clock
  
  // inputs
  reset             ,
  trig_in           ,
  trig_delay        ,
  seg_depth         ,
  
  // output
  wren              ,
  waddr               
);


input wire         clk;

// inputs
input wire         reset;
input wire         trig_in;
input wire [9  :0] trig_delay;
input wire [9  :0] seg_depth;

// output
output reg         wren;
output reg [9  :0] waddr;

// 
reg        [9  :0] delay_cnt; 
reg        [9  :0] mem_cnt;

// 

////////////////////////////////////////////
always @(posedge clk) begin

   //
   // system reset 
	//
   if( reset==1'b1 ) begin
	   wren <= 1'b0;
		waddr <= 10'b0;
		delay_cnt <= 10'h3FF;
		mem_cnt <= 10'h3FF;
	end
	
	//
	// When reach the maximum depth of memory or segmented memory depth,
	// disable writing.
	// "waddr" can only be reset by system reset.
	//
	if( waddr==10'h3FF || mem_cnt==seg_depth ) begin
	   wren <= 1'b0;
		mem_cnt <= 10'h3FF;
	end
 
	//
   if( delay_cnt < trig_delay ) begin
	   delay_cnt <= delay_cnt + 1;
	end
   else begin
	   mem_cnt <= 0;
	end
	
	if( mem_cnt < seg_depth ) begin
	   wren <= 1'b1;
	   mem_cnt <= mem_cnt + 1;
		waddr <= waddr + 1; 
	end
	
	// 
	// "delay_cnt" is reset when a trigger is received.
   // Protection: Only if both "delay" and "memory-writing" are done is a trigger accepted. 	
	//
	if( trig_in<=1'b1 && delay_cnt >= trig_delay && mem_cnt >= seg_depth ) begin
	   delay_cnt <= 0;
	end
	
end

endmodule