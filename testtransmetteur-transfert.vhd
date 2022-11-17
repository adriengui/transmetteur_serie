library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
end test;

architecture bench of test is
	component transfert is
	port(rst,clk,wr,trans:std_logic;
		data:std_logic_vector(7 downto 0);
		txrdy:out std_logic;
		d:out std_logic_vector(7 downto 0));
	end component;

	signal rst,clk,wr,trans,txrdy:std_logic:='0';
	signal d,data:std_logic_vector(7 downto 0):="00000000";

	begin
		UUT:transfert port map(rst=>rst,clk=>clk,wr=>wr,trans=>trans,txrdy=>txrdy,d=>d,data=>data);
		clk<=not clk after 10 ns;
		rst<='1', '0' after 265 ns, '1' after 325 ns;
		wr<='1', '0' after 47 ns, '1' after 77 ns;
		trans<='0', '1' after 167 ns, '0' after 217 ns;
		data<="01000001","00000000" after 115 ns;
end bench;
