--importacion de librerias
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--declaracion de la entidad
entity p8 is 
port(clk: in std_logic;	
	  red, blue, green: out std_logic_vector(3 downto 0);
	  h_sync: out std_logic;
	  v_sync: out std_logic);
end entity;

--declaracion de la arquitectura
architecture arqvga of p8 is
signal clkl, disp_ena: std_logic;
signal column, row: integer;
begin 
	u1: entity work.divf(arqdivf) generic map(0) port map(clk,clkl);
	u2: entity work.vga_core(arqcr) port map(clkl,disp_ena,h_sync,v_sync, column,row);
	u3: entity work.imagen(arqim) port map(disp_ena, column, row, red, green, blue);
end architecture; 