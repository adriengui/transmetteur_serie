library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity modulateur is
port(rst,clk,txd:std_logic;
	txdir:out std_logic);
end modulateur;

architecture biprocess of modulateur is

type defetat is(t0,t1);
signal etat,netat:defetat;

signal t,i:unsigned(3 downto 0):="0000";
signal at,ldat,txir,ldtx,ldi,ldt,deci,dect,zi,zt,teq:std_logic:='0';

begin
	txdir<=txir;
	txir<='1' when rst='0' else not txir when clk='1' and clk'event and ldtx='1';
	zi<='1' when i="0000" else '0';
	zt<='1' when t="0000" else '0';
	teq<='1' when t="1010" else '1' when t="0110" else '0';
	i<="0000" when rst='0' else "1010" when clk='1' and clk'event and ldi='1' else i-1 when clk='1' and clk'event and deci='1';
	t<="0000" when rst='0' else "1111" when clk='1' and clk'event and ldt='1' else t-1 when clk='1' and clk'event and dect='1';
	at<='0' when rst='0' else txd when clk='1' and clk'event and ldat='1';
	
	mem:process(rst, clk)
	begin
		if rst='0' then
			etat<=t0;
		elsif clk='1' and clk'event then
			etat<=netat;
		end if;
	end process;

	comb:process(etat, txd, at, zt, zi, teq)
	begin
		ldi<='0';
		ldt<='0';
		ldat<='0';
		ldtx<='0';
		deci<='0';
		dect<='0';
		netat<=etat;
		case etat is
			when t0 =>
				if txd='1' then 
					ldat<='1';
				elsif (txd='0' and at='1') then
					ldi<='1';
					ldt<='1';
					netat<=t1; 
				end if;
			when t1 => 
				if zt='1' then
					if zi='1' then
						netat<=t0;
					else
						deci<='1';
						ldt<='1';
					end if;
				else
					dect<='1';
					if(teq='1' and txd='0') then
						ldtx<='1';
					end if;
				end if;
		end case;
	end process;
end biprocess;
