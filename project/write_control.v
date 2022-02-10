/* 
   write_control
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.13
	prelimiary version.
	
	2021.12.16
	In line with the updated memory depth, new logic is introduced.
*/

module write_control
#( parameter PACKAGE_LENGTH = 1036,
   parameter MEMORY_DEPTH = 24576 )
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  get_package       ,
  input_data        ,
   
  // output
  even_data         ,
  even_addr         ,
  even_wren         ,
  odd_data          ,
  odd_addr          ,
  odd_wren          ,
  valid             
);


input wire         clk;

// inputs
input wire         live_rising;
input wire         get_package;
input wire [15 :0] input_data;

// output
output reg         even_wren;
output reg [14 :0] even_addr;
output reg [15 :0] even_data;

output reg         odd_wren;
output reg [14 :0] odd_addr;
output reg [15 :0] odd_data;

output wire        valid;

// counter for package length 
reg        [11 :0] pkg_cnt; 
reg                even_en;
reg                odd_en;

// 
assign valid = (even_wren || odd_wren);

////////////////////////////////////////////
always @(posedge clk) begin

   /// reset ///
   if( live_rising == 1'b1 ) begin
	   even_en <= 1'b0;
		odd_en <= 1'b0;
		even_wren <= 1'b0;
		odd_wren <= 1'b0;
		even_addr <= 15'h7FFF;
		odd_addr <= 15'h7FFF;
		pkg_cnt <= PACKAGE_LENGTH;
	end
		
	/// assign data to even / odd memory 	
	if( even_en == 1'b1 && pkg_cnt[0]==1'b0 ) begin
      even_wren <= 1'b1;
    	even_addr <= (even_addr < MEMORY_DEPTH - 1 ) ? even_addr + 1 : 0;
		even_data <= input_data;
	end
		
	if( odd_en == 1'b1 && pkg_cnt[0]==1'b1 ) begin
		odd_wren <= 1'b1;
		odd_addr <= (odd_addr < MEMORY_DEPTH - 1 ) ? odd_addr + 1 : 0;
		odd_data <= input_data;
   end

	/// stop counter when it reaches the package length.
	if( pkg_cnt < PACKAGE_LENGTH ) begin
		pkg_cnt <= pkg_cnt + 1;
   end
	
	if( pkg_cnt == PACKAGE_LENGTH - 1 ) begin
	   even_en <= 1'b0;
		even_wren <= 1'b0;
	end
	else if( pkg_cnt == PACKAGE_LENGTH ) begin
	   odd_en <= 1'b0;
		odd_wren <= 1'b0;
	end

	/// enable odd memory writing if even is enabled.
	if( even_en == 1'b1 && odd_en == 1'b0 ) begin
	   odd_en <= 1'b1;
	end
	
	/// enable memory writing when header is identified.
   if( get_package == 1'b1 ) begin
	   even_en <= 1'b1;
		pkg_cnt <= 0;
	end
	
end

endmodule