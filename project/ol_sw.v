/* 
   ol_sw
   C. Lin, chiehlin@uchicago.edu
		
	2021.12.17 updates.
	data_out is always the idle words (This is expected not to send any data though).
*/

module ol_sw(	
	clk,
	LIVE,
	data_out,
	datak
);

input wire clk;
input wire LIVE;

output reg [15:0] data_out;
output reg [1 :0] datak;

always @(posedge clk)
begin
	
	data_out <= 16'h50BC;
	
	if( LIVE == 1'b0 ) begin
		datak <= 2'b11;
	end
	else begin
		datak <= 2'b00;
	end
	
end

endmodule
