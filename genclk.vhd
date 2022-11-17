library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity genclk is
port(rst,mclk:std_logic;
	tb:std_logic_vector(1 downto 0);
	he,hr:out std_logic);
end genclk;

architecture beh of genclk is
	signal cpt:unsigned(7 downto 0):="00000000";

	begin
		hr<=cpt(0) when tb="00" else cpt(1) when tb="01" else cpt(2) when tb="10" else cpt(3);
		he<=cpt(4) when tb="00" else cpt(5) when tb="01" else cpt(6) when tb="10" else cpt(7);		
		cpt<="00000000" when rst='0' else cpt+1 when mclk='1' and mclk'event;

end beh;
