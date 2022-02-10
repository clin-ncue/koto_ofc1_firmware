module Trig_Counter (
	clk,
	rst,
	L1A,
	PL1A,
	PS,
	ALIGN,
	DELTA,
	cnt_L1A,
	cnt_PL1A,
	cnt_PS,
	cnt_ALIGN,
	cnt_DELTA
);


input wire clk;
input wire rst;
input wire L1A;
input wire PL1A;
input wire PS;
input wire ALIGN;
input wire DELTA;


output reg [31:0] cnt_L1A = 32'b0;
output reg [31:0] cnt_PL1A = 32'b0;
output reg [31:0] cnt_PS = 32'b0;
output reg [31:0] cnt_ALIGN = 32'b0;
output reg [31:0] cnt_DELTA = 32'b0;

always @(posedge clk)
begin

	if(rst)
	begin	
		cnt_L1A = 32'b0;
		cnt_PL1A = 32'b0;
		cnt_PS = 32'b0;
		cnt_ALIGN = 32'b0;
		cnt_DELTA = 32'b0;
	end
	
	cnt_L1A = (L1A==1'b1)? cnt_L1A + 1'b1 : cnt_L1A;
	cnt_PL1A = (PL1A==1'b1)? cnt_PL1A + 1'b1 : cnt_PL1A;
	cnt_PS = (PS==1'b1)? cnt_PS + 1'b1 : cnt_PS;
	cnt_ALIGN = (ALIGN==1'b1)? cnt_ALIGN + 1'b1 : cnt_ALIGN;
	cnt_DELTA = (DELTA==1'b1)? cnt_DELTA + 1'b1 : cnt_DELTA;
	

	
end

endmodule
