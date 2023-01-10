module mapping_cratex
(
	clk,
	rst,
	fiber,
	fxch00,
	fxch01,
	fxch02,
	fxch03,
	fxch04,
	fxch05,
	fxch06,
	fxch07,
	fxch08,
	fxch09,
	fxch10,
	fxch11,
	fxch12,
	fxch13,
	fxch14,
	fxch15,

	array_header,
	array_out00,
	array_out01,
	array_out02,
	array_out03,
	array_out04,
	array_out05,
	array_out06,
	array_out07,
	array_out08,
	array_out09,
	array_out10,
	array_out11,
	array_out12,
	array_out13,
	array_out14,
	array_out15,
	array_out16,
	array_out17,
	array_out18,
	array_out19,
	array_out20,
	array_out21,
	array_out22,
	array_out23,
	array_out24,
	array_out25,
	array_out26,
	array_out27,
	array_out28,
	array_out29,
	array_out30,
	array_out31,
	array_out32,
	array_out33,
	array_out34,
	array_out35,
	array_out36,
	array_out37	
);

input wire clk;
input wire rst;
input wire [24:0] fiber;

input wire [15:0] fxch00;
input wire [15:0] fxch01;
input wire [15:0] fxch02;
input wire [15:0] fxch03;
input wire [15:0] fxch04;
input wire [15:0] fxch05;
input wire [15:0] fxch06;
input wire [15:0] fxch07;
input wire [15:0] fxch08;
input wire [15:0] fxch09;
input wire [15:0] fxch10;
input wire [15:0] fxch11;
input wire [15:0] fxch12;
input wire [15:0] fxch13;
input wire [15:0] fxch14;
input wire [15:0] fxch15;

output reg [15:0] array_header;
output reg [37:0] array_out00;
output reg [37:0] array_out01;
output reg [37:0] array_out02;
output reg [37:0] array_out03;
output reg [37:0] array_out04;
output reg [37:0] array_out05;
output reg [37:0] array_out06;
output reg [37:0] array_out07;
output reg [37:0] array_out08;
output reg [37:0] array_out09;
output reg [37:0] array_out10;
output reg [37:0] array_out11;
output reg [37:0] array_out12;
output reg [37:0] array_out13;
output reg [37:0] array_out14;
output reg [37:0] array_out15;
output reg [37:0] array_out16;
output reg [37:0] array_out17;
output reg [37:0] array_out18;
output reg [37:0] array_out19;
output reg [37:0] array_out20;
output reg [37:0] array_out21;
output reg [37:0] array_out22;
output reg [37:0] array_out23;
output reg [37:0] array_out24;
output reg [37:0] array_out25;
output reg [37:0] array_out26;
output reg [37:0] array_out27;
output reg [37:0] array_out28;
output reg [37:0] array_out29;
output reg [37:0] array_out30;
output reg [37:0] array_out31;
output reg [37:0] array_out32;
output reg [37:0] array_out33;
output reg [37:0] array_out34;
output reg [37:0] array_out35;
output reg [37:0] array_out36;
output reg [37:0] array_out37;

reg [37:0] array00;
reg [37:0] array01;
reg [37:0] array02;
reg [37:0] array03;
reg [37:0] array04;
reg [37:0] array05;
reg [37:0] array06;
reg [37:0] array07;
reg [37:0] array08;
reg [37:0] array09;
reg [37:0] array10;
reg [37:0] array11;
reg [37:0] array12;
reg [37:0] array13;
reg [37:0] array14;
reg [37:0] array15;
reg [37:0] array16;
reg [37:0] array17;
reg [37:0] array18;
reg [37:0] array19;
reg [37:0] array20;
reg [37:0] array21;
reg [37:0] array22;
reg [37:0] array23;
reg [37:0] array24;
reg [37:0] array25;
reg [37:0] array26;
reg [37:0] array27;
reg [37:0] array28;
reg [37:0] array29;
reg [37:0] array30;
reg [37:0] array31;
reg [37:0] array32;
reg [37:0] array33;
reg [37:0] array34;
reg [37:0] array35;
reg [37:0] array36;
reg [37:0] array37;


reg ena;
reg srst;

reg dv;
reg c;
reg [5:0] x;
reg [5:0] y;
reg [5:0] control;
reg done;



