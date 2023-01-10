module Add_ADCID
	(	clk,
		rst,
		fiber_in,
		iniID,
		fiber_out,
		ID_out
	);

input wire clk;
input wire rst;
input wire [15:0] fiber_in;
input wire [7:0] iniID;

output reg [15:0] fiber_out = 16'b0000000000000000;
output reg [7:0] ID_out = 8'b10110011;


reg ena = 1'b0;
reg [4:0] control = 5'b00000;


reg [15:0] fiber_reg;

always @(posedge clk)
begin
	
	if(rst)
	begin
		ID_out = 8'b10110011;
		control = 5'b00000;
		ena = 1'b0;
	end	
	
	fiber_out[15:0] = fiber_reg[15:0];
	fiber_reg = fiber_in;
	
	ena = (fiber_out[15:0]==16'b1010101010101010)? 1'b1:ena;
	
	if(ena)
	begin
		if(control==0)
		begin
			ID_out = 8'b10110011;
		end
		else if(control>=1 && control <=16)
		begin
			ID_out = iniID + control - 1'b1;

		end
		else if(control==17)
		begin
			ID_out = 8'b10110011;
			ena = 1'b0;
		end
		else 
		begin	
			ID_out = 8'b10110011;
		end

		control = control + 1'b1;	
		
	end
	else
	begin
		control = 5'b00000;
		ID_out = 8'b10110011;
	end
	
end

endmodule