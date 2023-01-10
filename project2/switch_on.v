module switch_on(clk,reset,trigger,turn_on);

input wire clk;
input wire reset;
input wire trigger;
output reg turn_on;

always @(posedge clk)
begin

  turn_on = trigger ? 1'b1 : turn_on;
  turn_on = reset   ? 1'b0 : turn_on;

end
endmodule
