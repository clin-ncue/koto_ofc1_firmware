module JayFile(
	clk,
	LIVE,
	ENA,
	et,
	thres,
	q,
	waddr,
	wena,
	ntrig
);

input wire clk;
input wire LIVE;
input wire ENA;
input wire [15:0] et;
input wire [15:0] thres;


output reg [31:0] q;
output reg [15:0] waddr;
output reg wena = 1'b0;
output reg [31:0] ntrig = 32'b0;

reg [29:0] timestamp = 30'b0;

reg [31:0] pipe_live = 32'h00000000;
reg [15:0] pipe_et [2:0];

reg [1:0] nspill = 2'b00;

reg LIVE_posedge = 1'b0;
reg LIVE_negedge = 1'b0;
reg LIVE_level = 1'b0;
reg trig_l1a = 1'b0;


always @(posedge clk)
begin
	
	pipe_et[2] <= pipe_et[1];
	pipe_et[1] <= pipe_et[0];
	pipe_et[0] <= et;
	
	pipe_live <= pipe_live << 1;
	pipe_live[0] <= LIVE;
	
	LIVE_posedge = (pipe_live[15:0]==16'hFFFF && pipe_live[31:16]==16'h0000)? 1'b1 : 1'b0;
	LIVE_negedge = (pipe_live[15:0]==16'h0000 && pipe_live[31:16]==16'hFFFF)? 1'b0 : 1'b1;
	LIVE_level = (LIVE_posedge==1'b1)? 1'b1 : LIVE_level;
	LIVE_level = (LIVE_negedge==1'b1)? 1'b0 : LIVE_level;
	
	if(ENA)
	begin
	
		if(LIVE_posedge)
		begin
			ntrig = 32'h00000000;
			waddr = 16'hFFFF;
			wena = 1'b0;
			timestamp = 30'b0;
			nspill = nspill + 1'b1;
		end

		trig_l1a = (LIVE_level && pipe_et[1]>pipe_et[0] && pipe_et[1]>pipe_et[2] && pipe_et[1]>thres)? 1'b1 : 1'b0;
	
		if(trig_l1a)
		begin
			q[31:0] = {nspill[1:0],timestamp[29:0]};
			waddr = waddr + 1'b1;
			wena = 1'b1;
			ntrig = ntrig + 1'b1;
		end
		else
		begin
			q[31:0] = 32'h00000000;
			wena = 1'b0;
		end
	
		timestamp = timestamp + 1'b1;
		
	end	
	else
	begin
		wena = 1'b0;
	end

end


endmodule
