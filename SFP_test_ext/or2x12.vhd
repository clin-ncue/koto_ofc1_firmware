library ieee;
use ieee.std_logic_1164.all;
entity or2x12 is
	port(in1, in2 : in std_logic_vector(11 downto 0);
		out1 : out std_logic_vector(11 downto 0));
end or2x12;

architecture behavioral_or of or2x12 is
begin
	out1(0) <= in1(0) or in2(0);
	out1(1) <= in1(1) or in2(1);
	out1(2) <= in1(2) or in2(2);
	out1(3) <= in1(3) or in2(3);
	out1(4) <= in1(4) or in2(4);
	out1(5) <= in1(5) or in2(5);
	out1(6) <= in1(6) or in2(6);
	out1(7) <= in1(7) or in2(7);
	out1(8) <= in1(8) or in2(8);
	out1(9) <= in1(9) or in2(9);
	out1(10) <= in1(10) or in2(10);
	out1(11) <= in1(11) or in2(11);
end behavioral_or;