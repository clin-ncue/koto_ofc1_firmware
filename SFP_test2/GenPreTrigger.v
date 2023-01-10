module GenPreTrigger(clk,rst,ena,ntrig,gap,trigger);

input wire clk;
input wire rst;
input wire ena;
input wire [15:0] ntrig;
input wire [7:0] gap;

output reg trigger;

//reg [7:0] gap_reg;
reg [7:0] counter;
reg [15:0] ntrig_reg;
reg [511:0] pipeline;
reg send_pre = 1'b0;

reg [3:0] count_pre = 4'b0;


always @( posedge clk)
begin

//	gap_reg = gap - 1'b1;

	if(rst)
	begin
		ntrig_reg = 16'b0;
		counter = 8'b0;
		pipeline = 512'b0;
	end

	pipeline = pipeline << 1;
	pipeline[0] = 1'b0;
	
	if( ena && ntrig_reg < ntrig )
	begin
		if(counter==gap)
		begin
			pipeline[0] = 1'b1;
			ntrig_reg = ntrig_reg + 1'b1;
			counter = 8'b0;
		end
		else 
		begin
			ntrig_reg = ntrig_reg;
		end
		counter = counter + 1'b1;
	end


	send_pre = (pipeline[5]==1'b1)? 1'b1:send_pre;

	if(send_pre)
	begin

		if(count_pre==1) 	    trigger = 1'b1;
		else if(count_pre==2) trigger = 1'b1;
		else if(count_pre==3) trigger = 1'b1;
		else if(count_pre==4) trigger = 1'b0;
		else if(count_pre==5)
		begin
			count_pre = 4'b0;
			trigger = 1'b0;
			send_pre = 1'b0;
		end
		
		count_pre = count_pre + 1'b1;
	end
	

	
end

endmodule