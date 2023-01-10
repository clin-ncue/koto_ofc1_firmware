module TLKErr_Packer(
	clk,
	LIVE,
	dv,
	errbit,
	q
);

input wire clk;
input wire LIVE;

input wire [17:0] dv;
input wire [17:0] errbit;


output reg q = 1'b0;

reg got_trig  = 1'b0;
reg [17:0] got = 18'b0;


reg [17:0] errbit_reg = 18'b111111111111111111;


reg send = 1'b0;

reg [4:0] ctrl = 5'b0;


always @(posedge clk)
begin

	if(~LIVE)
	begin
		got = 18'b0;
		errbit_reg = 18'b111111111111111111;
		send = 1'b0;
		ctrl = 5'b0;
		q = 1'b0;
	end
	
	got[ 0] = (dv[ 0]==1'b1 && ~send)? 1'b1 : got[ 0];
	got[ 1] = (dv[ 1]==1'b1 && ~send)? 1'b1 : got[ 1];
	got[ 2] = (dv[ 2]==1'b1 && ~send)? 1'b1 : got[ 2];
	got[ 3] = (dv[ 3]==1'b1 && ~send)? 1'b1 : got[ 3];
	got[ 4] = (dv[ 4]==1'b1 && ~send)? 1'b1 : got[ 4];
	got[ 5] = (dv[ 5]==1'b1 && ~send)? 1'b1 : got[ 5];
	got[ 6] = (dv[ 6]==1'b1 && ~send)? 1'b1 : got[ 6];
	got[ 7] = (dv[ 7]==1'b1 && ~send)? 1'b1 : got[ 7];
	got[ 8] = (dv[ 8]==1'b1 && ~send)? 1'b1 : got[ 8];
	got[ 9] = (dv[ 9]==1'b1 && ~send)? 1'b1 : got[ 9];
	got[10] = (dv[10]==1'b1 && ~send)? 1'b1 : got[10];
	got[11] = (dv[11]==1'b1 && ~send)? 1'b1 : got[11];
	got[12] = (dv[12]==1'b1 && ~send)? 1'b1 : got[12];
	got[13] = (dv[13]==1'b1 && ~send)? 1'b1 : got[13];
	got[14] = (dv[14]==1'b1 && ~send)? 1'b1 : got[14];
	got[15] = (dv[15]==1'b1 && ~send)? 1'b1 : got[15];
	got[16] = (dv[16]==1'b1 && ~send)? 1'b1 : got[16];
	got[17] = (dv[17]==1'b1 && ~send)? 1'b1 : got[17];
	
	if(got==18'b111111111111111111 && ~send)
	begin
		errbit_reg = errbit;
		send = 1'b1;
	end

	if(send)
	begin
		case(ctrl)
			5'b00000:	q = 1'b1;
			5'b00001:	q = 1'b0;
			5'b00010:	q = 1'b0;
			5'b00011: 	q = errbit_reg[ 0];
			5'b00100:	q = errbit_reg[ 1];
			5'b00101:	q = errbit_reg[ 2];
			5'b00110:	q = errbit_reg[ 3];
			5'b00111:	q = errbit_reg[ 4];
			5'b01000:	q = errbit_reg[ 5];
			5'b01001:	q = errbit_reg[ 6];
			5'b01010:	q = errbit_reg[ 7];
			5'b01011:	q = errbit_reg[ 8];
			5'b01100:	q = errbit_reg[ 9];
			5'b01101:	q = errbit_reg[10];
			5'b01110:	q = errbit_reg[11];
			5'b01111:	q = errbit_reg[12];
			5'b10000:	q = errbit_reg[13];
			5'b10001:	q = errbit_reg[14];
			5'b10010:	q = errbit_reg[15];
			5'b10011:	q = errbit_reg[16];
			5'b10100:	q = errbit_reg[17];
			5'b10101:   q = 1'b0;
			default: q = 1'b0;
		endcase	

		
		ctrl = (ctrl<30)? ctrl + 1'b1 : ctrl;
	end

end

endmodule
