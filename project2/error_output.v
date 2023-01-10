module error_output(clk,reset,err_in,send_err,err_out);

input wire clk;
input wire reset;
input wire[17:0] err_in;
input wire[17:0] send_err;
output reg[17:0] err_out;

always @(posedge clk)
begin

  if(reset)
  begin
    err_out = 18'b0;
  end

  err_out[0]  = send_err[0]  ? err_in[0]  : err_out[0];
  err_out[1]  = send_err[1]  ? err_in[1]  : err_out[1];
  err_out[2]  = send_err[2]  ? err_in[2]  : err_out[2];
  err_out[3]  = send_err[3]  ? err_in[3]  : err_out[3];
  err_out[4]  = send_err[4]  ? err_in[4]  : err_out[4];
  err_out[5]  = send_err[5]  ? err_in[5]  : err_out[5];
  err_out[6]  = send_err[6]  ? err_in[6]  : err_out[6];
  err_out[7]  = send_err[7]  ? err_in[7]  : err_out[7];
  err_out[8]  = send_err[8]  ? err_in[8]  : err_out[8];
  err_out[9]  = send_err[9]  ? err_in[9]  : err_out[9];
  err_out[10] = send_err[10] ? err_in[10] : err_out[10];
  err_out[11] = send_err[11] ? err_in[11] : err_out[11];
  err_out[12] = send_err[12] ? err_in[12] : err_out[12];
  err_out[13] = send_err[13] ? err_in[13] : err_out[13];
  err_out[14] = send_err[14] ? err_in[14] : err_out[14];
  err_out[15] = send_err[15] ? err_in[15] : err_out[15];
  err_out[16] = send_err[16] ? err_in[16] : err_out[16];
  err_out[17] = send_err[17] ? err_in[17] : err_out[17];


end
endmodule
