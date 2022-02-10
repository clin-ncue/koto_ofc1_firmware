/* 
   header_decoder
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.09
   only identify 6 consecutive header words. 
*/

module header_decoder
(
// input 
  clk               , // system clock
  
  // inputs
  data_buffer0      , 
  data_buffer1      ,
  data_buffer2      ,
  data_buffer3      ,
  data_buffer4      ,
  data_buffer5      ,
   
  // output
  get_package              
              
);

input wire         clk;

// inputs
input wire [15 :0] data_buffer0;
input wire [15 :0] data_buffer1;
input wire [15 :0] data_buffer2;
input wire [15 :0] data_buffer3;
input wire [15 :0] data_buffer4;
input wire [15 :0] data_buffer5;

// output
output reg         get_package;

////////////////////////////////////////////
always @(posedge clk)
begin

   if(    data_buffer0[15:14]==2'b11 
	    && data_buffer1[15:14]==2'b11 
		 && data_buffer2[15:14]==2'b11
		 && data_buffer3[15:14]==2'b11
		 && data_buffer4[15:14]==2'b11 
		 && data_buffer5[15:14]==2'b11 )
	   begin
		   get_package <= 1'b1;
		end
   else
	   begin
		   get_package <= 1'b0;
		end
		
end

endmodule