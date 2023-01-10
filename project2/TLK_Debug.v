module TLK_Debug(
	clk,
	rst,
	in,
	err_cnt
);

input wire clk;
input wire rst;
input wire [15:0] in;

output reg [7:0] err_cnt;


reg [1:0] ctrl;
reg start = 1'b0;

reg [15:0] value [1:0];

always @(posedge clk)
begin

	if(rst)
	begin
		err_cnt = 8'hFF;
		ctrl = 2'b00;
		start = 1'b0;
	end


	value[1] = value[0];
	value[0] = in;

	if(start==1'b0 && ctrl < 2'b11)
	begin
		err_cnt = (ctrl==2'b10)? 8'h00 : err_cnt;
		start = (ctrl==2'b11)? 1'b1  : start;
		ctrl = ctrl + 1'b1;
	end
	
	if(start)
	begin
		err_cnt = ((value[0]-value[1])!=16'h0001 && err_cnt < 8'hFD)? err_cnt + 1'b1 : err_cnt;
	end
	

end

endmodule
