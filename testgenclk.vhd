library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
	component genclk is
	port(rst,mclk:std_logic;
		tb:std_logic_vector(1 downto 0);
		he,hr:out std_logic);
	end component;

	signal rst,mclk,he,hr:std_logic:='0';
	signal tb:std_logic_vector(1 downto 0):="00";

	begin
		UUT:genclk port map(rst=>rst,mclk=>mclk,he=>he,hr=>hr,tb=>tb);
		mclk<=not mclk after 10 ns;
		rst<='1', '0' after 29410 us, '1' after 35000 us;
		tb<="01", "00" after 1450 ns; -- "11" after 5820 us, "01" after 15460 us;
end bench;
