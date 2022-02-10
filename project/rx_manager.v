module rx_manager(din,clk,reset,evt_tx,need_read,need_check);
input wire clk;
input wire[15:0] din;     //falling edge pulse of data_wr_req
//input wire din01;
//input wire din02;
//input wire din03;

input wire reset;
input wire[15:0] evt_tx;           //how many events have been read out

output reg need_read  = 1'b0;      //send to tx_manager
output reg need_check = 1'b0;      //send to L1A_checker

reg[15:0] evt_rx[15:0];
reg[15:0] evt_tx_pipe;
reg lock = 1'b0;
//reg[15:0] pipe_evt_tx[2];

integer index = 0;
always @(posedge clk)

begin

  if(reset)
  begin
  evt_rx[0]   = 16'b0;
  evt_rx[1]   = 16'b0;
  evt_rx[2]   = 16'b0;
  evt_rx[3]   = 16'b0;  
  evt_rx[4]   = 16'b0;
  evt_rx[5]   = 16'b0;
  evt_rx[6]   = 16'b0;
  evt_rx[7]   = 16'b0;
  evt_rx[8]   = 16'b0;
  evt_rx[9]   = 16'b0;
  evt_rx[10]  = 16'b0;
  evt_rx[11]  = 16'b0; 
  evt_rx[12]  = 16'b0;
  evt_rx[13]  = 16'b0;
  evt_rx[14]  = 16'b0;
  evt_rx[15]  = 16'b0;   
  need_read   = 1'b0;
  need_check  = 1'b0; 
  evt_tx_pipe = 16'b0; 
  lock        = 1'b0;  
  end  
  
  evt_rx[0]  = din[0]  ? evt_rx[0]  + 1'b1 : evt_rx[0];
  evt_rx[1]  = din[1]  ? evt_rx[1]  + 1'b1 : evt_rx[1];
  evt_rx[2]  = din[2]  ? evt_rx[2]  + 1'b1 : evt_rx[2];
  evt_rx[3]  = din[3]  ? evt_rx[3]  + 1'b1 : evt_rx[3];
  evt_rx[4]  = din[4]  ? evt_rx[4]  + 1'b1 : evt_rx[4];
  evt_rx[5]  = din[5]  ? evt_rx[5]  + 1'b1 : evt_rx[5];
  evt_rx[6]  = din[6]  ? evt_rx[6]  + 1'b1 : evt_rx[6];
  evt_rx[7]  = din[7]  ? evt_rx[7]  + 1'b1 : evt_rx[7];
  evt_rx[8]  = din[8]  ? evt_rx[8]  + 1'b1 : evt_rx[8];
  evt_rx[9]  = din[9]  ? evt_rx[9]  + 1'b1 : evt_rx[9];
  evt_rx[10] = din[10] ? evt_rx[10] + 1'b1 : evt_rx[10];
  evt_rx[11] = din[11] ? evt_rx[11] + 1'b1 : evt_rx[11];
  evt_rx[12] = din[12] ? evt_rx[12] + 1'b1 : evt_rx[12];
  evt_rx[13] = din[13] ? evt_rx[13] + 1'b1 : evt_rx[13];
  evt_rx[14] = din[14] ? evt_rx[14] + 1'b1 : evt_rx[14];
  evt_rx[15] = din[15] ? evt_rx[15] + 1'b1 : evt_rx[15];

  
  need_read = 1'b1;	 

  for(index=0;index<16;index=index+1)
  begin
    need_read = evt_rx[index]<=evt_tx ? 1'b0 : need_read;        //evt rx larger than evt tx. We should read out mem
  end  
  
    
  //need_check is on when evt_tx is incremented by 1
  //but for the 1st one, we need turn it on mannually and use lock since it's a one-time thing
  
  //if(evt_tx == 1'b0 && lock == 1'b0 && evt_rx[0]==1'b1)  //modified by Qisen on 2019/11/12
  if(evt_tx == 1'b0 && lock == 1'b0 && need_read)  //need_read means all channels have received one event
  begin
    need_check = 1'b1;
	 lock = 1'b1;
  end
 
  else if((evt_tx-evt_tx_pipe) == 1'b1 && need_read )
  begin
    need_check = 1'b1;
  end
  
  else
    need_check = 1'b0;
  

  evt_tx_pipe = evt_tx;

end
endmodule
 
