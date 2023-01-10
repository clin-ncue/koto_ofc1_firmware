module VME_REG_GATE(
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
	in11,
	in12,
	in13,
	in14,
	in15,
	in16,
	in17,
	in18,
	in19,
	in20,
	in21,
	in22,
	in23,
	in24,
	in25,
	in26,
	in27,
	in28,
	in29,	
	in30,
	in31,
	in32,
	in33,
	in34,
	in35,
	in36,
	in37,
	in38,
	in39,	
	in40,
	in41,
	in42,
	in43,
	in44,
	in45,
	in46,
	in47,
	in48,
	in49,
	in50,
	in51,
	in52,
	in53,
	in54,
	in55,
	in56,
	in57,
	in58,
	in59,
	in60,
	in61,
	in62,
	in63,
	in64,
	in65,
	in66,
	in67,
	in68,
	in69,
	in70,
	in71,
	in72,
	clk,

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
	out10,
	out11,
	out12,
	out13,
	out14,
	out15,
	out16,
	out17,
	out18,
	out19,
	out20,
	out21,
	out22,
	out23,
	out24,
	out25,
	out26,
	out27,
	out28,
	out29,
	out30,
	out31,
	out32,
	out33,
	out34,
	out35,
	out36,
	out37,
	out38,
	out39,
	out40,
	out41,
	out42,
	out43,
	out44,
	out45,
	out46,
	out47,
	out48,
	out49,
	out50,
	out51,
	out52,
	out53,
	out54,
	out55,
	out56,
	out57,
	out58,
	out59,
	out60,
	out61,
	out62,
	out63,
	out64,
	out65,
	out66,
	out67,
	out68,
	out69,
	out70,
	out71,
	out72
);



input wire in00;
input wire in01;
input wire in02;
input wire in03;
input wire in04;
input wire in05;
input wire in06;
input wire in07;
input wire in08;
input wire in09;
input wire in10;
input wire in11;
input wire in12;
input wire in13;
input wire in14;

input wire [31:0] in15;
input wire [31:0] in16;
input wire [31:0] in17;
input wire [31:0] in18;
input wire [31:0] in19;
input wire [31:0] in20;
input wire [31:0] in21;
input wire [31:0] in22;
input wire [31:0] in23;
input wire [31:0] in24;
input wire [31:0] in25;
input wire [31:0] in26;
input wire [31:0] in27;
input wire [31:0] in28;
input wire [31:0] in29;
input wire [31:0] in30;
input wire [31:0] in31;
input wire [31:0] in32;
input wire [31:0] in33;
input wire [31:0] in34;
input wire [31:0] in35;
input wire [31:0] in36;
input wire [31:0] in37;
input wire [31:0] in38;
input wire [31:0] in39;
input wire [31:0] in40;
input wire [31:0] in41;
input wire [31:0] in42;
input wire [31:0] in43;
input wire [31:0] in44;
input wire [31:0] in45;
input wire [31:0] in46;
input wire [31:0] in47;
input wire [31:0] in48;
input wire [31:0] in49;
input wire [31:0] in50;
input wire [31:0] in51;
input wire [31:0] in52;
input wire [31:0] in53;
input wire [31:0] in54;
input wire [31:0] in55;
input wire [31:0] in56;
input wire [31:0] in57;
input wire [31:0] in58;
input wire [31:0] in59;
input wire [31:0] in60;
input wire [31:0] in61;
input wire [31:0] in62;
input wire [31:0] in63;
input wire [31:0] in64;
input wire [31:0] in65;
input wire [31:0] in66;
input wire [31:0] in67;
input wire [31:0] in68;
input wire [31:0] in69;
input wire [31:0] in70;
input wire [31:0] in71;
input wire [31:0] in72;

input wire clk;

output reg out00;
output reg out01;
output reg out02;
output reg out03;
output reg out04;
output reg out05;
output reg out06;
output reg out07;
output reg out08;
output reg out09;
output reg out10;
output reg out11;
output reg out12;
output reg out13;
output reg out14;

output reg [31:0] out15;
output reg [31:0] out16;
output reg [31:0] out17;
output reg [31:0] out18;
output reg [31:0] out19;
output reg [31:0] out20;
output reg [31:0] out21;
output reg [31:0] out22;
output reg [31:0] out23;
output reg [31:0] out24;
output reg [31:0] out25;
output reg [31:0] out26;
output reg [31:0] out27;
output reg [31:0] out28;
output reg [31:0] out29;
output reg [31:0] out30;
output reg [31:0] out31;
output reg [31:0] out32;
output reg [31:0] out33;
output reg [31:0] out34;
output reg [31:0] out35;
output reg [31:0] out36;
output reg [31:0] out37;
output reg [31:0] out38;
output reg [31:0] out39;
output reg [31:0] out40;
output reg [31:0] out41;
output reg [31:0] out42;
output reg [31:0] out43;
output reg [31:0] out44;
output reg [31:0] out45;
output reg [31:0] out46;
output reg [31:0] out47;
output reg [31:0] out48;
output reg [31:0] out49;
output reg [31:0] out50;
output reg [31:0] out51;
output reg [31:0] out52;
output reg [31:0] out53;
output reg [31:0] out54;
output reg [31:0] out55;
output reg [31:0] out56;
output reg [31:0] out57;
output reg [31:0] out58;
output reg [31:0] out59;
output reg [31:0] out60;
output reg [31:0] out61;
output reg [31:0] out62;
output reg [31:0] out63;
output reg [31:0] out64;
output reg [31:0] out65;
output reg [31:0] out66;
output reg [31:0] out67;
output reg [31:0] out68;
output reg [31:0] out69;
output reg [31:0] out70;
output reg [31:0] out71;
output reg [31:0] out72;


