module L1A_checker_part3(L1A_00,L1A_01,L1A_02,L1A_03,
L1A_04,L1A_05,L1A_06,L1A_07,
L1A_08,L1A_09,L1A_10,L1A_11,
L1A_12,L1A_13,L1A_14,L1A_15,
clk,reset,check_in_progress,start_check,L1A_align,error,one_adc_finish_check,trig_in);

input wire[13:0] L1A_00;
input wire[13:0] L1A_01;
input wire[13:0] L1A_02;
input wire[13:0] L1A_03;
input wire[13:0] L1A_04;
input wire[13:0] L1A_05;
input wire[13:0] L1A_06;
input wire[13:0] L1A_07;
input wire[13:0] L1A_08;
input wire[13:0] L1A_09;
input wire[13:0] L1A_10;
input wire[13:0] L1A_11;
input wire[13:0] L1A_12;
input wire[13:0] L1A_13;
input wire[13:0] L1A_14;
input wire[13:0] L1A_15;
input wire[15:0] start_check;          //added on 2019/10/20. 
input wire clk;
input wire reset;
input wire check_in_progress;
input wire[15:0] trig_in;

output reg L1A_align;
output reg[15:0] error;
output reg one_adc_finish_check; 

//reg[3:0] start = 4'b0;
//reg[3:0] lock  = 4'b0;
 
//reg[13:0] pipe00[1:0];
//reg[13:0] pipe01[1:0];
//reg[13:0] pipe02[1:0];
//reg[13:0] pipe03[1:0];

//reg[13:0] pipe00;
//reg[13:0] pipe01;
//reg[13:0] pipe02;
//reg[13:0] pipe03;
//reg[13:0] pipe04;
//reg[13:0] pipe05;
//reg[13:0] pipe06;
//reg[13:0] pipe07;
//reg[13:0] pipe08;
//reg[13:0] pipe09;
//reg[13:0] pipe10;
//reg[13:0] pipe11;
//reg[13:0] pipe12;
//reg[13:0] pipe13;
//reg[13:0] pipe14;
//reg[13:0] pipe15;

reg[3:0] mode = 4'b0;
 
always @(posedge clk)

begin

  if(reset)
  begin
    //start = 4'b0;
	 mode                   = 4'b0;
	 L1A_align              = 1'b0;
	 error                  = 16'b0;
	 one_adc_finish_check   = 1'b0;
//	 pipe00                 = 14'b0;
//	 pipe01                 = 14'b0;
//	 pipe02                 = 14'b0;
//	 pipe03                 = 14'b0;	 
//	 pipe04                 = 14'b0;
//	 pipe05                 = 14'b0;
//	 pipe06                 = 14'b0;
//	 pipe07                 = 14'b0;	
//	 pipe08                 = 14'b0;
//	 pipe09                 = 14'b0;
//	 pipe10                 = 14'b0;
//	 pipe11                 = 14'b0;	
//	 pipe12                 = 14'b0;
//	 pipe13                 = 14'b0;
//	 pipe14                 = 14'b0;
//	 pipe15                 = 14'b0;		 
  end

