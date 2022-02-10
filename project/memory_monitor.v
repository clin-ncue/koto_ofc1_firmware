module memory_monitor(clk,reset,wr_addr,rd_addr,limit,n1,n2,error,usage);

input wire clk, reset;
output reg error;
input wire[14:0] wr_addr, rd_addr;
input wire[14:0] limit;
input wire[9:0] n1; //  number_of_rounds_wr;    //n1
input wire[9:0] n2; //number_of_rounds_rd;    //n2
// total number of words written in is N1 = n1*limit+ wr_addr
// total number of words read out is   N2 = n2*limit+ rd_addr

output reg[14:0] usage;

reg lock;

always @(posedge clk)
begin

  if(reset)
  begin
    error = 1'b0;
    usage = 15'b0; 
  end

  if(wr_addr>=rd_addr)
  begin
    if(n1>n2)
	 begin
	   usage = limit;
		error = 1'b1;	 
	 end
	 else
	 begin
	   usage = wr_addr - rd_addr;
	   error = error;
	 end
  end	
  
  else
  begin
    if(n1>(n2+1'b1))
	 begin
	   error = 1'b1;
	   usage = limit;
	 end
    else
    begin
	   usage = limit - rd_addr + wr_addr;
		error = error;	 
	 end
  end 

end
endmodule
