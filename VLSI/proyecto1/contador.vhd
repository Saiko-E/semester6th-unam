library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador is--definición entidad contador
port (echo, clkl1, rst: in std_logic;--señales de entrada, echo, reloj y reset
		salida0, salida1, dis: out integer);--decenas y unidades de medida de distancia
end entity;

architecture arqcontador of contador is --definición de arquitectura contador
signal conteo: integer range 0 to 12000; -- señal de conteo tiene un rango de 0 a 12000
begin

	process(echo, clkl1, rst)--parámetros de procesos
	variable decena: integer;-- variable decenas en distancia
	variable unidad: integer;--variable unidades en distancia
	variable modulo: integer;--cálculo de módulo para la distancia
	begin
	
		if rising_edge(clkl1) then --si hay flanco de subida
		
			if(rst = '1') then --si se detecta reset
				conteo <= 0;--se reinicia el conteo
			elsif(rising_edge(clkl1)) then--si hay flanco de subida en señal de reloj
			
				if(echo = '1') then -- si se detecta un eco
					conteo <= conteo + 1;--incrementa el conteo
				else --comienza con el cálcuo de la distancia
					modulo := conteo mod 59;--operación para ajustes de presición
					
					if(conteo < 30 or conteo > 5841) then --si el conteo se encuentra dentro del rango útil
						conteo <= 0;--reinicia conteo a 0
					else
					
						if(modulo = 0) then --si el módulo es cero
							conteo <= conteo;--no se realiza ninguna operación
						elsif(modulo >= 30) then -- si el residuo es mayor o igual a 30
							conteo <= conteo + (modulo - 1); --realiza el ajuste del conteo 
						elsif((conteo mod 59) < 30) then--residuo menor a 30
							conteo <= conteo - (modulo - 1);--realiza el ajuste del conteo
						end if;
						
					end if;
					
					--calculo de distancia en decenas y unidades.
					decena := integer((conteo/59)/10);--decenas se calculan mediante la división del conteo
					unidad := (conteo/59)-(decena * 10);--cálculo de las unidades, conteo entre múltiplo de 10
					
					salida0 <= decena;--salida 0 son las decenas de la distancia
					salida1 <= unidad;--salida 1 son las unidades de la distancia
					dis <= (conteo/59);--distancia total calculada (decenas+ unidades)
					

					
			end if;
			
		end if;
		
	end if;
		
	end process;
end architecture;