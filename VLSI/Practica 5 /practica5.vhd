library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity practica5 is
    port (clk, pi, pf, inc, dec, rst: in std_logic;
          control : out std_logic);
end entity;

architecture Behavioral of practica5 is
    signal clk1,clk2: STD_LOGIC;
    signal duty : integer range 0 to 200 := 75;
begin
    u1: entity work.divf(arqdivf) generic map(500) port map (clk, clk1);
	 u2: entity work.divf(arqdivf) generic map(12500000) port map (clk, clk2);
    u3: entity work.senal(arqsnl) port map (clk1, duty, control);
    u4: entity work.movimiento(arqmov) port map(clk1, clk2, pi, pf, inc, dec, rst, duty);
end architecture;
