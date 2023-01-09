module Joint_Block_header
(
	clk,
	rst,
	array_header,
	array_in0,
	array_in1,
	array_out0,
	array_out1,
);

input wire clk;
input wire rst;
input wire [15:0] array_header;
input wire [37:0] array_in0;
input wire [37:0] array_in1;

output reg [37:0] array_out0;
output reg [37:0] array_out1;

reg [37:0] array_reg0;
reg [37:0] array_reg1;



reg srst;
reg ena;
reg [2:0] control;

integer i;

always @(posedge clk)
begin	

	if(rst || srst)
	begin
		array_reg0 = 38'b0;
		array_reg1 = 38'b0;		
		array_out0 = 38'b0;	
		array_out1 = 38'b0;	
		
		control = 3'b0;
		ena = 1'b0;
		srst = 1'b0;
	end

	ena = (array_header==16'b1010101010101010)? 1'b1:ena;
	
	if(ena)
	begin	
		if( control == 0 )
		begin
			array_reg0 = array_in0;
			array_reg1 = array_in1;			
		end
		else if( control == 1 )
		begin
			;
		end
		else if( control == 2 )
		begin
			array_out0 = array_reg0;
			//array_out1 = array_reg1;
			srst = 1'b1;
		end
		
		control = control + 1'b1;
	end

end

endmodule