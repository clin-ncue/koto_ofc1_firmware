module rx_manager_v2(din,clk,reset,evt_tx,need_read,need_check,event_receive);
input wire clk;
input wire[15:0] din;     //falling edge pulse of data_wr_req


input wire reset;
input wire[15:0] evt_tx;           //how many events have been read out

output reg need_read  = 1'b0;      //send to tx_manager
output reg need_check = 1'b0;      //send to L1A_checker
output reg[15:0] event_receive = 16'b0;

reg[15:0] evt_rx[15:0];
reg[15:0] evt_receive;
reg[15:0] evt_receive_pipe;


integer index = 0;
always @(posedge clk)

begin

  if(reset)
  begin
  evt_rx[0]        = 16'b0;
  evt_rx[1]        = 16'b0;
  evt_rx[2]        = 16'b0;
  evt_rx[3]        = 16'b0;  
  evt_rx[4]        = 16'b0;
  evt_rx[5]        = 16'b0;
  evt_rx[6]        = 16'b0;
  evt_rx[7]        = 16'b0;
  evt_rx[8]        = 16'b0;
  evt_rx[9]        = 16'b0;
  evt_rx[10]       = 16'b0;
  evt_rx[11]       = 16'b0; 
  evt_rx[12]       = 16'b0;
  evt_rx[13]       = 16'b0;
  evt_rx[14]       = 16'b0;
  evt_rx[15]       = 16'b0;   
  need_read        = 1'b0;
  need_check       = 1'b0; 
  evt_receive      = 16'b0; 
  evt_receive_pipe = 16'b0;  
  event_receive    = 16'b0; 
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
 
  evt_receive = evt_rx[0]; 

  // TODO: find which ADC lags the most
  // And error output it
  for(index=1;index<16;index=index+1)
  begin
    evt_receive = (evt_receive<=evt_rx[index]) ? evt_receive : evt_rx[index];        //evt rx larger than evt tx. We should read out mem
  end  
  
  need_read = (evt_receive>evt_tx) ? 1'b1 : 1'b0;
    
  need_check = ((evt_receive-evt_receive_pipe)==1'b1) ? 1'b1 : 1'b0;   //rx increment by 1

 
  evt_receive_pipe = evt_receive;
  event_receive = evt_receive;

end
endmodule
 
