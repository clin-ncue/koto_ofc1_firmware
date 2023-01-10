module LIVE_cnt(clk,rst,live,cnt,LIVE_rst);

input wire clk;
input wire live;
input wire rst;
output reg[8:0] cnt;
output reg LIVE_rst;

reg[1:0] pipe;
reg[8:0] counter = 9'b0;
reg[8:0] reset_cnt = 9'b0;

reg lock = 1'b0;

always @(posedge clk)
begin


if(rst)
begin
  counter   = 9'b0;
  lock      = 1'b0;
  reset_cnt = 9'b0;
end

pipe[1]=pipe[0];
pipe[0]=live;


//rising edge of LIVE
if(pipe[0]==1'b1 && pipe[1]==1'b0)
begin
  counter = counter + 1'b1;
  lock = 1'b1;
end

if(lock)
begin
  reset_cnt = reset_cnt + 1'b1;
  LIVE_rst  = 1'b1;
end
else
begin
  reset_cnt = 9'b0;
  LIVE_rst  = 1'b0; 
end

if(reset_cnt == 7'b110_0100)  //100
  lock = 1'b0;

cnt = counter;  



end
endmodule
