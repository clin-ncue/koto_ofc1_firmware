
module ol_sw(	
	clk,
	LIVE,
	data_tx,
	datak,
	data_out
);

input wire clk;
input wire LIVE;
input wire [15:0] data_tx;

output reg [15:0] data_out;
output reg [1 :0] datak;

always @(posedge clk)
begin
	
	if( LIVE == 1'b0 )
	   begin
		   datak = 2'b11;
			data_out = 16'h50BC;
		end
	else
	   begin
		   datak = 2'b00;
			data_out = data_tx;
		end	
end

endmodule
