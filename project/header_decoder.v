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
*/

module header_decoder
#( parameter PACKAGE_LENGTH = 1036 )
(
// input 
  clk               , // system clock
  live_rising       ,
  
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
  r_pkglength       ,
  r_timestamp       ,
  r_spillno         ,
  r_slotno          ,
  r_evtno           ,
  eneword_err             
);

input wire         clk;
input wire         live_rising;

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
output reg [15 :0] r_pkglength;
output reg [28 :0] r_timestamp;
output reg [8  :0] r_spillno;
output reg [4  :0] r_slotno;
output reg [13 :0] r_evtno;
output reg         eneword_err;

//
reg        [11 :0] pkg_cnt;

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset 
   if( live_rising == 1'b1 ) begin
	   pkg_cnt <= 12'hFFF;
		eneword_err <= 1'b0;
	end

	/// header words identification ///
   if(    data_prebuffer == 16'h50BC
	    && data_buffer0[15:14]==2'b11 
	    && data_buffer1[15:14]==2'b11 
		 && data_buffer2[15:14]==2'b11
		 && data_buffer3[15:14]==2'b11
		 && data_buffer4[15:14]==2'b11 
		 && data_buffer5[15:14]==2'b11 ) begin
		 
		get_package <= 1'b1;
		pkg_cnt <= 0;
		
		/// header decoder ///
		r_pkglength <= {data_buffer0[7:0], data_buffer1[7:0]};
		r_timestamp <= {data_buffer1[12], data_buffer2[13:0], data_buffer3[13:0]};
		r_spillno   <= {data_buffer4[5], data_buffer4[13:6]};
		r_slotno    <= data_buffer4[4:0];
		r_evtno     <= data_buffer5[13:0];
		
	end
   else begin
		get_package <= 1'b0;
	end
	
	/// energy word checks ///
   if( pkg_cnt < PACKAGE_LENGTH ) begin
	   pkg_cnt <= pkg_cnt + 1;
		
		// energy word //
		if( pkg_cnt < 1024 && data_buffer0[15:14]!=2'b10 ) begin
		   eneword_err <= 1'b1;
		end
		else begin
		   eneword_err <= 1'b0;
		end
		
	end
	
end

endmodule