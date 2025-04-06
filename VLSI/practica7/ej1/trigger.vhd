library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--u3: entity work.trigger(arqtrg) port map(clkl2,est,echo,tr);
entity trigger is 
port(clk,rst,echo: in std_logic;
	  salida: out std_logic);
end entity;

architecture arqtrg of trigger is 

begin
	process(clk)
		begin
			if(rst='1')then salida<='0';
				if(echo<='1') then salida<='0';
				else
					salida<=clk; --falta
				end if;
			end if;
		end process;
end architecture;
