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
	
	2024.04.16 (v1.01.13)
	* Introduce fake data modes.
	
*/

//
// core
//
module write_control_v3
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  get_package       ,
  input_data        ,
  HALF_PACKAGE_LENGTH ,
  MEMORY_DEPTH      ,
  sel               ,
   
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
input wire [1  :0] sel;

// output
output reg         even_wren;
output reg [13 :0] even_addr;
output reg [15 :0] even_data;

output reg         odd_wren;
output reg [13 :0] odd_addr;
output reg [15 :0] odd_data;

output reg         complete;

wire         even_wren_standard;
wire [13 :0] even_addr_standard;
wire [15 :0] even_data_standard;

wire         odd_wren_standard;
wire [13 :0] odd_addr_standard;
wire [15 :0] odd_data_standard;

wire         complete_standard;

wire         even_wren_constant;
wire [13 :0] even_addr_constant;
wire [15 :0] even_data_constant;

wire         odd_wren_constant;
wire [13 :0] odd_addr_constant;
wire [15 :0] odd_data_constant;

wire         complete_constant;

wire         even_wren_delta;
wire [13 :0] even_addr_delta;
wire [15 :0] even_data_delta;

wire         odd_wren_delta;
wire [13 :0] odd_addr_delta;
wire [15 :0] odd_data_delta;

wire         complete_delta;

wire         even_wren_alternate;
wire [13 :0] even_addr_alternate;
wire [15 :0] even_data_alternate;

wire         odd_wren_alternate;
wire [13 :0] odd_addr_alternate;
wire [15 :0] odd_data_alternate;

wire         complete_alternate;

write_control_standard write_control_standard_instance(clk, 
                                                       live_rising, 
																		 get_package, 
																		 input_data,
                                                       HALF_PACKAGE_LENGTH, 
																		 MEMORY_DEPTH, 
																		 even_data_standard,
																		 even_addr_standard,
																		 even_wren_standard,
																		 odd_data_standard,
																		 odd_addr_standard,
																		 odd_wren_standard,
																		 complete_standard   );
																		 

write_control_constant write_control_constant_instance(clk, 
                                                       live_rising, 
																		 get_package, 
																		 input_data,
                                                       HALF_PACKAGE_LENGTH, 
																		 MEMORY_DEPTH, 
																		 even_data_constant,
																		 even_addr_constant,
																		 even_wren_constant,
																		 odd_data_constant,
																		 odd_addr_constant,
																		 odd_wren_constant,
																		 complete_constant   );	
	
write_control_delta   write_control_delta_instance    (clk, 
                                                       live_rising, 
																		 get_package, 
																		 input_data,
                                                       HALF_PACKAGE_LENGTH, 
																		 MEMORY_DEPTH, 
																		 even_data_delta,
																		 even_addr_delta,
																		 even_wren_delta,
																		 odd_data_delta,
																		 odd_addr_delta,
																		 odd_wren_delta,
																		 complete_delta   );	
																		 
																		 

write_control_alternate write_control_alternate_instance(clk, 
                                                       live_rising, 
																		 get_package, 
																		 input_data,
                                                       HALF_PACKAGE_LENGTH, 
																		 MEMORY_DEPTH, 
																		 even_data_alternate,
																		 even_addr_alternate,
																		 even_wren_alternate,
																		 odd_data_alternate,
																		 odd_addr_alternate,
																		 odd_wren_alternate,
																		 complete_alternate   );														 

always @(posedge clk)
begin

   case( sel )
	   2'b00: begin
		   even_data <= even_data_standard;
			even_addr <= even_addr_standard;
			even_wren <= even_wren_standard;
			odd_data  <= odd_data_standard;
			odd_addr  <= odd_addr_standard;
			odd_wren  <= odd_wren_standard;
			complete  <= complete_standard;
	    end
	    
		2'b01: begin
		   even_data <= even_data_constant;
			even_addr <= even_addr_constant;
			even_wren <= even_wren_constant;
			odd_data  <= odd_data_constant;
			odd_addr  <= odd_addr_constant;
			odd_wren  <= odd_wren_constant;
			complete  <= complete_constant;
		end
		
		2'b10: begin
		   even_data <= even_data_delta;
			even_addr <= even_addr_delta;
			even_wren <= even_wren_delta;
			odd_data  <= odd_data_delta;
			odd_addr  <= odd_addr_delta;
			odd_wren  <= odd_wren_delta;
			complete  <= complete_delta;
		end
			
		2'b11: begin
			even_data <= even_data_alternate;
			even_addr <= even_addr_alternate;
			even_wren <= even_wren_alternate;
			odd_data  <= odd_data_alternate;
			odd_addr  <= odd_addr_alternate;
			odd_wren  <= odd_wren_alternate;
			complete  <= complete_alternate;
		end
		
		default:
		   ;
	endcase 
end

endmodule

//
// standard mode
//
module write_control_standard
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
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 even_addr;
	   odd_addr  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
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

//
// constant mode: constant contant (0xe14)
//
module write_control_constant
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
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 even_addr;
	   odd_addr  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 odd_addr;
		
		even_data <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 16'h8e14 : even_data;
      odd_data  <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 16'h8e14 : odd_data; 		
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

//
// delta mode: delta function
//
module write_control_delta
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
		if( pkg_cnt >= (6 + 480) && pkg_cnt < (6 + 480 + 16) ) begin
      even_wren <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 1'b1 : 1'b0;
	   odd_wren  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 1'b1 : 1'b0;	
		
		even_addr <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 even_addr;
	   odd_addr  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 odd_addr;
		
		even_data <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 16'hb000 : even_data;
      odd_data  <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 16'hb000 : odd_data; 		
   end	
	else if( pkg_cnt >=6 && pkg_cnt < 6 + 1024 ) begin
      even_wren <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 1'b1 : 1'b0;
	   odd_wren  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 1'b1 : 1'b0;	
		
		even_addr <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 even_addr;
	   odd_addr  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 odd_addr;
		
		even_data <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 16'h8001 : even_data;
      odd_data  <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 16'h8001 : odd_data; 		
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

//
// alternate mode: odd and even samples are alternated between 0x0 and 0x3000
//
module write_control_alternate
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
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 even_addr;
	   odd_addr  <= ( ((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 
		             3 + init_addr + ( (pkg_cnt - 6) / 16 ) / 2 + ( (pkg_cnt - 6) % 16 ) * 64 / 2 :
						 odd_addr;
		
	   even_data <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b0 ) ? 16'h8001 : even_data;
       odd_data  <= (((pkg_cnt - 6) / 16 ) % 2 == 1'b1 ) ? 16'hb000 : odd_data; 		
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

