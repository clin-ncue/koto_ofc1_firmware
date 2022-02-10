
module spy_control(	
	clk,
	reset,
	trigger,
	wren,
	waddr
);

input wire clk;
input wire reset;
input wire trigger;

output reg        wren;
output reg [10:0] waddr = 0;

reg               lock = 1'b0;

always @(posedge clk)
begin
	
	if( reset == 1'b1 ) 
	   begin
		   lock = 1'b0;
		end
	
	if( waddr == 11'h7FF )
	   begin
		   wren = 1'b0;
			lock = 1'b1;
		end
	
	if( lock == 1'b0 && trigger == 1'b1 )
	   begin
		   wren = 1'b1;
			waddr = 11'h7FF;
		end
	
	waddr = waddr + 1;

end

endmodule
