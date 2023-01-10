module Cluster_Counter
(
	clk,
	rst,
	array_header,
	array_in0,
	array_in1,
	nturn_out
);


input wire clk;
input wire rst;
input wire [15:0] array_header;
input wire [37:0] array_in0;
input wire [37:0] array_in1;

output reg [8:0] nturn_out;


reg [37:0] array0 = 0;
reg [37:0] array1 = 0;

wire [2:0] iturn [36:0];
wire [8:0] turn_sum;

TURN_2x2 iturn_00(clk,array0[0],array0[1],array1[0],array1[1],iturn[0]);
TURN_2x2 iturn_01(clk,array0[1],array0[2],array1[1],array1[2],iturn[1]);
TURN_2x2 iturn_02(clk,array0[2],array0[3],array1[2],array1[3],iturn[2]);
TURN_2x2 iturn_03(clk,array0[3],array0[4],array1[3],array1[4],iturn[3]);
TURN_2x2 iturn_04(clk,array0[4],array0[5],array1[4],array1[5],iturn[4]);
TURN_2x2 iturn_05(clk,array0[5],array0[6],array1[5],array1[6],iturn[5]);
TURN_2x2 iturn_06(clk,array0[6],array0[7],array1[6],array1[7],iturn[6]);
TURN_2x2 iturn_07(clk,array0[7],array0[8],array1[7],array1[8],iturn[7]);
TURN_2x2 iturn_08(clk,array0[8],array0[9],array1[8],array1[9],iturn[8]);
TURN_2x2 iturn_09(clk,array0[9],array0[10],array1[9],array1[10],iturn[9]);
TURN_2x2 iturn_10(clk,array0[10],array0[11],array1[10],array1[11],iturn[10]);
TURN_2x2 iturn_11(clk,array0[11],array0[12],array1[11],array1[12],iturn[11]);
TURN_2x2 iturn_12(clk,array0[12],array0[13],array1[12],array1[13],iturn[12]);
TURN_2x2 iturn_13(clk,array0[13],array0[14],array1[13],array1[14],iturn[13]);
TURN_2x2 iturn_14(clk,array0[14],array0[15],array1[14],array1[15],iturn[14]);
TURN_2x2 iturn_15(clk,array0[15],array0[16],array1[15],array1[16],iturn[15]);
TURN_2x2 iturn_16(clk,array0[16],array0[17],array1[16],array1[17],iturn[16]);
TURN_2x2 iturn_17(clk,array0[17],array0[18],array1[17],array1[18],iturn[17]);
TURN_2x2 iturn_18(clk,array0[18],array0[19],array1[18],array1[19],iturn[18]);
TURN_2x2 iturn_19(clk,array0[19],array0[20],array1[19],array1[20],iturn[19]);
TURN_2x2 iturn_20(clk,array0[20],array0[21],array1[20],array1[21],iturn[20]);
TURN_2x2 iturn_21(clk,array0[21],array0[22],array1[21],array1[22],iturn[21]);
TURN_2x2 iturn_22(clk,array0[22],array0[23],array1[22],array1[23],iturn[22]);
TURN_2x2 iturn_23(clk,array0[23],array0[24],array1[23],array1[24],iturn[23]);
TURN_2x2 iturn_24(clk,array0[24],array0[25],array1[24],array1[25],iturn[24]);
TURN_2x2 iturn_25(clk,array0[25],array0[26],array1[25],array1[26],iturn[25]);
TURN_2x2 iturn_26(clk,array0[26],array0[27],array1[26],array1[27],iturn[26]);
TURN_2x2 iturn_27(clk,array0[27],array0[28],array1[27],array1[28],iturn[27]);
TURN_2x2 iturn_28(clk,array0[28],array0[29],array1[28],array1[29],iturn[28]);
TURN_2x2 iturn_29(clk,array0[29],array0[30],array1[29],array1[30],iturn[29]);
TURN_2x2 iturn_30(clk,array0[30],array0[31],array1[30],array1[31],iturn[30]);
TURN_2x2 iturn_31(clk,array0[31],array0[32],array1[31],array1[32],iturn[31]);
TURN_2x2 iturn_32(clk,array0[32],array0[33],array1[32],array1[33],iturn[32]);
TURN_2x2 iturn_33(clk,array0[33],array0[34],array1[33],array1[34],iturn[33]);
TURN_2x2 iturn_34(clk,array0[34],array0[35],array1[34],array1[35],iturn[34]);
TURN_2x2 iturn_35(clk,array0[35],array0[36],array1[35],array1[36],iturn[35]);
TURN_2x2 iturn_36(clk,array0[36],array0[37],array1[36],array1[37],iturn[36]);

Parallel_Add37_3b _adder(
	clk,
	iturn[0],iturn[1],iturn[2],iturn[3],iturn[4],iturn[5],iturn[6],iturn[7],
	iturn[8],iturn[9],iturn[10],iturn[11],iturn[12],iturn[13],iturn[14],iturn[15],
	iturn[16],iturn[17],iturn[18],iturn[19],iturn[20],iturn[21],iturn[22],iturn[23],
	iturn[24],iturn[25],iturn[26],iturn[27],iturn[28],iturn[29],iturn[30],iturn[31],
	iturn[32],iturn[33],iturn[34],iturn[35],iturn[36], 
	turn_sum
);


integer i;

always @( posedge clk ) 
begin

	if( rst )
	begin
		array0 = 0;
		array1 = 0;
		nturn_out[8:0] = 9'b0;
	end



	
	if(array_header==16'b1010101010101010)
	begin
		array0 = array_in0;
		array1 = array_in1;	
	end
	else 
	begin	
		array0 = 38'b0;
		array1 = 38'b0;		
	end
	
	nturn_out[8:0] = turn_sum[8:0];
//	nturn_out[6:0] = sum_all[6:0];	

end // of always

endmodule

module TURN_2x2(clk,A,B,C,D,iturn);

input wire clk;
input wire A;
input wire B;
input wire C;
input wire D;

reg [2:0] sum;

output reg [2:0] iturn;

always @(posedge clk)
begin

	sum = A + B + C + D;
	case(sum)
		3'b001: 
			begin
				iturn = 1;
			end
		3'b011:	
			begin
				iturn = -1;
			end
		default:
			begin
				iturn = 3'b000;
			end
	endcase
	
	//C D
	//A B
	if( A==1'b1 && D == 1'b1 && B == 1'b0 && C == 1'b0 )
	begin
		iturn = -2;
	end
	else if( A==1'b0 && D == 1'b0 && B == 1'b1 && C == 1'b1 )	
	begin
		iturn = -2;
	end
	else
	begin
		iturn = iturn;
	end
end
endmodule
