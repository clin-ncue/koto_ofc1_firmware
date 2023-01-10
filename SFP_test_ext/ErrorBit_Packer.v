module ErrorBit_Packer(
	clk,
	LIVE,
	trig_align,
	maxt,
	dv_et,
	errbit_et,
	dv_veto,
	errbit_veto,
	q
);

input wire clk;
input wire LIVE;
input wire trig_align;
input wire [8:0] maxt;

input wire dv_et;
input wire [10:0] errbit_et;

input wire dv_veto;
input wire [6:0] errbit_veto;

output reg q;


reg [8:0] timer;
reg got_trig  = 1'b0;
reg got_et = 1'b0;
reg got_veto = 1'b0;

reg [10:0] errbit_et_reg = 11'b11111111111;
reg [6:0] errbit_veto_reg = 7'b1111111;

reg send = 1'b0;

reg [4:0] ctrl = 5'b0;

reg [2:0] header;

always @(posedge clk)
begin

	if(~LIVE)
	begin
		timer = 9'b0;
		got_trig = 1'b0;
		got_et = 1'b0;
		got_veto = 1'b0;
		errbit_et_reg = 11'b11111111111;
		errbit_veto_reg = 7'b1111111;
		send = 1'b0;
		ctrl = 5'b0;
	end

	got_trig = (trig_align==1'b1 && ~send)? 1'b1 : got_trig;
	
	if(got_trig && ~send)
	begin
		send = (timer>maxt)? 1'b1 : 1'b0;
		timer = timer + 1'b1;
	end
	
	if(dv_et==1'b1 && ~send)
	begin
		errbit_et_reg = errbit_et;
		got_et = 1'b1;
	end
	
	if(dv_veto==1'b1 && ~send)
	begin
		errbit_veto_reg = errbit_veto;
		got_veto = 1'b1;
	end	
	
	send = (got_et && got_veto && ~send)? 1'b1 : send;
	
	if(send)
	begin
		case(ctrl)
			5'b00000:	q = 1'b1;
			5'b00001:	q = 1'b0;
			5'b00010:	q = 1'b1;
			5'b00011: 	q = got_et;
			5'b00100:	q = got_veto;
			5'b00101:	q = errbit_et_reg[ 0];
			5'b00110:	q = errbit_et_reg[ 1];
			5'b00111:	q = errbit_et_reg[ 2];
			5'b01000:	q = errbit_et_reg[ 3];
			5'b01001:	q = errbit_et_reg[ 4];
			5'b01010:	q = errbit_et_reg[ 5];
			5'b01011:	q = errbit_et_reg[ 6];
			5'b01100:	q = errbit_et_reg[ 7];
			5'b01101:	q = errbit_et_reg[ 8];
			5'b01110:	q = errbit_et_reg[ 9];
			5'b01111:	q = errbit_et_reg[10];
			5'b10000:	q = errbit_veto_reg[ 0];
			5'b10001:	q = errbit_veto_reg[ 1];
			5'b10010:	q = errbit_veto_reg[ 2];
			5'b10011:	q = errbit_veto_reg[ 3];
			5'b10100:	q = errbit_veto_reg[ 4];
			5'b10101:	q = errbit_veto_reg[ 5];
			5'b10110:	q = errbit_veto_reg[ 6];
			5'b10111:   q = 1'b0;
			default: q = 1'b0;
		endcase	

		
		ctrl = (ctrl<30)? ctrl + 1'b1 : ctrl;
	end

end

endmodule
