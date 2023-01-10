module mem_write_control_v3(din,clk,reset,spill,data_out,err,L1A,es_out,data_wr_ena,data_wr_addr,
es_wr_ena,
es_wr_addr,
L1A_wr_ena,
L1A_wr_addr
);  //es - event_size; L1a - L1A event number within spill

input wire[15:0] din;
input wire clk;
input wire reset;
input wire[8:0] spill;    // current spill #. Not sure if this number can be obtained from acc or put a clock counter after LIVE

output reg[15:0] data_out;
//[0]-- LOS bit mismatch [1]-- Spill Number mismatch [2]-- Compression words exceed max 32
output reg[2:0] err=3'b0;   
output reg[13:0] L1A = 14'b0;
									// the L1A number of an event
output reg[10:0] es_out = 11'b0;
									// the size of an event;
output reg data_wr_ena = 1'b0;
output reg[15:0] data_wr_addr = 16'b0;
									// write data to mem_data
									// 2019/11/12: 2^16=65536. This will exceeds the maximum capacity of our OFC
									// TODO:
									// we have to set upper limit at 50k
								
									
output reg es_wr_ena = 1'b0;
//output reg[15:0] es_wr_addr = 16'b0;
									// write data to mem_es
									// 2019/11/12: don't need this large size. 
output reg[7:0] es_wr_addr = 8'b0;
									// since mem_data has 50k, each event is around ~1k/3 (loss-less compression by Michigan). So the total event number is around~200.
									
output reg L1A_wr_ena = 1'b0;
output reg[7:0] L1A_wr_addr = 8'b0;									
									// write data to mem_L1A

									

reg lock = 1'b0;           //will be on once receive the 8 headers consecutively
reg[15:0] pipe[7:0];       // 2 L2 header + 6 ADC header
reg[3:0] cnt_h = 4'b0;     //counter of header (2+6)
reg[5:0] cnt_los = 6'b0;   //counter of compression words (up tp 32)
reg[10:0] cnt_e = 11'b0;   //counter of energy words
reg[2:0] cnt_f = 3'b0;     //counter of footer (coe)
reg[5:0] cnt_o = 6'b0;

reg hold = 1'b0;				//hold until all data in pipe[8] are read out
reg send = 1'b0;
reg[3:0] timer = 4'b0;     //after receiving first footer, the timier will clk. Will finish the whole event after 10 clocks. 
reg[3:0] timer2 = 4'b0;    //related to hold. 
reg finish = 1'b0;         //when we receive the whole package  h-l-e-f
//reg LOS = 1'b0;
//reg[8:0] spill_number = 9'b0;

reg next_evt_start = 1'b0;

always @(posedge clk)

begin


  if(reset)
  begin
    cnt_h = 4'b0;
	 cnt_los = 6'b0;
	 cnt_o = 6'b0;
	 cnt_e = 11'b0;
	 cnt_f = 3'b0;
	 timer = 4'b0;
	 timer2 = 4'b0;
	 finish = 1'b0;
	 err = 3'b0;
	 lock = 1'b0;
	 send = 1'b0;
	 hold = 1'b0; 
	 data_wr_addr = 16'hFFFF;
    data_wr_ena = 1'b0;	 
	 es_wr_addr = 8'b0;
    es_wr_ena = 1'b0;	 
	 L1A_wr_addr = 8'b0;
    L1A_wr_ena = 1'b0;	 
	 next_evt_start = 1'b0;
  end

  pipe[7] = pipe[6];
  pipe[6] = pipe[5];
  pipe[5] = pipe[4];
  pipe[4] = pipe[3];
  pipe[3] = pipe[2];
  pipe[2] = pipe[1];
  pipe[1] = pipe[0];
  pipe[0] = din;

  	 
  if(~lock)
  begin
    cnt_h = (din[15]==1'b1 && din[14]==1'b1) ? cnt_h+1'b1 : 1'b0;  // receive the 8 headers consecutively

  end
  else
  begin
    if(din[15]==1'b1 && din[14]==1'b1)
	   cnt_los = cnt_f == 1'b0 ? cnt_los+1'b1 : cnt_los;
    else if(din[15]==1'b1 && din[14]==1'b0)	
		cnt_e = cnt_e+1'b1;
	 else if(din[15]==1'b0 && din[14]==1'b1 && din[13]==1'b1 && din[12]==1'b0)	
	   cnt_f = cnt_f+1'b1;
	 else
		cnt_o = cnt_o + 1'b1;

  end	 
  
  
  if(cnt_h==4'b1000 && ~lock)
  begin
	 //LOS = pipe[4][13];      //pipe[4] correspond to adc_2 and adc_2[13] is LOS, which LOS=1 when loss-compression is used 
	 err[0] = (pipe[4][13]==1'b1) ? 1'b0:1'b1; 
	 //spill_numver = {pipe[1][5],pipe[1][13:6]};   //pipi[1] adc_5 record spill number
	 err[1] = ( {pipe[1][5],pipe[1][13:6]} == spill) ? 1'b0 : 1'b1;
	 L1A = pipe[0][13:0];
	 lock = 1'b1;
    L1A_wr_ena = 1'b1;
	 L1A_wr_addr = L1A_wr_addr + 1'b1;
  end
  else
  begin
	 lock = lock;
	 err = err;
	 L1A = L1A;
	 L1A_wr_ena = 1'b0;
	 L1A_wr_addr = L1A_wr_addr;
  end	 
	 
  timer = cnt_f>1'b0 ? timer+1'b1 : 1'b0;   //once receive footer, timer will click. 	 
  next_evt_start = (cnt_f>1'b0 && din[15]==1'b1 && din[14]==1'b1 ) ? 1'b1:1'b0;    // deal with ffffh case (haven't received 6 footers before the next jumps in)

//  err[2] = (cnt_los>6'b10_0000) ? 1'b1 : 1'b0;     // up tp 32 compression words
  err[2] = (cnt_los>6'b11) ? 1'b1 : 1'b0;     // up tp 32 compression words
  

 
  finish = ( (cnt_f==3'b110) || (timer == 4'b1010) || next_evt_start ) ? 1'b1 : 1'b0;
  //finish = (cnt_f==3'b110) ? 1'b1 : 1'b0;
  if(finish)
  begin
    es_out = cnt_h + cnt_los + cnt_e + cnt_f + cnt_o;
	 cnt_h = next_evt_start ? 1'b1:4'b0;
	 cnt_los = 6'b0;
	 cnt_o = 6'b0;
	 cnt_e = 11'b0;
	 cnt_f = 3'b0;
	 lock = 1'b0;
	 hold = 1'b1;
	 es_wr_ena = 1'b1;
	 es_wr_addr = es_wr_addr + 1'b1;
	 //send = 1'b0;
  end
  else
  begin
    es_wr_ena = 1'b0;
  end
  
  timer2 = hold ? timer2+1'b1: 1'b0;     //this timer is used to read data from the pipeline. Since the newest data (last footer) 
													  //is located in pipeline[0]. So we need 8 more clocks to read it out.

  if(timer2 > 4'b1000)
  begin
    send = 1'b0;     //after 8 clocks, all data in pipeline are sent out 
    hold = 1'b0;
  end
  else
  begin
    send = send;
	 hold = hold;
  end
  
  send = lock ? 1'b1 : send;
  if(send)
  begin
    data_wr_ena = 1'b1;
	 data_wr_addr = data_wr_addr + 1'b1;
    data_out = pipe[7];
  end
  else
  begin
    data_wr_ena = 1'b0;
	 data_wr_addr = data_wr_addr;
    data_out = 16'b0;
  end



end
endmodule

