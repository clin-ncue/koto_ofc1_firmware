module data_out_L1A_check( clk, reset, data_in, L1A_sent_counter, current_L1A );

input wire clk;
input wire reset;
input wire[31:0] data_in;

output reg[15:0] L1A_sent_counter = 16'b0;
output reg[13:0] current_L1A = 14'b0;   

reg[4:0] counter = 5'b0;

always @(posedge clk)
begin

  if(reset)
  begin
    L1A_sent_counter = 16'b0;
	 current_L1A      = 14'b00_0000_0000_0000_0001;
    counter          = 5'b0;
  end

	if( data_in[31]==1'b1 && data_in[30]==1'b1 && data_in[15]==1'b1 && data_in[14]==1'b1 && data_in[13:0] == current_L1A )
	  counter = counter + 1'b1;
	  
	if(counter==16)	//16 adcs
	//if(counter==3)	//simplify simulation	
	begin
	  counter = 0;
	  L1A_sent_counter = L1A_sent_counter + 1'b1;
	  current_L1A = current_L1A + 1'b1; 
	end



end
endmodule
