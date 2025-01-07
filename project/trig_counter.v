/* 
   trigger counter
   C. Lin, chiehlin@uchicago.edu
*/

module trig_counter
(
// input 
  clk               , // system clock
  reset             ,
  
  // inputs
  in                , 
   
  // output
  q                       
              
);

input wire         clk;
input wire         reset;

// inputs
input wire         in;

// output
output reg [15: 0] q;

////////////////////////////////////////////
always @(posedge clk) begin

   if( reset==1'b1 ) begin
      q <= 0;
   end

   if( in==1'b1 && q<16'hFFFF ) begin
      q <= q + 1;
   end
		
end

endmodule