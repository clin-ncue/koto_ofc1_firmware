module L1A_Discriminator(
	clk,
	in,
	L1A,
	PL1A,
	PS,
	ALIGN,
	DELTA,
	RST
);

input wire clk;
input wire in;

output reg L1A = 1'b0;
output reg PL1A = 1'b0;
output reg PS = 1'b0;
output reg ALIGN = 1'b0;
output reg DELTA = 1'b0;
output reg RST = 1'b0;

reg [3:0] pipeline = 4'b1111;
reg [2:0] pipeline_reg = 3'b000;
reg send = 1'b0;
reg start = 1'b0;

always @(posedge clk)
begin
/*
	if(rst)
	begin
		pipeline = 4'b1111;
		pipeline_reg = 3'b000;							
		send = 1'b0;
		start = 1'b0;
		PL1A = 1'b0;
		L1A = 1'b0;
		PS = 1'b0;
		ALIGN = 1'b0;
		RST = 1'b0;
	end
*/
	pipeline = pipeline << 1;
	pipeline[0] = in;
	
	start = (pipeline==4'b0000)? 1'b1:start;
	
	if(start)
	begin
		if(pipeline[3]==1'b1 && ~send)
		begin
			send = 1'b1;
			pipeline_reg[2:0] = pipeline[2:0];
			pipeline = 4'b0000;
		end
		else
		begin
			send = send;
		end
	
		if(send)
		begin
			case(pipeline_reg)
				3'b000: L1A = 1'b1;
				3'b001: DELTA = 1'b1;
				3'b010: ALIGN = 1'b1;
				3'b011: ;
				3'b100: 
					begin
						L1A = 1'b1;
						PS = 1'b1;
					end
				3'b101: ;
				3'b110: PL1A = 1'b1;
				3'b111: RST = 1'b1;
			endcase
			send = 1'b0;
		end
		else 
		begin
			L1A = 1'b0;
			ALIGN = 1'b0;
			DELTA = 1'b0;
			PS = 1'b0;
			PL1A = 1'b0;
			RST = 1'b0;
		end
	end 
	else
	begin
		L1A = 1'b0;
		ALIGN = 1'b0;
		DELTA = 1'b0;
		PS = 1'b0;
		PL1A = 1'b0;
		RST = 1'b0;
	end
end

endmodule
