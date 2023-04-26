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
  
  // output
  wren              ,
  waddr             ,
  b_full 
);


input wire         clk;

// inputs
input wire         reset;
input wire         trig_in;

// output
output reg         wren;
output reg [10 :0] waddr;
output reg         b_full;

// 

////////////////////////////////////////////
always @(posedge clk) begin

   //
   // reset memory 
	//
   if( reset==1'b1 ) begin
	   wren <= 1'b0;
		waddr <= 11'b0;
		b_full <= 1'b0;
	end
	
	//
	//
	if( waddr==11'h7FF ) begin
	   wren <= 1'b0;
		b_full <= 1'b1;
	end
	else if( wren==1'b1 && waddr<11'h7FF ) begin
	   waddr <= waddr + 1;
	end

	//  	
	//
	if( trig_in==1'b1 ) begin
		wren <= 1'b1;
	end
	
end

endmodule