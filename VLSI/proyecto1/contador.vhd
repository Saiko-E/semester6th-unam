library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

--mide distancia
entity contador is
	port(echo, clk, trigger: in std_logic;
		distancia: buffer integer;
		unidades, decenas: out integer --señales para bcd
		);
end entity;

architecture arqConta of contador is
	signal conteo: integer range 0 to 12000; 

begin
	process(echo, clk, trigger)
	begin
	--si existe trigger,se empieza a contar
		if(trigger='1') then 
			conteo<=0; --se inicia la cuenta
			
		elsif (rising_edge(clk)) then
			if(echo='1') then
				conteo<=conteo+1; --cuenta distancia

			else
				--1300 para 20 cm
				--2600 para 40 cm
				if (conteo>=100 and conteo<=2600) then --1160: 20cm, 118: 2cm. No puede salir de esos rangos
					distancia <= integer(conteo/59); --Divide la cuenta entre 59 para obtener No. de cms
					
					--Impresion de valores en displays
					unidades <= distancia mod 10;
					decenas <= distancia / 10;
				end if;
			end if;
		end if;
	end process;
	
end architecture;
