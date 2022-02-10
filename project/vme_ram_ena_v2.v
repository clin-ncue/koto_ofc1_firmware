module vme_ram_ena_v2(clk,reset,LIVE,interval,max,wr_ena,wr_addr);

input wire clk;
input wire reset;
input wire LIVE;
input wire[16:0] interval;   // if we want to divide 4sec LIVE into 4096 pieces, the interval is ~120000
input wire[11:0] max;

output reg wr_ena;
output reg[11:0] wr_addr;   //4096

reg[11:0] counter;
reg[16:0] timer;
reg work;
reg LIVE_pipe;

always @(posedge clk)
begin

  if(reset)
  begin
    wr_ena  = 1'b0;
    wr_addr = 12'b0;
	 timer   = 17'b0;
	 counter = 12'b0;
	 work    = 1'b0;
  end
  work = (LIVE==1'b1 && LIVE_pipe==1'b0) ? 1'b1: work;  //LIVE on edge will trigger work
  work = (counter == max) ? 1'b0 : work;    // shut down work when we have enough write requests
  
  if(LIVE)
  begin
    if(work) 
	 begin
      if(timer==(interval-1))
	   begin
	     wr_ena  = 1'b1;
		  wr_addr = wr_addr + 1'b1;	 
		  timer   = 17'b0;
		  counter = counter + 1'b1;
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
	 end
  end
  else   // LIVE OFF
  begin
    wr_ena  = 1'b0;
    wr_addr = 12'b0;  
    timer   = 17'b0;
	 counter = 12'b0;
	 work    = 1'b0;
  end

  LIVE_pipe = LIVE;

end

endmodule



