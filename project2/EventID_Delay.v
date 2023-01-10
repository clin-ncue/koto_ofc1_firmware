module EventID_Delay(
	clk,
	delay,
	ID_in,
	ID_out
);

input wire clk;
input wire [8:0] delay;
input wire [9:0] ID_in;

output reg [9:0] ID_out;

reg [8:0] raddr = 1'b0;
reg [8:0] waddr = 1'b1;
wire [9:0] q_wire;

Event_Buffer _buffer(clk,ID_in,raddr,waddr,1'b1,q_wire);



always @(posedge clk)
begin

	waddr = waddr + 1'b1;
	raddr = waddr -1'b1 - delay;
	ID_out = q_wire;

end

endmodule

