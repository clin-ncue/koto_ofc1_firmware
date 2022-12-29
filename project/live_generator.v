/* 
   live_generator
   C. Lin, chiehlin@uchicago.edu
*/

module live_generator
(
// input 
  clk               , // system clock
     
  // output
  q                       
              
);

input wire         clk;

// output
output reg         q;

// 8.e-9 x 0x20000000 = 4.29 (sec)
reg [29:0] counter;

////////////////////////////////////////////
always @(posedge clk) begin

   q <= (counter[29]==1'b1) ? 1'b1 : 1'b0; 
   counter <= counter + 1;
		
end

endmodule