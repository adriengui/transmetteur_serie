library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
	component transmission is
	port(rst,clk,txrdy,cts:std_logic;
		d:std_logic_vector(7 downto 0);
		trans,txd:out std_logic);
	end component;

	signal rst,clk,txrdy,cts,trans,txd:std_logic:='0';
	signal d:std_logic_vector(7 downto 0):="00000000";

	begin
		UUT:transmission port map(rst=>rst,clk=>clk,txrdy=>txrdy,cts=>cts,d=>d,trans=>trans,txd=>txd);
		clk<=not clk after 10 ns;
		rst<='1';--, '0' after 5 ns, '1' after 15 ns;
		txrdy<='0', '1' after 35 ns, '0' after 115 ns;
		cts<='0';
		d<="01000001";
end bench;
