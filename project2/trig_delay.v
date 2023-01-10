module trig_delay(clk,rst,trig_in,delay,trig_out);

input wire clk;
input wire rst;
input wire trig_in;
input wire[3:0] delay;

output reg trig_out;

reg[3:0] cnt;
reg start;

always @(posedge clk)
begin
  if(rst)
  begin
    cnt      = 4'b0;
	 trig_out = 1'b0;
	 start    = 1'b0;
  end
  
  start = ( trig_in && ~start )? 1'b1 : start;
  if(start)
  begin
    cnt = cnt + 1'b1;
  end
  else
    cnt = 4'b0;
  
  if(cnt == delay)
  begin
    trig_out = 1'b1;
    start    = 1'b0;
	 cnt      = 4'b0;
  end
  else
  begin
    trig_out = 1'b0;
	 start    = start;
  end
  
end 
endmodule

