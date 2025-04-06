library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--u1: entity work.divf(arqdivf) generic map(25) port map(clk,clkl1);
entity divf is 
generic (N: integer := 25);
port(clk: in std_logic;
     sal: out std_logic);
end entity;

architecture arqdivf of divf is 
signal conteo: integer range 0 to 25000000;
begin
	process(clk)
		begin
			if(rising_edge(clk))then
				if(conteo<=N) then
					sal<='1';
				else
					sal<='0';
				end if;
				if(conteo<=25000000) then
					conteo<=0;
				else
					conteo<=conteo+1;
				end if;
				end if;
			end process;
end architecture;
					