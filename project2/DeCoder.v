module DeCoder
( 	
	clk, 
	rst, 
	tag, 
	x, 
	y, 
	c, 
	dv, 
	eventID,
	array, 
	wena, 
	clear,
	done
);

input wire clk;
input wire rst;
input wire [15:0] tag;
input wire [5:0] x;
input wire [5:0] y;
input wire c;
input wire dv;

output reg [15:0] eventID;
output reg [37:0] array;
output reg [38:0] wena;
output reg clear;
output reg done;



reg srst = 1'b0; 
reg ena = 1'b0;
reg [5:0] control = 0;

always @( posedge clk ) 
begin

	if(rst || srst)
	begin
		array = 38'b0;
		ena = 1'b0;
		control = 6'b0;
		wena = 39'b0;
		srst = 1'b0;
		done = 1'b0;
		eventID = 16'b0;
	end

	ena = (tag==16'b1010101010101010)? 1'b1:ena;

	if(ena)
	begin
		control = control + 1'b1;
		
		if(control==1)
		begin	
			wena = 39'b0;
			clear = 1'b1;
		end
		else if(control>=2&&control<=17)
		begin
			clear = 1'b0; 
			wena = 39'b1 << (y+1'b1);
			array = (dv==1'b1&&c==1'b1)? 38'b1 << (x+1'b1) : 38'b0;
		end
		else if(control==18)
		begin		
			wena = 39'b1 << 38;
			array = 38'b0;
			eventID[15:0] = {2'b10, tag[13:0]};
		end
		else if(control==19)
		begin	
			eventID = 16'b0;
			wena = 39'b0;
			ena = 1'b0;	
			done = 1'b1;
			control = 6'b0;
			srst = 1'b1;
		end
	end
	
end 

endmodule
