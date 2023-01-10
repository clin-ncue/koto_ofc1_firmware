module Convert2NCluster (
	clk,
	rst,
	header_in,
	nturn,
	header_out,
	ncluster,
	error1,
	error2
);

input wire clk;
input wire rst;
input wire [37:0] header_in;
input wire [14:0] nturn;

output reg [37:0] header_out;
output reg [12:0] ncluster;
output reg error1;
output reg error2;



always @(posedge clk)
begin

	if(rst)
	begin	
		error1 <= 1'b0;
		error2 <= 1'b0;		
	end

	if( header_in[15:0] == 16'b1010101010101010 )
	begin
		header_out[37:0] <= header_in[37:0];
		ncluster[12:0] <= nturn[14:2];
		
		error1 <= (nturn[1:0] != 2'b00)? 1'b1 : error1;
		error2 <= (header_in[36:26] != 11'b11111111111 )? 1'b1 : error2;
	end
	else
	begin
		header_out[37:0] <= 38'b0;
		ncluster[12:0] <= 13'b0;
	end
	
end

endmodule
