library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bloctransmetteur is
port(rst,clk,wr,cts:std_logic;
	datawrite:std_logic_vector(7 downto 0);
	txrdy,txd:out std_logic);
end bloctransmetteur;

architecture rtl of bloctransmetteur is
component transmission is
port(rst,clk,txrdy,cts:std_logic;
	d:std_logic_vector(7 downto 0);
	trans,txd:out std_logic);
end component;

component transfert is
port(rst,clk,wr,trans:std_logic;
	data:std_logic_vector(7 downto 0);
	txrdy:out std_logic;
	d:out std_logic_vector(7 downto 0));
end component;

signal rdy,tr:std_logic:='0';
signal dat:std_logic_vector(7 downto 0):="00000000";

begin
transmi:transmission port map(rst=>rst,clk=>clk,txrdy=>rdy,cts=>cts,d=>dat,trans=>tr,txd=>txd);
transf:transfert port map(rst=>rst,clk=>clk,wr=>wr,trans=>tr,data=>datawrite,txrdy=>rdy,d=>dat);
txrdy<=rdy;

end rtl;

