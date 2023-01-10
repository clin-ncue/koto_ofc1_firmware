module Mem_Write_Control(clk, NWrite, NTrigger,trigger, rst, addr, wena, status);

input wire clk;
input wire [7:0] NWrite;
input wire [7:0] NTrigger;
input wire trigger;
input wire rst;

output reg [15:0] addr = 16'b1111111111111111;
output reg wena;
output reg status = 1'b0;


reg [7:0] counter;
reg [7:0] ntrig_reg = 0;
reg last;
reg self_rst;

reg write = 1'b0;

always @(posedge clk)
begin

	if(rst)
	begin
		write = 1'b0;
		wena = 0;
		counter = 8'b0;
		addr = 16'b1111111111111111;
		self_rst = 0;
		ntrig_reg = 0;
		status = 0;

	end
	
//	status = (ntrig_reg==NTrigger)? 1'b1:status;
	
	if(trigger && ntrig_reg < NTrigger) 
	begin
		write = 1'b1;
		counter = 8'b0;
		ntrig_reg = ntrig_reg + 1'b1;
	end
	else 
	begin
		write = write;
		counter = counter;
		ntrig_reg = ntrig_reg;
	end
	
	if(write)
	begin
		if(counter >= 0 && counter <= NWrite-1)
		begin
			wena = 1'b1;
			addr = addr + 1'b1;
			counter = counter + 1'b1;
		end
		else if (counter >= NWrite)
		begin
			status = (ntrig_reg==NTrigger)? 1'b1:status;
			wena = 1'b0;
			addr = addr;
			write = 1'b0;
			counter = 8'b0;
		end
	end 
		

end

endmodule