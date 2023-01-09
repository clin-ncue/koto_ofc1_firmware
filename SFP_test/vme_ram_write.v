module vme_ram_write(clk,rst,trig_in,wr_ena,wr_addr);

input wire clk;
input wire rst;
input wire trig_in;

output reg wr_ena;
output reg[11:0] wr_addr;

reg start;
reg[11:0] cnt;

always @(posedge clk)
begin
  if(rst)
  begin
    cnt      = 12'b0;
	 wr_ena   = 1'b0;
	 wr_addr  = 12'b0;
	 start    = 1'b0;
  end
  
  start = ( trig_in && ~start ) ? 1'b1 : start;
  if(start)
  begin
    wr_ena  = 1'b1;
	 wr_addr = wr_addr + 1'b1;
    cnt     = cnt + 1'b1;
  end
  else
  begin
    cnt     = 12'b0;
	 wr_ena  = 1'b0;
	 wr_addr = 12'b0;	 	 
  end	 
  
  if(cnt == 12'b1111_1111_1111)
  begin
    start = 1'b0;
  end
  else
  begin
    start = start;
  end
  
  
end 
endmodule

