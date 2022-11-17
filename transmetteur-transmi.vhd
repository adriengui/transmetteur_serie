library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity transmission is
port(rst,clk,txrdy,cts:std_logic;
	d:std_logic_vector(7 downto 0);
	trans,txd:out std_logic);
end transmission;

architecture biprocess of transmission is

type defetat is(t0,t1,t2);
signal etat,netat:defetat;

signal di:std_logic_vector(10 downto 0):="00000000000";
signal i:unsigned(3 downto 0):="0000";
signal c1,c2,c3,z:std_logic:='0';

begin
	txd<=di(0);
	z<='1' when i="0000" else '0';
	i<="0000" when rst='0' else "1010" when clk='1' and clk'event and c1='1' 
		else i-1 when clk='1' and clk'event and c3='1';
	di<="11111111111" when rst='0' else ('1'&di(10 downto 1)) when clk='1' and clk'event and c2='1' 
		else ('1'&xor_reduce(d)&d&'0') when clk='1' and clk'event and c1='1';

	mem:process(rst, clk)
	begin
		if rst='0' then
			etat<=t0;
		elsif clk='1' and clk'event then
			etat<=netat;
		end if;
	end process;

	comb:process(etat, txrdy, cts, z)
	begin
		trans<='0';
		c1<='0';
		c2<='0';
		c3<='0';
		netat<=etat;
		case etat is
			when t0 =>
				if(txrdy='1' and  cts='0') then 
					netat<=t1; 
				end if;
			when t1 => 
				trans<='1';
				c1<='1';
				netat<=t2;
			when t2 => 
				c2<='1';
				if z='1' then 
					netat<=t0;
				else
					c3<='1';
				end if;
		end case;
	end process;
end biprocess;
