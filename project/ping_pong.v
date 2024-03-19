/* 
   ping_pong
   C. Lin, chiehlin@uchicago.edu
	
*/

module ping_pong
(
// input 
  clk               , // system clock
  
  // inputs
  reset             ,
  in                ,
   
  // output
  outA              ,
  outB             
);

input wire         clk;
input wire         reset;

// inputs
input wire         in;

// output
output reg         outA;
output reg         outB;

reg                is_A_B;

////////////////////////////////////////////
always @(posedge clk) begin

	outA <= (is_A_B==1'b0) ? in : 1'b0;  
	outB <= (is_A_B==1'b1) ? in : 1'b0;
	
	is_A_B <= (in==1'b1) ? (!is_A_B) : is_A_B;
	
	/// reset
	if( reset==1'b1 ) begin
	   is_A_B <= 1'b0;
	end

end

endmodule