module vme_ram_ena(clk,reset,LIVE,interval,wr_ena,wr_addr);

input wire clk;
input wire reset;
input wire LIVE;
input wire[16:0] interval;   // if we want to divide 4sec LIVE into 4096 pieces, the interval is ~120000

output reg wr_ena;
output reg[11:0] wr_addr;   //4096

reg[16:0] timer;

always @(posedge clk)
begin

  if(reset)
  begin
    wr_ena  = 1'b0;
    wr_addr = 12'b0;
	 timer   = 17'b0;
  end

  if(LIVE)
  begin
    if(timer==(interval-1))
	 begin
	   wr_ena  = 1'b1;
		wr_addr = wr_addr + 1'b1;	 
		timer   = 17'b0;
	 end
    else
	 begin
	   wr_ena  = 1'b0;
		wr_addr = wr_addr;
		timer   = timer + 1'b1;
	 end
  
  end
  else
  begin
    wr_ena  = 1'b0;
    wr_addr = 12'b0;  
    timer   = 17'b0;
  end



end

endmodule




