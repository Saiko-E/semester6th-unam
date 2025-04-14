library ieee;
use ieee.std_logic_1164.all;

entity trigger is--definición de la entidad
port (clk, rst, echo: in std_logic;  -- Puertos de entrada: reloj, señal de reset y señal de eco
		salida: out std_logic);  -- Puerto de salida: señal de salida
end entity;

architecture arqtrigger of trigger is--implementa la arquitectura
begin

	process(clk, rst, echo)--proceso con parámetros de la señal de reloj, reset y eco del sensor
	begin
	
		if(rst = '1') then  -- Si la señal de reset está activa
			salida <= '0';  -- La salida se establece en '0'
		elsif(echo = '0') then  -- Si la señal de eco está en bajo
			salida <= clk;  -- La salida sigue al reloj
		end if;
		
	end process;
end architecture;
