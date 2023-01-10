module Fiber_Alignment(
	clk,
	rst,
	in00,
	in01,
	in02,
	in03,
	in04,
	in05,
	in06,
	in07,
	in08,
	in09,
	in10,
	
	out00,
	out01,
	out02,
	out03,
	out04,
	out05,
	out06,
	out07,
	out08,
	out09,
	out10
);

input wire clk;
input wire rst;
input wire [15:0] in00;
input wire [15:0] in01;
input wire [15:0] in02;
input wire [15:0] in03;
input wire [15:0] in04;
input wire [15:0] in05;
input wire [15:0] in06;
input wire [15:0] in07;
input wire [15:0] in08;
input wire [15:0] in09;
input wire [15:0] in10;


output [15:0] out00;
output [15:0] out01;
output [15:0] out02;
output [15:0] out03;
output [15:0] out04;
output [15:0] out05;
output [15:0] out06;
output [15:0] out07;
output [15:0] out08;
output [15:0] out09;
output [15:0] out10;

reg srst;
reg lock;
reg [5:0] control = 6'b000000;

wire got00;
wire got01;
wire got02;
wire got03;
wire got04;
wire got05;
wire got06;
wire got07;
wire got08;
wire got09;
wire got10;

wire rst_or = rst | srst;
wire got_or = got00 | got01 | got02 | got03 | got04 | got05 | got06 | got07 | got08 | got09 | got10;
wire got_and = got00 & got01 & got02 & got03 & got04 & got05 & got06 & got07 & got08 & got09 & got10;

Shift_Taps _tap00(clk,rst_or,lock,in00,got00,out00);
Shift_Taps _tap01(clk,rst_or,lock,in01,got01,out01);
Shift_Taps _tap02(clk,rst_or,lock,in02,got02,out02);
Shift_Taps _tap03(clk,rst_or,lock,in03,got03,out03);
Shift_Taps _tap04(clk,rst_or,lock,in04,got04,out04);
Shift_Taps _tap05(clk,rst_or,lock,in05,got05,out05);
Shift_Taps _tap06(clk,rst_or,lock,in06,got06,out06);
Shift_Taps _tap07(clk,rst_or,lock,in07,got07,out07);
Shift_Taps _tap08(clk,rst_or,lock,in08,got08,out08);
Shift_Taps _tap09(clk,rst_or,lock,in09,got09,out09);
Shift_Taps _tap10(clk,rst_or,lock,in10,got10,out10);





always @(posedge clk)
begin

	if( rst || srst)
	begin
		lock = 1'b0;
		control = 6'b000000;
		srst = 1'b0;
	end

	if(~lock && got_or && ~got_and)
	begin
		
		srst = (control==28)? 1'b1:1'b0; 
		
		control = control + 1'b1;
	end

	lock = (got_and==1'b1)? 1'b1 : lock;
	
end


endmodule

////////////////////////////////////////////////////////////////////

module Shift_Taps (
	clk, 
	rst,
	lock,      
	sr_in,
	got,
	sr_out,
);

input wire clk;
input wire rst;
input wire lock;
input wire [15:0] sr_in;
    
output reg got;    
output reg [15:0] sr_out;

reg [15:0] sr [31:0];

integer n, ptr;


always@(posedge clk)
begin

	if(rst)
	begin
		got = 1'b0;
		ptr = 0;
	end

	for (n = 31; n>0; n = n-1)
	begin
		sr[n] <= sr[n-1];
	end

	sr[0] <= sr_in;
	
	if( ~got && ~lock && sr[0] == 16'b1010101010101010 )
	begin
		got = 1'b1;
		ptr = 0;
	end
	
	if( got && ~lock ) 
	begin
		ptr = ptr + 1'b1;
	end
	
	if(lock)
	begin
		sr_out <= sr[ptr+1];
	end
	else
	begin
		sr_out <= 16'b0;
	end
end


endmodule