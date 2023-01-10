module Update_TLKERR(
	clk,
	live,
	send_err,
	tlk_err,
	q
);

input wire clk;
input wire live;
input wire [17:0] send_err;
input wire [17:0] tlk_err;

output reg [31:0] q;

always @(posedge clk)
begin

	q = (~live)? 32'h3FFFF : q;
	
	q[ 0] = (send_err[ 0]==1'b1)? tlk_err[ 0] : q[ 0];
	q[ 1] = (send_err[ 1]==1'b1)? tlk_err[ 1] : q[ 1];
	q[ 2] = (send_err[ 2]==1'b1)? tlk_err[ 2] : q[ 2];
	q[ 3] = (send_err[ 3]==1'b1)? tlk_err[ 3] : q[ 3];
	q[ 4] = (send_err[ 4]==1'b1)? tlk_err[ 4] : q[ 4];
	q[ 5] = (send_err[ 5]==1'b1)? tlk_err[ 5] : q[ 5];
	q[ 6] = (send_err[ 6]==1'b1)? tlk_err[ 6] : q[ 6];
	q[ 7] = (send_err[ 7]==1'b1)? tlk_err[ 7] : q[ 7];
	q[ 8] = (send_err[ 8]==1'b1)? tlk_err[ 8] : q[ 8];
	q[ 9] = (send_err[ 9]==1'b1)? tlk_err[ 9] : q[ 9];
	q[10] = (send_err[10]==1'b1)? tlk_err[10] : q[10];
	q[11] = (send_err[11]==1'b1)? tlk_err[11] : q[11];
	q[12] = (send_err[12]==1'b1)? tlk_err[12] : q[12];
	q[13] = (send_err[13]==1'b1)? tlk_err[13] : q[13];
	q[14] = (send_err[14]==1'b1)? tlk_err[14] : q[14];
	q[15] = (send_err[15]==1'b1)? tlk_err[15] : q[15];
	q[16] = (send_err[16]==1'b1)? tlk_err[16] : q[16];
	q[17] = (send_err[17]==1'b1)? tlk_err[17] : q[17];
	
	
end

endmodule
