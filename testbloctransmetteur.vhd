library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
	component bloctransmetteur is
	port(rst,clk,wr,cts:std_logic;
		datawrite:std_logic_vector(7 downto 0);
		txrdy,txd:out std_logic);
	end component;

	signal rst,clk,wr,cts,txrdy,txd:std_logic:='0';
	signal datawrite:std_logic_vector(7 downto 0):="00000000";

	begin
		UUT:bloctransmetteur port map(rst=>rst,clk=>clk,wr=>wr,cts=>cts,datawrite=>datawrite,txrdy=>txrdy,txd=>txd);
		clk<=not clk after 10 ns;
		rst<='1', '0' after 5 ns, '1' after 15 ns;
		cts<='0';
		wr<='0', '1' after 35 ns, '0' after 155 ns;
		datawrite<="01000001";
end bench;
