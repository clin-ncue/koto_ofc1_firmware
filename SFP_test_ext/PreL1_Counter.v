module PreL1_Counter(
	clk,
	LIVE,
	rst,
	pL1a_got,
	cnt
);

input wire clk;
input wire LIVE;
input wire rst;
input wire pL1a_got;

output reg [9:0] cnt;

reg [1:0] pipeline;

always @(posedge clk)
begin

	pipeline[1] <= pipeline[0];
	pipeline[0] <= pL1a_got;

	if(rst || ~LIVE)
	begin
		cnt = 10'b1111111111;
	end
	
	if(pipeline[1]==1'b0 && pipeline[0]==1'b1)
	begin
		cnt = cnt + 1'b1;
	end
	
end

endmodule
