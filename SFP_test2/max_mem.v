module max_mem(clk,reset,current_mem_usage,max_mem_usage);

input wire clk;
input wire reset;
input wire[15:0] current_mem_usage;

output reg[15:0] max_mem_usage;

reg[15:0] maximum;

always @(posedge clk)
begin

  if(reset)
  begin
    maximum       = 16'b0;
	 max_mem_usage = 16'b0;
  end

  maximum = (current_mem_usage > maximum) ? current_mem_usage : maximum;
  
  max_mem_usage = maximum;



end
endmodule

