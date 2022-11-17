library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity transmetteur is
port(rst,mclk,wr,cts:std_logic;
	tb:std_logic_vector(1 downto 0);
	datawrite:std_logic_vector(7 downto 0);
	txrdy,txdir:out std_logic);
end transmetteur;

architecture rtl of transmetteur is
component bloctransmetteur is
port(rst,clk,wr,cts:std_logic;
	datawrite:std_logic_vector(7 downto 0);
	txrdy,txd:out std_logic);
end component;

component modulateur is
port(rst,clk,txd:std_logic;
	txdir:out std_logic);
end component;

component genclk is
port(rst,mclk:std_logic;
	tb:std_logic_vector(1 downto 0);
	he,hr:out std_logic);
end component;

signal tx,hhe,hhr:std_logic:='0';

begin

transmet:bloctransmetteur port map(rst=>rst,clk=>hhe,wr=>wr,cts=>cts,datawrite=>datawrite,txrdy=>txrdy,txd=>tx);
modul:modulateur port map(rst=>rst,clk=>hhr,txd=>tx,txdir=>txdir);
clock:genclk port map(rst=>rst,mclk=>mclk,tb=>tb,he=>hhe,hr=>hhr);


end rtl;

