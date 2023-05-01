module Check_Data(

input wire clk,
input wire rst,
input wire [15:0] idata,


output reg [31:0] cnt_header,
output reg [31:0] cnt_evt,
output reg b_err,
output reg [28:0] timestamp_reg,
output reg [9:0]  ispill_reg,
output reg [15:0] ievt_reg,
output reg [15:0] cbit_reg,
output reg [4:0] icrate_reg,
output reg [4:0] islot_reg
);


reg [15:0] data_reg0 = 0;
reg [15:0] data_reg1 = 0;
reg [15:0] data_reg2 = 0;

reg [5:0] header0;
reg [5:0] header1;

reg b_cnt;
//reg b_ew;
//reg b_ft;

reg b_check_start;

reg [3:0] cnt_ch;
reg [15:0] cnt_ew_check;
reg [15:0] cnt_ew;
reg [15:0] cnt_hd;

reg [13:0] header_reg0 = 14'b0;
reg [13:0] header_reg1 = 14'b0;
reg [13:0] header_reg2 = 14'b0;
reg [13:0] header_reg3 = 14'b0;
reg [13:0] header_reg4 = 14'b0;
reg [13:0] header_reg5 = 14'b0;

reg set_hder = 1'b0;


reg [31:0] sum;

always @(posedge clk)
begin

if(rst)
begin
timestamp_reg <= 29'b0;
ispill_reg <= 10'b0;
ievt_reg <= 16'b0;
cbit_reg <= 16'b0;
icrate_reg <= 5'b0;
islot_reg <= 5'b0;
end


if(set_hder==1'b1)
begin
/*
3'b000 : q[15:0] = { 2'b11 , ispill_reg[3:0], islot_reg[4:0], icrate_reg[4:0]  };
3'b001 : q[15:0] = { 2'b11 , ievt_reg[7:0], ispill_reg[9:4] };
3'b010 : q[15:0] = { 2'b11 , timestamp_reg[5:0], ievt_reg[15:8] };
3'b011 : q[15:0] = { 2'b11 , timestamp_reg[19:6] };
3'b100 : q[15:0] = { 2'b11 , cbit_reg[4:0], timestamp_reg[28:20] };
3'b101 : q[15:0] = { 2'b11 , 3'b000, cbit_reg[15:5] };
*/
icrate_reg[4:0] <= header_reg0[4:0];
islot_reg[4:0] <=  header_reg0[9:5];
ispill_reg[9:0] <= {header_reg1[5:0] , header_reg0[13:10]};
ievt_reg[15:0]  <=  {header_reg2[7:0] , header_reg1[13:6]};
timestamp_reg[28:0] <= {header_reg4[8:0] , header_reg3[13:0] , header_reg2[13:8]};
cbit_reg[15:0] <= {header_reg5[10:0] , header_reg4[13:9]};

sum <= icrate_reg+islot_reg+ispill_reg+ievt_reg+timestamp_reg+cbit_reg;

end
end
always @(posedge clk)
begin


data_reg2 = data_reg1;
data_reg1 = data_reg0;
data_reg0 = idata;


if( rst )
begin

cnt_header = 'h00000000;
cnt_evt = 'h00000000;
b_cnt = 1'b0;
b_err = 1'b0;
cnt_ew = 'h0000;
cnt_ew_check = 'h0000;
cnt_hd = 'h0000;
end




/////////////////////////////////////////////////////////////
if( ~b_cnt )
begin
if( data_reg1[15:14] != 2'b11 )
begin
set_hder = 1'b0;
cnt_hd = 'h0000;
end
else if( data_reg1[15:14] == 2'b11  )
begin
case(cnt_hd)
16'h0000: header_reg0[13:0] = data_reg1[13:0];
16'h0001: header_reg1[13:0] = data_reg1[13:0];
16'h0002: header_reg2[13:0] = data_reg1[13:0];
16'h0003: header_reg3[13:0] = data_reg1[13:0];
16'h0004: header_reg4[13:0] = data_reg1[13:0];
16'h0005: header_reg5[13:0] = data_reg1[13:0];
endcase
cnt_hd = cnt_hd + 1'b1;
end

if( cnt_hd == 6 && data_reg0[15:14] == 2'b10 )
begin
set_hder = 1'b1;
cnt_header = cnt_header + 1'b1;
b_cnt = 1'b1;
b_err = 1'b0;
b_check_start = 1'b0;
cnt_ew = 'h0000;
cnt_ew_check = 'h0000;
cnt_hd = 'h0000;
cnt_ch = 4'b0000;
//cnt_evt = cnt_evt + 1'b1;
end
end




if( b_cnt == 1'b1 )
begin  
// no lossless
if( data_reg1[15:14] == 2'b10 ) b_check_start = 1'b1;

if( b_check_start )
begin
if(cnt_ch!=4'b1111)
begin
if( data_reg1[15:14] == 2'b10 && data_reg0[15:14] == 2'b10 && data_reg1[13:0] == data_reg0[13:0] ) cnt_ew = cnt_ew + 1'b1;
end
else
begin
if( data_reg1[15:14] == 2'b10 && data_reg0[15:14] == 2'b10 && data_reg1[13:0] == data_reg0[13:0] - 1'b1 ) cnt_ew = cnt_ew + 1'b1;
end

cnt_ch = cnt_ch + 1'b1;
cnt_ew_check = cnt_ew_check + 1'b1;

if( cnt_ew_check == 1024 )
begin
if( cnt_ew == 1023 && data_reg0[15:14] == 2'b01 )
begin
b_err = 1'b0;
cnt_evt = cnt_evt + 1'b1;
end
else
begin
b_err = 1'b1;
end
b_cnt = 1'b0;

end

end

end


end

endmodule