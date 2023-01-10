module signal_valid(clk,reset,tlk_err,dval,LIVE);

input wire clk;
input wire reset;
input wire tlk_err;
input wire LIVE;

output reg dval;
reg[9:0] timer = 10'b0;
reg tlk_pipe   = 1'b0;
reg aligned    = 1'b0;
always @(posedge clk)
begin

  if(reset)
  begin
    timer    = 10'b0;
    dval     = 1'b0;
	 aligned  = 1'b0;
	 tlk_pipe = 1'b0;
  end

  if(~LIVE)
  begin
    timer    = 10'b0;
    dval     = 1'b0;
	 aligned  = 1'b0;
	 tlk_pipe = 1'b0;    
  end
  
  if(tlk_err == 1'b0 && tlk_pipe == 1'b1) //falling edge of tlk_err means alignment success
    aligned = 1'b1;
  else 
	 aligned = aligned;
	 
  timer = aligned ? timer+1'b1 : 10'b0;

  if(timer==10'b1111_1010_00)
    dval = 1'b1;
  else 
	 dval = dval;
  
  
  
  
  

  tlk_pipe = tlk_err;

end
endmodule
