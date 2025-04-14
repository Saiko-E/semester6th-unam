library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity senal is--definición entidad señal
port (clk: in std_logic;--señal de reloj(entrada)
		duty: in integer;--ciclo de trabajo de la señal pwm
		limite: in integer;--limite maximo para el contador (periodo de la señal pwm)
		snl: out std_logic);--Señal de salida generada (pwm)
end entity;

architecture arqsenal of senal is--definición de la arquitectura
constant lim: integer := limite;--constante con el mismo valor que el periodo de la señal
signal conteo: integer := 0;--cuenta los ciclos de reloj, inicia en 0
begin

	process(clk)--proceso toma parámetro la señal de reloj
	begin
	
		if(rising_edge(clk)) then--si hay un flanco de subida
		
			if(conteo <= duty) then--si conteo menor o igual al ciclo de trabajo
				snl <= '1';--flanco de subida en señal de salida
			else
				snl <= '0';--de otra forma, la señal de salida será 0
			end if;
			
			if(conteo = limite) then--si se llegó al limite del conteo
				conteo <= 0;--reinicio del conteo
			else
				conteo <= conteo + 1;--si no se ha llegado al límite, se incrementa en uno el valor
			end if;
			
		end if;
		  
    end process;
end architecture;