//  pipe00[1] = pipe00[0];
//  pipe00[0] = L1A_00;
//  pipe01[1] = pipe01[0];
//  pipe01[0] = L1A_01;
//  pipe02[1] = pipe02[0];
//  pipe02[0] = L1A_02;
//  pipe03[1] = pipe03[0];
//  pipe03[0] = L1A_03;
  
  one_adc_finish_check = 1'b0;
  L1A_align = 1'b0;
  case(mode)
  2'b00: // check 0th adc 
  begin

    if(trig_in[0] && start_check[0]) // L1A of 0th adc has been updated
	 begin
	   if(check_in_progress)
	   begin
	     mode = mode +1'b1;
		  error[0] = 1'b0;
		  one_adc_finish_check = 1'b1;
      end	
		else
		begin
		  mode = mode;
		  error[0] = 1'b1;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		
  end
  
  2'b01: // check 1st adc 
  begin
    if(trig_in[1] && start_check[1]) 
	 begin
	   if(L1A_01==L1A_00) //compare L1A between 1st and 0th ADC
		begin
		  error[1] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[1] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  2'b10: // check 2nd adc
  begin
    if(trig_in[2] && start_check[2]) 
	 begin
	   if(L1A_02==L1A_01)     //compare L1A between 2nd and 1st ADC
		begin
		  error[2] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[2] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end
  
  2'b11: // check 3rd adc 
  begin
    if(trig_in[3] && start_check[3]) 
	 begin
	   if(L1A_03==L1A_02)     //compare L1A between 3rd and 2nd ADC
		begin
		  error[3] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[3] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  
  3'b100: // check 4th adc
  begin
    if(trig_in[4] && start_check[4]) 
	 begin
	   if(L1A_04==L1A_03)     //compare L1A between 3rd and 4th ADC
		begin
		  error[4] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[4] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end
    
  3'b101: // check 5th adc 
  begin
    if(trig_in[5] && start_check[5]) 
	 begin
	   if(L1A_05==L1A_04)     //compare L1A between 5th and 4th ADC
		begin
		  error[5] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[5] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  
  3'b110: // check 6th adc
  begin
    if(trig_in[6] && start_check[6]) 
	 begin
	   if(L1A_06==L1A_05)     //compare L1A between 6th and 5th ADC
		begin
		  error[6] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[6] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end  
  
  3'b111: // check 7th adc 
  begin
    if(trig_in[7] && start_check[7]) 
	 begin
	   if(L1A_07==L1A_06)     //compare L1A between 7th and 6th ADC
		begin
		  error[7] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[7] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  
  4'b1000: // check 8th adc
  begin
    if(trig_in[8] && start_check[8]) 
	 begin
	   if(L1A_08==L1A_07)     //compare L1A between 8th and 7th ADC
		begin
		  error[8] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[8] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end  
    
  4'b1001: // check 9th adc 
  begin
    if(trig_in[9] && start_check[9]) 
	 begin
	   if(L1A_09==L1A_08)     //compare L1A between 9th and 8th ADC
		begin
		  error[9] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[9] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  
  4'b1010: // check 10th adc
  begin
    if(trig_in[10] && start_check[10]) 
	 begin
	   if(L1A_10==L1A_09)     //compare L1A between 10th and 9th ADC
		begin
		  error[10] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[10] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end    
  
  4'b1011: // check 11st adc 
  begin
    if(trig_in[11] && start_check[11]) 
	 begin
	   if(L1A_11==L1A_10)     //compare L1A between 11st and 10th ADC
		begin
		  error[11] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[11] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  
  4'b1100: // check 12nd adc
  begin
    if(trig_in[12] && start_check[12]) 
	 begin
	   if(L1A_12==L1A_11)     //compare L1A between 12nd and 11st ADC
		begin
		  error[12] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[12] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end      
  
  4'b1101: // check 13rd adc 
  begin
    if(trig_in[13] && start_check[13]) 
	 begin
	   if(L1A_13==L1A_12)     //compare L1A between 13nd and 12rd ADC
		begin
		  error[13] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[13] = 1'b1;
		  mode = mode;
		end
	 end	
    else
	   one_adc_finish_check = 1'b0;
		 
  end
  
  4'b1110: // check 14th adc
  begin
    if(trig_in[14] && start_check[14]) 
	 begin
	   if(L1A_14==L1A_13)     //compare L1A between 14th and 13rd ADC
		begin
		  error[14] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		end
		else
		begin
		  error[14] = 1'b1;
		  mode = mode;
		end

	 end
    else
	   one_adc_finish_check = 1'b0;
		
  end       
  
  
  
  
  4'b1111: // check last adc
  begin
    if(trig_in[15] && start_check[15])
	 begin
	   if(L1A_15==L1A_14)     //compare L1A between 2nd and 3rd ADC
		begin
		  error[15] = 1'b0;
		  mode = mode + 1'b1;
		  one_adc_finish_check = 1'b1;
		  L1A_align = error==16'b0 ? 1'b1:1'b0;
		end
		else
		begin
		  error[15] = 1'b1;
		  mode = mode;
		end

	 end
    else
	 begin
	   one_adc_finish_check = 1'b0;
	   L1A_align = 1'b0;	
	 end	
  end  
	
  endcase
  
/*  
  
  if(pipe00[0] != pipe00[1])
  begin
    if(~lock[0])
	 begin
      start[0] = 1'b1;
		lock[0] = 1'b1;
	 end	
    else		
      error[0] = 1'b1;		 
  end	 
      
  if(start[0] && (pipe01[0] != pipe01[1]))
    if(pipe01[0]==pipe00[0])
*/


//  pipe00 = L1A_00;
//  pipe01 = L1A_01;    
//  pipe02 = L1A_02;
//  pipe03 = L1A_03;  
//  pipe04 = L1A_04;
//  pipe05 = L1A_05;    
//  pipe06 = L1A_06;
//  pipe07 = L1A_07;  
//  pipe08 = L1A_08;
//  pipe09 = L1A_09;    
//  pipe10 = L1A_10;
//  pipe11 = L1A_11;  
//  pipe12 = L1A_12;
//  pipe13 = L1A_13;    
//  pipe14 = L1A_14;
//  pipe15 = L1A_15;    
end
endmodule

