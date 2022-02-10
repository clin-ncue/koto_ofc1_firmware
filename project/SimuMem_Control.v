module SimuMem_Control(clk,rst,trigger,naddr,addr,rena);

input wire clk;
input wire rst;
input wire trigger;
input wire [7:0] naddr;
output reg [15:0] addr;
output reg rena;

reg [15:0] addr_reg;
reg send = 0;
reg [7:0] count;

always @(posedge clk)
begin
	if(rst)
	begin
		rena = 1'b0;
		addr_reg = 16'b0;
	end
	
	send = (trigger==1)?1'b1:send;
	
	if(send) 
	begin
		rena = 1'b1;
		addr = addr_reg;
		addr_reg = addr_reg + 1'b1;
		if(count==(naddr-1'b1)) 
		begin
			send = 0;
			count = 0;
		end
		count = count + 1'b1;
	end
	else
	begin
		rena = 1'b0;
		addr = 1023;
		count = 8'b0;
	end	
end

endmodule