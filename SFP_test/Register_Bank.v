module Register_Bank
	(
		clk,
		test_mode,
		waddr,
		value,
		raddr,
		return,		
		reg01,
		reg02,
		reg03,
		reg04,
		reg05,
		reg06,
		reg07,
		reg08,
		reg09,
		reg10,
		reg11,
		reg12,
		reg13,
		reg14,
		reg15,
		reg16,
		reg17,
		reg18,
		reg19,
		reg20,
		reg21,
		reg22,
		reg23,
		reg24,
		reg25,
		reg26,
		reg27,
		reg28,
		reg29,
		reg30,
		reg31,
		reg32,
		reg1b_01
	);
	
input wire clk;
input wire test_mode;
input wire [15:0] waddr;
input wire [15:0] value;
input wire [15:0] raddr;

output reg [15:0] return;
output reg [15:0] reg01;
output reg [15:0] reg02;
output reg [15:0] reg03;
output reg [15:0] reg04;
output reg [15:0] reg05;
output reg [15:0] reg06;
output reg [15:0] reg07;
output reg [15:0] reg08;
output reg [15:0] reg09;
output reg [15:0] reg10;
output reg [15:0] reg11;
output reg [15:0] reg12;
output reg [15:0] reg13;
output reg [15:0] reg14;
output reg [15:0] reg15;
output reg [15:0] reg16;
output reg [15:0] reg17;
output reg [15:0] reg18;
output reg [15:0] reg19;
output reg [15:0] reg20;
output reg [15:0] reg21;
output reg [15:0] reg22;
output reg [15:0] reg23;
output reg [15:0] reg24;
output reg [15:0] reg25;
output reg [15:0] reg26;
output reg [15:0] reg27;
output reg [15:0] reg28;
output reg [15:0] reg29;
output reg [15:0] reg30;
output reg [15:0] reg31;
output reg [15:0] reg32;

output reg reg1b_01;
	
always @(posedge clk)
begin

	// write
	reg01 = ( test_mode && waddr == 16'b0000000000000001 )? value : reg01; 
	reg02 = ( test_mode && waddr == 16'b0000000000000010 )? value : reg02; 
	reg03 = ( test_mode && waddr == 16'b0000000000000011 )? value : reg03; 
	reg04 = ( test_mode && waddr == 16'b0000000000000100 )? value : reg04; 
	reg05 = ( test_mode && waddr == 16'b0000000000000101 )? value : reg05; 
	reg06 = ( test_mode && waddr == 16'b0000000000000110 )? value : reg06; 
	reg07 = ( test_mode && waddr == 16'b0000000000000111 )? value : reg07; 
	reg08 = ( test_mode && waddr == 16'b0000000000001000 )? value : reg08; 
	reg09 = ( test_mode && waddr == 16'b0000000000001001 )? value : reg09; 
	reg10 = ( test_mode && waddr == 16'b0000000000001010 )? value : reg10; 
	reg11 = ( test_mode && waddr == 16'b0000000000001011 )? value : reg11; 
	reg12 = ( test_mode && waddr == 16'b0000000000001100 )? value : reg12; 
	reg13 = ( test_mode && waddr == 16'b0000000000001101 )? value : reg13; 
	reg14 = ( test_mode && waddr == 16'b0000000000001110 )? value : reg14; 
	reg15 = ( test_mode && waddr == 16'b0000000000001111 )? value : reg15; 
	reg16 = ( test_mode && waddr == 16'b0000000000010000 )? value : reg16; 
	reg17 = ( test_mode && waddr == 16'b0000000000010001 )? value : reg17; 
	reg18 = ( test_mode && waddr == 16'b0000000000010010 )? value : reg18; 
	reg19 = ( test_mode && waddr == 16'b0000000000010011 )? value : reg19; 
	reg20 = ( test_mode && waddr == 16'b0000000000010100 )? value : reg20; 
	reg21 = ( test_mode && waddr == 16'b0000000000010101 )? value : reg21; 
	reg22 = ( test_mode && waddr == 16'b0000000000010110 )? value : reg22; 
	reg23 = ( test_mode && waddr == 16'b0000000000010111 )? value : reg23; 
	reg24 = ( test_mode && waddr == 16'b0000000000011000 )? value : reg24; 
	reg25 = ( test_mode && waddr == 16'b0000000000011001 )? value : reg25; 
	reg26 = ( test_mode && waddr == 16'b0000000000011010 )? value : reg26; 
	reg27 = ( test_mode && waddr == 16'b0000000000011011 )? value : reg27; 
	reg28 = ( test_mode && waddr == 16'b0000000000011100 )? value : reg28; 
	reg29 = ( test_mode && waddr == 16'b0000000000011101 )? value : reg29; 
	reg30 = ( test_mode && waddr == 16'b0000000000011110 )? value : reg30; 
	reg31 = ( test_mode && waddr == 16'b0000000000011111 )? value : reg31; 
	reg32 = ( test_mode && waddr == 16'b0000000000100000 )? value : reg32; 	
	
	reg1b_01 = (waddr == 16'b0000000100000000)? value[0] : reg1b_01;
	
	// read
	case(raddr)
		16'b0000000000000001: 	return = reg01;
		16'b0000000000000010: 	return = reg02;
		16'b0000000000000011: 	return = reg03;
		16'b0000000000000100: 	return = reg04;
		16'b0000000000000101:	return = reg05;
		16'b0000000000000110:	return = reg06;
		16'b0000000000000111:	return = reg07;
		16'b0000000000001000:	return = reg08;
		16'b0000000000001001:	return = reg09;
		16'b0000000000001010:	return = reg10;
		16'b0000000000001011:	return = reg11;
		16'b0000000000001100:	return = reg12;
		16'b0000000000001101:	return = reg13;
		16'b0000000000001110: 	return = reg14;
		16'b0000000000001111: 	return = reg15;
		16'b0000000000010000: 	return = reg16;
		16'b0000000000010001: 	return = reg17;
		16'b0000000000010010: 	return = reg18;
		16'b0000000000010011: 	return = reg19;
		16'b0000000000010100: 	return = reg20;
		16'b0000000000010101:	return = reg21;
		16'b0000000000010110:	return = reg22;
		16'b0000000000010111:	return = reg23;
		16'b0000000000011000:	return = reg24;
		16'b0000000000011001:	return = reg25;
		16'b0000000000011010:	return = reg26;
		16'b0000000000011011:	return = reg27;
		16'b0000000000011100:	return = reg28;
		16'b0000000000011101:	return = reg29;
		16'b0000000000011110: 	return = reg30;
		16'b0000000000011111: 	return = reg31;
		16'b0000000000100000: 	return = reg32;		
	endcase
	
	
end	
	
endmodule	