reg a00;
reg a01;
reg a02;
reg a03;
reg a04;
reg a05;
reg a06;
reg a07;
reg a08;
reg a09;
reg a10;
reg a11;
reg a12;
reg a13;
reg a14;

reg [31:0] a15;
reg [31:0] a16;
reg [31:0] a17;
reg [31:0] a18;
reg [31:0] a19;
reg [31:0] a20;
reg [31:0] a21;
reg [31:0] a22;
reg [31:0] a23;
reg [31:0] a24;
reg [31:0] a25;
reg [31:0] a26;
reg [31:0] a27;
reg [31:0] a28;
reg [31:0] a29;
reg [31:0] a30;
reg [31:0] a31;
reg [31:0] a32;
reg [31:0] a33;
reg [31:0] a34;
reg [31:0] a35;
reg [31:0] a36;
reg [31:0] a37;
reg [31:0] a38;
reg [31:0] a39;
reg [31:0] a40;
reg [31:0] a41;
reg [31:0] a42;
reg [31:0] a43;
reg [31:0] a44;
reg [31:0] a45;
reg [31:0] a46;
reg [31:0] a47;
reg [31:0] a48;
reg [31:0] a49;
reg [31:0] a50;
reg [31:0] a51;
reg [31:0] a52;
reg [31:0] a53;
reg [31:0] a54;
reg [31:0] a55;
reg [31:0] a56;
reg [31:0] a57;
reg [31:0] a58;
reg [31:0] a59;
reg [31:0] a60;
reg [31:0] a61;
reg [31:0] a62;
reg [31:0] a63;
reg [31:0] a64;
reg [31:0] a65;
reg [31:0] a66;
reg [31:0] a67;
reg [31:0] a68;
reg [31:0] a69;
reg [31:0] a70;
reg [31:0] a71;
reg [31:0] a72;

always @(posedge clk)
begin

	out00 <= a00; a00 <= in00;
	out01 <= a01; a01 <= in01;
	out02 <= a02; a02 <= in02;
	out03 <= a03; a03 <= in03;
	out04 <= a04; a04 <= in04;
	out05 <= a05; a05 <= in05;
	out06 <= a06; a06 <= in06;
	out07 <= a07; a07 <= in07;
	out08 <= a08; a08 <= in08;
	out09 <= a09; a09 <= in09;
	out10 <= a10; a10 <= in10;
	out11 <= a11; a11 <= in11;
	out12 <= a12; a12 <= in12;
	out13 <= a13; a13 <= in13;
	out14 <= a14; a14 <= in14;
	out15 <= a15; a15 <= in15;
	out16 <= a16; a16 <= in16;
	out17 <= a17; a17 <= in17;
	out18 <= a18; a18 <= in18;
	out19 <= a19; a19 <= in19;
	out20 <= a20; a20 <= in20;
	out21 <= a21; a21 <= in21;
	out22 <= a22; a22 <= in22;
	out23 <= a23; a23 <= in23;
	out24 <= a24; a24 <= in24;
	out25 <= a25; a25 <= in25;
	out26 <= a26; a26 <= in26;
	out27 <= a27; a27 <= in27;
	out28 <= a28; a28 <= in28;
	out29 <= a29; a29 <= in29;
	out30 <= a30; a30 <= in30;
	out31 <= a31; a31 <= in31;
	out32 <= a32; a32 <= in32;
	out33 <= a33; a33 <= in33;
	out34 <= a34; a34 <= in34;
	out35 <= a35; a35 <= in35;
	out36 <= a36; a36 <= in36;
	out37 <= a37; a37 <= in37;
	out38 <= a38; a38 <= in38;
	out39 <= a39; a39 <= in39;
	out40 <= a40; a40 <= in40;
	out41 <= a41; a41 <= in41;
	out42 <= a42; a42 <= in42;
	out43 <= a43; a43 <= in43;
	out44 <= a44; a44 <= in44;
	out45 <= a45; a45 <= in45;
	out46 <= a46; a46 <= in46;
	out47 <= a47; a47 <= in47;
	out48 <= a48; a48 <= in48;
	out49 <= a49; a49 <= in49;
	out50 <= a50; a50 <= in50;
	out51 <= a51; a51 <= in51;
	out52 <= a52; a52 <= in52;
	out53 <= a53; a53 <= in53;
	out54 <= a54; a54 <= in54;
	out55 <= a55; a55 <= in55;
	out56 <= a56; a56 <= in56;
	out57 <= a57; a57 <= in57;
	out58 <= a58; a58 <= in58;
	out59 <= a59; a59 <= in59;
	out60 <= a60; a60 <= in60;
	out61 <= a61; a61 <= in61;
	out62 <= a62; a62 <= in62;
	out63 <= a63; a63 <= in63;
	out64 <= a64; a64 <= in64;
	out65 <= a65; a65 <= in65;
	out66 <= a66; a66 <= in66;
	out67 <= a67; a67 <= in67;
	out68 <= a68; a68 <= in68;
	out69 <= a69; a69 <= in69;
	out70 <= a70; a70 <= in70;
	out71 <= a71; a71 <= in71;
	out72 <= a72; a72 <= in72;

end


endmodule

