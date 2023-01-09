
module spy_lock(	
	clk,
	reset,
	memory_full,
	lock
);

input wire clk;
input wire reset;
input wire memory_full;

output reg        lock = 1'b1;

always @(posedge clk)
begin
	
	if( reset == 1'b1 ) 
	   begin
		   lock = 1'b0;
		end
	
	if( memory_full == 1'b1 )
	   begin
		   lock = 1'b1;
	   end
	

end

endmodule
