library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
	component transmetteur is
	port(rst,mclk,wr,cts:std_logic;
		tb:std_logic_vector(1 downto 0);
		datawrite:std_logic_vector(7 downto 0);
		txrdy,txdir:out std_logic);
	end component;

	signal rst,mclk,wr,cts,txrdy,txdir:std_logic:='0';
	signal tb:std_logic_vector(1 downto 0):="00";
	signal datawrite:std_logic_vector(7 downto 0):="00000000";

	begin
		UUT:transmetteur port map(rst=>rst,mclk=>mclk,wr=>wr,cts=>cts,tb=>tb,datawrite=>datawrite,txrdy=>txrdy,txdir=>txdir);
		mclk<=not mclk after 10 ns;
		rst<='1', '0' after 150 ns, '1' after 550 ns;
		cts<='0';
		wr<='0', '1' after 1180 ns, '0' after 3750 ns;
		tb<="00";
		datawrite<="01000001";
end bench;
