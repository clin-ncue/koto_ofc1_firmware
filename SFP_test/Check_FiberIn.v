module Check_FiberIn(
	clk,
	rst,
	data_in,
	sample_cnt0,
	sample_cnt2,
	err_cnt0,
	err_cnt2
);


input wire clk;
input wire rst;
input wire [15:0] data_in;

output reg [31:0] sample_cnt0;
output reg [31:0] sample_cnt2;
output reg [31:0] err_cnt0;
output reg [31:0] err_cnt2;

reg [15:0] pipeline0;
reg [15:0] pipeline1;


integer n;

always @(posedge clk)
begin
	if(rst) 
	begin
		sample_cnt0 = 32'b0;
		sample_cnt2 = 32'b0;
		err_cnt0 = 32'b0;
		err_cnt2 = 32'b0;
						
	end


	pipeline1[15:0] = pipeline0[15:0]; 
    pipeline0[15:0] = data_in[15:0];


	sample_cnt0 = sample_cnt0 + 1'b1;
	sample_cnt2 = (sample_cnt0==32'hffffffff)? sample_cnt2 + 1'b1 : sample_cnt2;

	err_cnt0 = ( (pipeline0[15:0]-pipeline1[15:0]) != 16'b1 )? err_cnt0 + 1'b1 : err_cnt0;
	err_cnt2 = (err_cnt0==32'hffffffff)? err_cnt2 + 1'b1 : err_cnt2;
	

end

endmodule