always @( posedge clk ) 
begin

	if(rst || srst)
	begin
		ena = 1'b0;
		control = 6'b0;
		done = 1'b0;
		srst = 1'b0;
		array00[37:0] = 38'b0;
		array01[37:0] = 38'b0;
		array02[37:0] = 38'b0;
		array03[37:0] = 38'b0;
		array04[37:0] = 38'b0;
		array05[37:0] = 38'b0;
		array06[37:0] = 38'b0;
		array07[37:0] = 38'b0;
		array08[37:0] = 38'b0;
		array09[37:0] = 38'b0;
		array10[37:0] = 38'b0;	
		array11[37:0] = 38'b0;
		array12[37:0] = 38'b0;
		array13[37:0] = 38'b0;
		array14[37:0] = 38'b0;
		array15[37:0] = 38'b0;
		array16[37:0] = 38'b0;
		array17[37:0] = 38'b0;
		array18[37:0] = 38'b0;
		array19[37:0] = 38'b0;
		array20[37:0] = 38'b0;
		array21[37:0] = 38'b0;
		array22[37:0] = 38'b0;
		array23[37:0] = 38'b0;
		array24[37:0] = 38'b0;
		array25[37:0] = 38'b0;
		array26[37:0] = 38'b0;
		array27[37:0] = 38'b0;
		array28[37:0] = 38'b0;
		array29[37:0] = 38'b0;
		array30[37:0] = 38'b0;
		array31[37:0] = 38'b0;
		array32[37:0] = 38'b0;
		array33[37:0] = 38'b0;
		array34[37:0] = 38'b0;
		array35[37:0] = 38'b0;
		array36[37:0] = 38'b0;
		array37[37:0] = 38'b0;

	
	end

	ena = (fiber[15:0]==16'b1010101010101010)? 1'b1:ena;
	
	if(ena)
	begin

		if(control>=1&&control<=16)
		begin
//
//
		end	
		else if(control==17)
		begin	
			done = 1'b1;
		end
		else if(control==18)
		begin	
			done = 1'b0;
			srst = 1'b1;
			ena = 1'b0;				
		end		
		control = control + 1'b1;
	end // end of ena
	
	array_out00[37:0] = (done==1'b1)? array00[37:0] : 38'b0;
	array_out01[37:0] = (done==1'b1)? array01[37:0] : 38'b0;
	array_out02[37:0] = (done==1'b1)? array02[37:0] : 38'b0;
	array_out03[37:0] = (done==1'b1)? array03[37:0] : 38'b0;
	array_out04[37:0] = (done==1'b1)? array04[37:0] : 38'b0;
	array_out05[37:0] = (done==1'b1)? array05[37:0] : 38'b0;
	array_out06[37:0] = (done==1'b1)? array06[37:0] : 38'b0;
	array_out07[37:0] = (done==1'b1)? array07[37:0] : 38'b0;
	array_out08[37:0] = (done==1'b1)? array08[37:0] : 38'b0;
	array_out09[37:0] = (done==1'b1)? array09[37:0] : 38'b0;
	array_out10[37:0] = (done==1'b1)? array10[37:0] : 38'b0;
	array_out11[37:0] = (done==1'b1)? array11[37:0] : 38'b0;
	array_out12[37:0] = (done==1'b1)? array12[37:0] : 38'b0;
	array_out13[37:0] = (done==1'b1)? array13[37:0] : 38'b0;
	array_out14[37:0] = (done==1'b1)? array14[37:0] : 38'b0;
	array_out15[37:0] = (done==1'b1)? array15[37:0] : 38'b0;
	array_out16[37:0] = (done==1'b1)? array16[37:0] : 38'b0;
	array_out17[37:0] = (done==1'b1)? array17[37:0] : 38'b0;
	array_out18[37:0] = (done==1'b1)? array18[37:0] : 38'b0;
	array_out19[37:0] = (done==1'b1)? array19[37:0] : 38'b0;
	array_out20[37:0] = (done==1'b1)? array20[37:0] : 38'b0;
	array_out21[37:0] = (done==1'b1)? array21[37:0] : 38'b0;
	array_out22[37:0] = (done==1'b1)? array22[37:0] : 38'b0;
	array_out23[37:0] = (done==1'b1)? array23[37:0] : 38'b0;
	array_out24[37:0] = (done==1'b1)? array24[37:0] : 38'b0;
	array_out25[37:0] = (done==1'b1)? array25[37:0] : 38'b0;
	array_out26[37:0] = (done==1'b1)? array26[37:0] : 38'b0;
	array_out27[37:0] = (done==1'b1)? array27[37:0] : 38'b0;
	array_out28[37:0] = (done==1'b1)? array28[37:0] : 38'b0;
	array_out29[37:0] = (done==1'b1)? array29[37:0] : 38'b0;
	array_out30[37:0] = (done==1'b1)? array30[37:0] : 38'b0;
	array_out31[37:0] = (done==1'b1)? array31[37:0] : 38'b0;
	array_out32[37:0] = (done==1'b1)? array32[37:0] : 38'b0;
	array_out33[37:0] = (done==1'b1)? array33[37:0] : 38'b0;
	array_out34[37:0] = (done==1'b1)? array34[37:0] : 38'b0;
	array_out35[37:0] = (done==1'b1)? array35[37:0] : 38'b0;
	array_out36[37:0] = (done==1'b1)? array36[37:0] : 38'b0;
	array_out37[37:0] = (done==1'b1)? array37[37:0] : 38'b0;	
	
end // always


endmodule