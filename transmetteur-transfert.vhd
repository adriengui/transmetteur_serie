library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity transfert is
port(rst,clk,wr,trans:std_logic;
	data:std_logic_vector(7 downto 0);
	txrdy:out std_logic;
	d:out std_logic_vector(7 downto 0));
end transfert;

architecture biprocess of transfert is

type defetat is(t0,t1,t2,t3);
signal etat,netat:defetat;
signal en:std_logic:='0';

begin
	d<="00000000" when rst='0' else data when clk='1' and clk'event and en='1';

	mem:process(rst, clk)
	begin
		if rst='0' then
			etat<=t0;
		elsif clk='1' and clk'event then
			etat<=netat;
		end if;
	end process;

	comb:process(etat, wr, trans)
	begin
		txrdy<='0';
		en<='0';
		netat<=etat;
		case etat is
			when t0 =>
				if wr='0' then 
					netat<=t1; 
				end if;
			when t1 => 
				if wr='1' then 
					netat<=t2;
					en<='1';
				end if;
			when t2 => 
				txrdy<='1'; 
				if trans='1' then 
					netat<=t3; 
				end if;
			when t3 => 
				txrdy<='1'; 
				if trans='0' then 
					netat<=t0; 
				end if;
		end case;
	end process;
end biprocess;
