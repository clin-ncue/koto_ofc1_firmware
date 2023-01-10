/* 
   err_stat
   C. Lin, chiehlin@uchicago.edu
	
	2022.12.19
   preliminary
*/

module err_stat
(
// input 
  clk               , // system clock
  
  // inputs
  reset             ,
  send_err          ,
  err               ,  
  
  // output
  out_00            ,
  out_01          ,
  out_02          ,
  out_03          ,
  out_04          ,
  out_05          ,
  out_06          ,
  out_07          ,
  out_08          ,
  out_09          ,
  out_10         ,
  out_11         ,
  out_12         ,
  out_13         ,
  out_14         ,
  out_15         ,
);


input wire         clk;

// inputs
input wire         reset;
input wire [15 :0] send_err;
input wire [15 :0] err;

// output
output reg [15 :0] out_00;
output reg [15 :0] out_01;
output reg [15 :0] out_02;
output reg [15 :0] out_03;
output reg [15 :0] out_04;
output reg [15 :0] out_05;
output reg [15 :0] out_06;
output reg [15 :0] out_07;
output reg [15 :0] out_08;
output reg [15 :0] out_09;
output reg [15 :0] out_10;
output reg [15 :0] out_11;
output reg [15 :0] out_12;
output reg [15 :0] out_13;
output reg [15 :0] out_14;
output reg [15 :0] out_15;

wire [15 :0] out_wire0;
wire [15 :0] out_wire1;
wire [15 :0] out_wire2;
wire [15 :0] out_wire3;
wire [15 :0] out_wire4;
wire [15 :0] out_wire5;
wire [15 :0] out_wire6;
wire [15 :0] out_wire7;
wire [15 :0] out_wire8;
wire [15 :0] out_wire9;
wire [15 :0] out_wire10;
wire [15 :0] out_wire11;
wire [15 :0] out_wire12;
wire [15 :0] out_wire13;
wire [15 :0] out_wire14;
wire [15 :0] out_wire15;

reg        [15 :0] pre_send_err;
reg        [15 :0] get_err;
reg                lock_cnt;

err_stat_single _err_stat_single00(clk, reset, send_err[0], err[0], out_wire0 );
err_stat_single _err_stat_single01(clk, reset, send_err[1], err[1], out_wire1 );
err_stat_single _err_stat_single02(clk, reset, send_err[2], err[2], out_wire2 );
err_stat_single _err_stat_single03(clk, reset, send_err[3], err[3], out_wire3 );
err_stat_single _err_stat_single04(clk, reset, send_err[4], err[4], out_wire4 );
err_stat_single _err_stat_single05(clk, reset, send_err[5], err[5], out_wire5 );
err_stat_single _err_stat_single06(clk, reset, send_err[6], err[6], out_wire6 );
err_stat_single _err_stat_single07(clk, reset, send_err[7], err[7], out_wire7 );
err_stat_single _err_stat_single08(clk, reset, send_err[8], err[8], out_wire8 );
err_stat_single _err_stat_single09(clk, reset, send_err[9], err[9], out_wire9 );
err_stat_single _err_stat_single10(clk, reset, send_err[10], err[10], out_wire10 );
err_stat_single _err_stat_single11(clk, reset, send_err[11], err[11], out_wire11 );
err_stat_single _err_stat_single12(clk, reset, send_err[12], err[12], out_wire12 );
err_stat_single _err_stat_single13(clk, reset, send_err[13], err[13], out_wire13 );
err_stat_single _err_stat_single14(clk, reset, send_err[14], err[14], out_wire14 );
err_stat_single _err_stat_single15(clk, reset, send_err[15], err[15], out_wire15 );

////////////////////////////////////////////
always @(posedge clk) begin

   out_00 <= out_wire0;
   out_01 <= out_wire1;
   out_02 <= out_wire2;
   out_03 <= out_wire3;
   out_04 <= out_wire4;
   out_05 <= out_wire5;
   out_06 <= out_wire6;
   out_07 <= out_wire7;
   out_08 <= out_wire8;
   out_09 <= out_wire9;
   out_10 <= out_wire10;
   out_11 <= out_wire11;
   out_12 <= out_wire12;
   out_13 <= out_wire13;
   out_14 <= out_wire14;
	out_15 <= out_wire15;
	
end

endmodule

//////////
//

module err_stat_single
(
// input 
  clk               , // system clock
  
  // inputs
  reset             ,
  send_err          ,
  err               ,  
  
  // output
  err_cnt           
);


input wire         clk;

// inputs
input wire         reset;
input wire         send_err;
input wire         err;

// output
output reg [15 :0] err_cnt;

reg                pre_send_err;
reg                lock_cnt;


////////////////////////////////////////////
always @(posedge clk) begin

   /// system reset ///
	if( reset == 1'b1 ) begin
	   err_cnt <= 16'hFFFF;
		lock_cnt <= 1'b0;
	end

	/// spill number is incremented at LIVE rising edge
   if( pre_send_err==1'b0 && send_err==1'b1 ) begin
      if( lock_cnt <= 1'b0 ) begin
	      lock_cnt <= 1'b1;
		   err_cnt <= 16'h0;
		end
		else begin
		   err_cnt <= (err==1'b1 && err_cnt < 16'hFFFE) ? (err_cnt + 1) : err_cnt;
		end
	end

	pre_send_err <= send_err;
	
end

endmodule

