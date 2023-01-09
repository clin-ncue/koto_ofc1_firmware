module trigger_delay(clk,in,delay,out);

input wire clk;

input wire in;
input wire [3:0] delay;
output reg out;

reg [15:0] pipeline = 16'b0;



always @(posedge clk)
begin
	
	pipeline = pipeline << 1;
	pipeline[0] = in;
	out = pipeline[delay];
	
end

endmodule