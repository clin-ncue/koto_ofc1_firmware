module SLVDS_test(clk,q);

input wire clk;
output reg q = 1'b0;

reg [15:0] counter = 16'b0;
reg [5:0] control = 6'b0;


always @(posedge clk)
begin


	case(control)
		6'b000000: counter = counter + 1'b1;
		6'b000001: q = 1'b1;
		6'b000010: q = 1'b1;
		6'b000011: q = counter[ 0];
		6'b000100: q = counter[ 1];
		6'b000101: q = counter[ 2];
		6'b000110: q = counter[ 3];
		6'b000111: q = counter[ 4];
		6'b001000: q = counter[ 5];
		6'b001001: q = counter[ 6];
		6'b001010: q = counter[ 7];
		6'b001011: q = counter[ 8];
		6'b001100: q = counter[ 9];
		6'b001101: q = counter[10];
		6'b001110: q = counter[11];
		6'b001111: q = counter[12];
		6'b010000: q = counter[13];
		6'b010001: q = counter[14];
		6'b010010: q = counter[15];
		6'b010011: q = 1'b0;
		default: q = 1'b0;
	endcase
	
	control = control + 1'b1;
	
end


endmodule
