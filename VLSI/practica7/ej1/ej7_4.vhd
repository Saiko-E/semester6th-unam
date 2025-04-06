library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ej7_4 is 
port(clk,rst,echo: in std_logic;
     trig: out std_logic;
	  led: out std_logic);
end entity;

architecture arqsns of ej7_4 is
signal clkl1,clkl2,tr: std_logic;
begin
  u1: entity work.divf(arqdivf) generic map(25) port map(clk,clkl1);
  u2: entity work.senal(arqsenal) port map(clk,clkl2);
  u3: entity work.trigger(arqtrg) port map(clkl2,rst,echo,tr);
  trig<=tr;
  u4: entity work.contador(arqcnt) port map(echo,clkl1,tr,led);
end architecture;
