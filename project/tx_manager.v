module tx_manager(clk,reset,L1A_Align,need_read,one_adc_finish_read,start_read,error,evt_tx);

input wire clk;
input wire reset;
input wire L1A_Align;
input wire need_read;
input wire one_adc_finish_read;

output reg[15:0] start_read;
output reg[1:0] error;    //4+1. MSB 
output reg[15:0] evt_tx;

always @(posedge clk)
begin


  if(reset)
  begin
    start_read = 16'b0;
	 error = 2'b0;
	 evt_tx = 16'b0;  
  end

  if(L1A_Align)    //one event has been checked. We should start reading this one out
  begin
    if(start_read==16'b0)
	 begin
	   if(need_read)
	     start_read = start_read + 1'b1;
		else
		  error[0] = 1'b1;  
    end
	 else
	   error[1] = 1'b1;    //previous event reading has not finished. Yet we want to start new one
  end

  
  if(one_adc_finish_read)
  begin
    if(start_read[15]==1'b1)
	   evt_tx = evt_tx + 1'b1;
  	 	
    start_read = start_read << 1'b1;
  end
//  start_read = (one_adc_finish_read) ? start_read << 1'b1 : start_read;    //shift to next adc


end
endmodule


 