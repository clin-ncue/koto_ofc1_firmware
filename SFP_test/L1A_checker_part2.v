module L1A_checker_part2(clk,reset,start_check,rd_addr,rd_req);

input wire clk;
input wire reset;
input wire start_check;

//will be connected to ram_L1A to read the L1A value
output reg[7:0] rd_addr;
output reg rd_req;   

reg r1;
reg r2;
reg r3;

always @(posedge clk)
begin

  if(reset)
  begin
    rd_addr = 8'b0;
	 rd_req = 1'b0;
  end
 

  r1 <= start_check;   // first stage of 2-stage synchronizer
  r2 <= r1;       // second stage of 2-stage synchronizer
  r3 <= r2; 
  
  if(r2 && !r3)
  begin
    rd_req = 1'b1;
    rd_addr = rd_addr + 1'b1;
  end
  
  else
  begin
    rd_req = 1'b0;
	 rd_addr = rd_addr;
  
  end


end
endmodule
