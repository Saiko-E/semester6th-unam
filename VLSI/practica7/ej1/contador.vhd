library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--u4: eityt work.conador(arqcont) port map(echo,clkl1,tr,led);
entity contador is 
port(echo,clkl1,rst: in std_logic;
	  salida: out std_logic); --ld
end entity;

architecture arqcnt of contador is
signal conteo: integer range 0 to 12000; --un cero mas
begin 
	process(echo,clkl1,rst)
		begin
		if(rst<='1') then
			conteo<=0;
		else
			if(echo='1') and(rising_edge(clkl1))then conteo<=conteo+1;
			 else
			  if(conteo<=1200) then --20cm
					salida<='1';
				else
					salida<='0';
				end if;
				end if;
			end if;
	end process;
end architecture;
