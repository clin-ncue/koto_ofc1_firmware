module mem_simu_trigger_v1
(
	input [29:0] clock_timing, 
	//input [2:0] wr_addr, number_of_triggers,
	//input [15:0] wr_addr,
	input clk, start_work, reset,     // this start_work should be a pulse
	input [13:0] total_trigger,       // the total_trigger will exclude delta trigger 
	output reg trigger, rd_req,
	output reg[13:0] rd_addr,
	output reg[13:0] trigger_gen
); 

reg[29:0] timer     = 30'b0;
reg start_work_pipe = 1'b0;
reg work_in_process = 1'b0;
reg[13:0] counter   = 14'b0;
always @(posedge clk)
begin


  rd_req  = 1'b0;
  trigger = 1'b0;
  if(reset)
  begin
    rd_addr         = 14'b0;
    timer           = 30'b0;
    trigger         = 1'b0;
	 start_work_pipe = 1'b0;
	 rd_req          = 1'b0;
	 work_in_process = 1'b0;
	 counter         = 14'b0;
	 end

  //start_work should turn on the process
  work_in_process = start_work ? 1'b1 : work_in_process;	 
	 
  if(work_in_process)
  begin
    
	 if(start_work_pipe == 1'b0 && start_work == 1'b1) //the rising edge of start_work will issue the 1st rd_req
    begin
      rd_addr = rd_addr + 1'b1;    // read from reg[1]. reg[0] stores delta_trigger_event
		rd_req  = 1'b1;
    end	 
    else if(timer==clock_timing)
    begin
	   trigger = 1'b1;
      rd_addr = rd_addr + 1'b1;
		rd_req  = 1'b1;
		counter = counter + 1'b1;
    end	
 
  
    timer = timer + 1'b1;
  end
  else 
  begin
    timer   = 30'b0;
	 rd_req  = 1'b0;
	 rd_addr = 14'b0;  
	 trigger = 1'b0;
  end 
  
  
  work_in_process = (counter==total_trigger) ? 1'b0 : work_in_process;
  
  start_work_pipe = start_work;

  trigger_gen = counter;
end

endmodule


