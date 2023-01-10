module NClus_to_TOP(
	clk,
	header,
	nclus,
	eventID,
	out
);

input wire clk;
input wire [37:0] header;
input wire [12:0] nclus;
input wire [9:0] eventID;

output reg [15:0] out;

always @(posedge clk)
begin
	
	if(header[15:0]==16'b1010101010101010)
	begin
		out[15] = 1'b1;
		out[9:0] = eventID[9:0];
		out[13:10] = nclus[3:0];
	end
	else
	begin
		out = 16'b0;
	end

end

endmodule
