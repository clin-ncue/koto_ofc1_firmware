/* 
   write_control_v2
   C. Lin, chiehlin@uchicago.edu
	
	This module assigns the identified ADC package to the corresponding 
	even/odd RAM address.
	
	--------------------------------------------------------------------------
	2021.12.13
	prelimiary version.
	
	2021.12.16
	In line with the updated memory depth, new logic is introduced.
	
	2022.11.03
	PACKAGE_LENGTH and MEMORY_DEPTH are inputs now 
	(update for ADC firmware v2464 or above).
	
	2023.07.28
	Add data transpose.
	number of headers and energy words are temporarily hard coded.
	
	2023.08.01 (v1.00.01)
	Rewrite the data-writing logic. The waddr and wren are driven by pkg_cnt.
	
	2024.01.04 (v1.01.01)
	* The module name has been changed to write_control_v2
	Rewrite the data-writing logic. The waddr and wren are driven by pkg_cnt.
	- xxx_addr width is shrinked from 15 bits to 14 bits.
	- Initial addresses are corrected: 15'h7FFF -> 14'h3FFF
	
*/

module write_control_v2
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  get_package       ,
  input_data        ,
  HALF_PACKAGE_LENGTH ,
  MEMORY_DEPTH      ,
   
  // output
  even_data         ,
  even_addr         ,
  even_wren         ,
  odd_data          ,
  odd_addr          ,
  odd_wren          ,
  complete               
);


input wire         clk;

// inputs
input wire         live_rising;
input wire         get_package;
input wire [15 :0] input_data;
input wire [9  :0] HALF_PACKAGE_LENGTH;
input wire [13 :0] MEMORY_DEPTH;

// output
output reg         even_wren;
output reg [13 :0] even_addr;
output reg [15 :0] even_data;

output reg         odd_wren;
output reg [13 :0] odd_addr;
output reg [15 :0] odd_data;

output reg         complete;

// counter for package length 
reg        [11 :0] pkg_cnt; 
reg        [13 :0] init_addr;

reg        [10 :0] PACKAGE_LENGTH; 
// 

////////////////////////////////////////////
always @(posedge clk) begin

   ///
   /// Packag length needs to be in even.
	///
   PACKAGE_LENGTH <= {HALF_PACKAGE_LENGTH, 1'b0 };

	///
   /// Reset at LIVE rising edge.
	///
   if( live_rising == 1'b1 ) begin
		even_wren <= 1'b0;
		odd_wren <= 1'b0;
		even_addr <= 14'h3FFF;
		odd_addr <= 14'h3FFF;
		pkg_cnt <= PACKAGE_LENGTH;
		complete <= 1'b0;
		init_addr <= MEMORY_DEPTH - HALF_PACKAGE_LENGTH;
	end

   ///	
	/// Assign data to even / odd memory. 	
	/// Restructure the data based on the input word id (pkg_cnt).
	/// 6 headers + 1025 energy words + 1(+1) footer word
	/// The energy words are transposed as follows.
	/// (pkg_cnt - 6) % 16 = channel ID
	/// (pkg_cnt - 6) / 16 = sample ID
	/// Another factor of 2 because data is splitted into two rams.
	/// The addition "3" is the offset from header words.
	///
	/// ----------------------------------------------------------------------------
	/// 
	/// (1) Energy words
	///  sample ID is even -> even RAM
	///  sample ID is odd  -> odd RAM
	///
	///  new_pkg_id = 6 header words + sample ID + channel ID * 64; 
	///  ram_addr = new_pkg_id / 2;
   ///	
	///
	if( pkg_cnt >=6 && pkg_cnt < 6 + 1024 ) begin
      even_wren <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 1'b1 : 1'b0;
	   odd_wren  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 1'b1 : 1'b0;	
		
		even_addr <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 
		             3 + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 even_addr;
	   odd_addr  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 
		             3 + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 odd_addr;
		
		even_data <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? input_data : even_data;
      odd_data  <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? input_data : odd_data; 		
   end	
	/// ---------------------------------------------------------------------------
	///
   /// (2) Header / Footer words
	///     even ram: h0, h2, h4, (energy words), f0
	///     odd  ram: h1, h3, h5, (energy words), 0
	///
	else if( pkg_cnt < PACKAGE_LENGTH ) begin
      even_wren <= ( pkg_cnt[0]==1'b0 ) ? 1'b1 : 1'b0;
		odd_wren  <= ( pkg_cnt[0]==1'b1 ) ? 1'b1 : 1'b0;
		
      even_addr <= ( pkg_cnt[0]==1'b0 ) ? init_addr + pkg_cnt[11:1] : even_addr;
      odd_addr  <= ( pkg_cnt[0]==1'b1 ) ? init_addr + pkg_cnt[11:1] : odd_addr;

      even_data <= ( pkg_cnt[0]==1'b0 ) ? input_data : even_data;
      odd_data  <= ( pkg_cnt[0]==1'b1 ) ? input_data : odd_data; 		
   end
   ///
	/// (3) Others
	/// pkg_cnt has reached the package length, should disable the writing.
	///
	else begin
	   odd_wren <= 1'b0;
		even_wren <= 1'b0;
	end
	
	
	///
	/// Stop incrementing pkg_cnt when it reaches the package length.
	/// Issue complete signal one clock before it completes.
	///
	pkg_cnt  <= (pkg_cnt < PACKAGE_LENGTH ) ? (pkg_cnt + 1) : pkg_cnt;
	complete <= (pkg_cnt == PACKAGE_LENGTH - 1) ? 1'b1 : 1'b0;
	
	///
	/// Enable memory writing when header is identified.
	/// If the next event will exceed the memory depth, the initial address goes back to zero.
   ///	
   if( get_package == 1'b1 ) begin
		pkg_cnt <= 0;
		init_addr <= ( init_addr + HALF_PACKAGE_LENGTH >= MEMORY_DEPTH ) ? 
		             0 : init_addr + HALF_PACKAGE_LENGTH;
	end
	
end

endmodule