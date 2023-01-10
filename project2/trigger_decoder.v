/* 
   trigger_decoder
   C. Lin, chiehlin@uchicago.edu
*/

module trigger_decoder
(
// input 
  clk               , // system clock
  in                ,               
  
  // output
  L1A               ,
  ALIGN             ,
  DELTA             ,
  PL1A                                   
);

input wire         clk;
input wire  [3 :0] in;

// output
output reg         L1A;
output reg         ALIGN;
output reg         DELTA;
output reg         PL1A;

//
reg [1 :0] cnt = 2'b00;

////////////////////////////////////////////
always @(posedge clk) begin

   cnt <= (cnt<2'b11) ? cnt + 1 : 2'b11;

   if( cnt==2'b11 && in[3]==1'b1 ) begin
      case (in[2:0])
         3'b000:  L1A   <= 1'b1;
         3'b001:  DELTA <= 1'b1;
         3'b010:  ALIGN <= 1'b1;
         3'b011:  ;
         3'b100:  ;
         3'b101:  ;
         3'b110:  PL1A  <= 1'b1;
         3'b111:  ;
         default: ;   
      endcase
		
		cnt <= 2'b00;
   end
   else begin
      L1A   <= 1'b0;
      DELTA <= 1'b0;
      ALIGN <= 1'b0;
      PL1A  <= 1'b0;
   end
    
end

endmodule