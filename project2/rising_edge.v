/* 
   rising edge
   C. Lin, chiehlin@uchicago.edu
*/

module rising_edge
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

   if( pre_sig==1'b0 && sig==1'b1 ) begin
		out <= 1'b1;
	end
   else begin
		out <= 1'b0;
	end
		
end

endmodule