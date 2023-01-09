module new_receive_manager(din,clk,reset,evt_tx,need_read,    //the same logic as rx_manager_v4, change the name
evt_rx_00, evt_rx_01, evt_rx_02, evt_rx_03,
evt_rx_04, evt_rx_05, evt_rx_06, evt_rx_07,
evt_rx_08, evt_rx_09, evt_rx_10, evt_rx_11,
evt_rx_12, evt_rx_13, evt_rx_14, evt_rx_15,
need_check);

input wire clk;
input wire[15:0] din;     //falling edge pulse of data_wr_req

input wire reset;
input wire[15:0] evt_tx;           //how many events have been read out

output reg need_read  = 1'b0;      //send to tx_manager
output reg[15:0] evt_rx_00;
output reg[15:0] evt_rx_01;
output reg[15:0] evt_rx_02;
output reg[15:0] evt_rx_03;
output reg[15:0] evt_rx_04;
output reg[15:0] evt_rx_05;
output reg[15:0] evt_rx_06;
output reg[15:0] evt_rx_07;
output reg[15:0] evt_rx_08;
output reg[15:0] evt_rx_09;
output reg[15:0] evt_rx_10;
output reg[15:0] evt_rx_11;
output reg[15:0] evt_rx_12;
output reg[15:0] evt_rx_13;
output reg[15:0] evt_rx_14;
output reg[15:0] evt_rx_15;
output reg need_check;

reg lock = 1'b0;
reg[15:0] evt_tx_pipe = 16'b0;


always @(posedge clk)

begin

  if(reset)
  begin
  evt_rx_00   = 16'b0;
  evt_rx_01   = 16'b0;
  evt_rx_02   = 16'b0;
  evt_rx_03   = 16'b0;  
  evt_rx_04   = 16'b0;
  evt_rx_05   = 16'b0;
  evt_rx_06   = 16'b0;
  evt_rx_07   = 16'b0;
  evt_rx_08   = 16'b0;
  evt_rx_09   = 16'b0;
  evt_rx_10   = 16'b0;
  evt_rx_11   = 16'b0; 
  evt_rx_12   = 16'b0;
  evt_rx_13   = 16'b0;
  evt_rx_14   = 16'b0;
  evt_rx_15   = 16'b0;   
  need_read   = 1'b0;
  need_check  = 1'b0;
  lock        = 1'b0;

  end  
  
  evt_rx_00  = din[0]   ? evt_rx_00  + 1'b1 : evt_rx_00;
  evt_rx_01  = din[1]   ? evt_rx_01  + 1'b1 : evt_rx_01;
  evt_rx_02  = din[2]   ? evt_rx_02  + 1'b1 : evt_rx_02;
  evt_rx_03  = din[3]   ? evt_rx_03  + 1'b1 : evt_rx_03;
  evt_rx_04  = din[4]   ? evt_rx_04  + 1'b1 : evt_rx_04;
  evt_rx_05  = din[5]   ? evt_rx_05  + 1'b1 : evt_rx_05;
  evt_rx_06  = din[6]   ? evt_rx_06  + 1'b1 : evt_rx_06;
  evt_rx_07  = din[7]   ? evt_rx_07  + 1'b1 : evt_rx_07;
  evt_rx_08  = din[8]   ? evt_rx_08  + 1'b1 : evt_rx_08;
  evt_rx_09  = din[9]   ? evt_rx_09  + 1'b1 : evt_rx_09;
  evt_rx_10  = din[10]  ? evt_rx_10  + 1'b1 : evt_rx_10;
  evt_rx_11  = din[11]  ? evt_rx_11  + 1'b1 : evt_rx_11;  
  evt_rx_12  = din[12]  ? evt_rx_12  + 1'b1 : evt_rx_12;
  evt_rx_13  = din[13]  ? evt_rx_13  + 1'b1 : evt_rx_13;
  evt_rx_14  = din[14]  ? evt_rx_14  + 1'b1 : evt_rx_14;
  evt_rx_15  = din[15]  ? evt_rx_15  + 1'b1 : evt_rx_15;  
  
  need_read = 1'b1;	 

  need_read = (evt_rx_00 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_01 <= evt_tx) ? 1'b0 : need_read;
  need_read = (evt_rx_02 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_03 <= evt_tx) ? 1'b0 : need_read;  
  need_read = (evt_rx_04 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_05 <= evt_tx) ? 1'b0 : need_read;
  need_read = (evt_rx_06 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_07 <= evt_tx) ? 1'b0 : need_read;  
  need_read = (evt_rx_08 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_09 <= evt_tx) ? 1'b0 : need_read;
  need_read = (evt_rx_10 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_11 <= evt_tx) ? 1'b0 : need_read;  
  need_read = (evt_rx_12 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_13 <= evt_tx) ? 1'b0 : need_read;
  need_read = (evt_rx_14 <= evt_tx) ? 1'b0 : need_read;      
  need_read = (evt_rx_15 <= evt_tx) ? 1'b0 : need_read;  

  if((evt_tx-evt_tx_pipe)==1'b1)
  begin
    if(need_read)
	 begin
	   need_check = 1'b1;
	   lock       = 1'b1;
	 end
    else
	 begin
	   need_check = 1'b0;
	   lock       = 1'b0;	 
	 end
  
  end
  else
  begin
    if(need_read)
    begin
      if(lock==1'b0)
	   begin
	     need_check = 1'b1;
	     lock       = 1'b1;
	   end  
      else
      begin
        need_check = 1'b0;
        lock       = lock;
      end
    end	 
    else
    begin
      need_check = 1'b0;
		lock       = 1'b0;
    end	 
  end

  evt_tx_pipe = evt_tx;  

end
endmodule
 
