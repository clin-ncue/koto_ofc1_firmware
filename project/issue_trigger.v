module issue_trigger(clk,reset,din,dout,need_check);

input wire clk, reset;
input wire[15:0] din;
output reg[15:0] dout;
output reg need_check;

reg[15:0] din_pipe;

always@(posedge clk)
begin

  if(reset)
  begin
    dout       = 16'b0;
	 need_check = 1'b0;
    din_pipe   = 16'b0;
  end

  need_check = ((din-din_pipe)==1'b1) ? 1'b1 : 1'b0;
  
end

endmodule
