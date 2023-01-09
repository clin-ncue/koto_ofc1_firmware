module true_ram_sclk
(
	input [15:0] data,
	input [14:0] wr_addr,rd_addr,
	input wr_ena,  clk, rd_ena, 
	output reg [15:0] q,
	output reg dval
);
	// Declare the RAM variable
	reg [15:0] ram[25000:0];
	
	// Write
	always @ (posedge clk)
	begin
		if (wr_ena) 
		begin
			ram[wr_addr] <= data;
			//q_a <= data_a;
		end
	end

	// Port A	
	always @ (posedge clk)
	begin
		if(rd_ena)
		begin
		  q <= ram[rd_addr];
		  dval <= 1'b1;
		end

		else
////			q_a <= 16'b0;
		  dval <= 1'b0;
	end
	
endmodule	