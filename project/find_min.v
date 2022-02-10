module find_min(din00,din01,din02,din03,clk,reset,min);

input wire[15:0] din00;
input wire[15:0] din01;
input wire[15:0] din02;
input wire[15:0] din03;

input wire clk, reset;

output reg[15:0] min = 16'b0;
reg[15:0] tmp = 16'b0;

always @(posedge clk)
begin

  if(reset)
  begin
    min = 16'b0;
	 tmp = 16'b0;
  end	 
  	 
  tmp = din00 < din01 ? din00 : din01;
  tmp = tmp   < din02 ? tmp   : din02;
  tmp = tmp   < din03 ? tmp   : din03;
  //tmp <= tmp   < din04 ? tmp   : din04;
  min = tmp;
  
end


endmodule
