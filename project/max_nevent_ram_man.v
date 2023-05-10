/* 
   max_nevent_ram_man
   C. Lin, chiehlin@uchicago.edu
		
	Measure the maximum number of events stored in ram
*/

module max_nevent_ram_man
(
// input 
  clk               , // system clock
  
  // inputs
  live_rising       ,
  n_write           ,
  n_read            ,
   
  // output
  max_nevent_ram   
);


input wire         clk;

// inputs
input wire         live_rising;
input wire [15 :0] n_write;
input wire [15 :0] n_read;

// output
output reg [15 :0] max_nevent_ram;


// 


////////////////////////////////////////////
always @(posedge clk) begin	

	if( live_rising == 1'b1 ) begin
      max_nevent_ram <= 0;
   end	
	
	if( n_write - n_read > max_nevent_ram ) begin
	   max_nevent_ram <= n_write - n_read;
	end
		
end

endmodule