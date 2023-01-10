module special_dram_sclk
(
	input [15:0] data, 
	input [15:0] wr_addr,
	input [15:0] rd_addr_a, rd_addr_b,
	input wr_ena,  clk, rd_ena_a, rd_ena_b,
	output reg [15:0] q_a, q_b,
	output reg dval_a, dval_b
);


	// Declare the RAM variable
	reg [15:0] ram[65535:0];
	
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
		if(rd_ena_a)
		begin
			q_a <= ram[rd_addr_a];
			dval_a = 1'b1;
		end
		else
//			q_a <= 16'b0;
			dval_a = 1'b0;
	end

	// Port B	
	always @ (posedge clk)
	begin
		if(rd_ena_b)
		begin
			q_b <= ram[rd_addr_b];
			dval_b = 1'b1;
		end
		else
//			q_b <= 16'b0;
			dval_b = 1'b0;
		
	end
		
endmodule		



//module special_dram_sclk_testbench;
//
//`timescale 1ns / 1ps
//
//reg[15:0] data;
//reg[10:0] wr_addr;
//reg[10:0] rd_addr_a, rd_addr_b;
//reg wr_ena,clk,rd_ena_a,rd_ena_b;
//wire[15:0] q_a;
//wire[15:0] q_b;
//
//special_dram_sclk DUT(data,wr_addr,rd_addr_a,rd_addr_b,wr_ena,clk,rd_ena_a,rd_ena_b,q_a,q_b);
//
//always #10 clk = ~ clk;
//
//initial 
//begin
//
//  
//
//
//
//end
//
//endmodule 