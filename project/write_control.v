/* 
   write_control
   C. Lin, chiehlin@uchicago.edu
	
	2021.12.13
*/

module write_control
#( parameter PACKAGE_LENGTH = 1036 )
(
// input 
  clk               , // system clock
  
  // inputs
  live              ,
  get_package       ,
  input_data        ,
   
  // output
  even_data         ,
  even_addr         ,
  wren              ,
  odd_data          ,
  odd_addr          
    
);


input wire         clk;

// inputs
input wire         live;
input wire         get_package;
input wire [15 :0] input_data;

// output
output reg         wren;
output reg [13 :0] even_addr;
output reg [15 :0] even_data;

output reg [13 :0] odd_addr;
output reg [15 :0] odd_data;

// counter for package length 
reg        [11 :0] pkg_cnt; 



////////////////////////////////////////////
always @(posedge clk)
begin

   /// reset ///
   if( live == 1'b0 )
	   begin
		   wren <= 1'b0;
			even_addr <= 14'h3FFF;
			odd_addr <= 14'h3FFF;
			pkg_cnt <= PACKAGE_LENGTH;
		end
   
	/// enable memory writing when header is identified.
   if( get_package == 1'b1 )
	   begin
		   pkg_cnt <= 0;
		   wren <= 1'b1;
		end
		
	/// assign memory 	
	if( wren == 1'b1 )
      begin
	      if( pkg_cnt[0]==1'b0 )
			   begin
			      even_addr <= even_addr + 1;
					even_data <= input_data;
				end
			else
			   begin
					odd_addr <= odd_addr + 1;
					odd_data <= input_data;
				end
      end	
	
	/// 
	if( pkg_cnt == PACKAGE_LENGTH )
      begin
		   wren <= 1'b0;
		end
   else
	   begin
		   pkg_cnt <= pkg_cnt + 1;
		end
		
end

endmodule