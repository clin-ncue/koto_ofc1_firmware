module L1A_checker_part1(reset,need_check,clk,one_adc_finish_check,start_check,error,check_in_progress);

input wire reset;
input wire need_check;
input wire clk;
input wire one_adc_finish_check;


output reg[15:0] start_check;
output reg[1:0] error;
output reg check_in_progress;

always @(posedge clk)
begin

  if(reset)
  begin
    error             = 2'b0;
	 // add on 2019/11/18. Otherwise the signal will stay high if some errors occur. 
    start_check       = 16'b0;
    check_in_progress = 1'b0;
  end

  if(need_check)
  begin
    if(start_check==16'b0)
	   start_check = start_check + 1'b1;
    else  
      error[0] = 1'b1;                     //the previous reading has not been finished, yet the new reading starts -> error = 1'b1
  end

  if(one_adc_finish_check)
    start_check = start_check << 1'b1;
	 
	 
  check_in_progress = start_check==16'b0 ? 1'b0 : 1'b1;	 

end
endmodule
