/* 
   header_decoder
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.09
   Only identify 6 consecutive header words. 
	
	2021.12.15
	Add header decoding.
	- Energy word check is removed.
	
	2021.12.28
	Further require "data_prebuffer", which is one clock before data_buffer0, to be 50BC. 
	
	2022.11.02
	Modify for the ADC firmware v2464 or above.
	- "data_prebuffer" needs to be zeros.
	- Adjust header decoding based on the new definition.
	- Remove energy word checks (commented).
	
*/

module header_decoder
(
// input 
  clk               , // system clock
  
  // inputs
  data_prebuffer    ,
  data_buffer0      , 
  data_buffer1      ,
  data_buffer2      ,
  data_buffer3      ,
  data_buffer4      ,
  data_buffer5      ,
   
  // output
  get_package       ,
  r_timestamp       ,
  r_spillno         ,
  r_slotno          ,
  r_crateno         ,
  r_evtno                   
);

input wire         clk;

// inputs
input wire [15 :0] data_prebuffer;
input wire [15 :0] data_buffer0;
input wire [15 :0] data_buffer1;
input wire [15 :0] data_buffer2;
input wire [15 :0] data_buffer3;
input wire [15 :0] data_buffer4;
input wire [15 :0] data_buffer5;

// output
output reg         get_package;
output reg [28 :0] r_timestamp;
output reg [9  :0] r_spillno;
output reg [4  :0] r_slotno;
output reg [15 :0] r_evtno;
output reg [4  :0] r_crateno;

////////////////////////////////////////////
always @(posedge clk) begin

	/// header words identification ///
   if(    data_prebuffer == 16'h0000
	    && data_buffer0[15:14]==2'b11 
	    && data_buffer1[15:14]==2'b11 
		 && data_buffer2[15:14]==2'b11
		 && data_buffer3[15:14]==2'b11
		 && data_buffer4[15:14]==2'b11 
		 && data_buffer5[15:14]==2'b11 ) begin
		 
		get_package <= 1'b1;
		
		/// header decoder ///
		r_timestamp <= {data_buffer4[8:0], data_buffer3[13:0], data_buffer2[13:8]};
		r_spillno   <= {data_buffer1[5:0], data_buffer0[13:10]};
		r_slotno    <=  data_buffer0[9:5];
		r_evtno     <= {data_buffer2[7:0], data_buffer1[13:6]};
		r_crateno   <=  data_buffer0[4:0];
		
	end
   else begin
		get_package <= 1'b0;
	end

end

endmodule