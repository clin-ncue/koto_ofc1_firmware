/* 
   falling edge
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.09
   only identify 6 consecutive header words. 
*/

module falling_edge
(
// input 
  clk               , // system clock
  
  // inputs
  pre_sig           , 
  sig               ,
   
  // output
  out                       
              
);

input wire         clk;

// inputs
input wire         pre_sig;
input wire         sig;

// output
output reg         out;

////////////////////////////////////////////
always @(posedge clk) begin

   if( pre_sig==1'b1 && sig==1'b0 ) begin
		out <= 1'b1;
	end
   else begin
		out <= 1'b0;
	end
		
end

endmodule