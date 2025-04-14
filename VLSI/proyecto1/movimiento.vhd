library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity movimiento is--Definición de entidad movimiento
port (clk, inc, dec, reset: in std_logic;--señales de entrada, reloj, incremento y decremento
		salida0: in integer;-- Entero indica la decena de la distancia calculada
		ancho: out integer);-- indica el pwm para el servomotor
end entity;

architecture arqmov of movimiento is
    signal pwm      : integer := 500;    -- Valor inicial de PWM
    signal direccion: std_logic := '1';  -- Señal para indicar la dirección (1: adelante, 0: atrás)
    signal conteo   : integer := 0;      -- Contador de ciclos de reloj
    signal num      : integer := 200000; -- Contador máximo(ajustar según la frecuencia de reloj)
	 signal apoyo:		 integer := 0;			--iguala al valr pwm
begin
    process (clk, reset) --proceso toma como parámetros la señal de reloj y reset
    begin
        if reset = '1' then
            pwm <= 500;           -- Valor de PWM inicial
            conteo <= 0;          -- Reiniciar el contador
            direccion <= '1';     -- Empezar en la dirección de avance
        elsif rising_edge(clk) then --si se detercta un pulso en la señal de reloj
		 		
				
            if conteo = num then --si el conteo ya ha llegado al número límite
                conteo <= 0;      -- Reinicia el contador después de alcanzar el límite de tiempo
                -- Invertir la dirección de movimiento al completar el ciclo
                if direccion = '1' then
                    direccion <= '0';  -- Cambia a la dirección de retroceso
                else
                    direccion <= '1';  -- Cambia a la dirección de avance
                end if;
            else
                conteo <= conteo + 1;  -- Incrementar el contador en cada ciclo de reloj
            end if;
				
				
				
			--Definición de límites para el contador dependiendo de las decenas en la distancia
			if salida0=0 then --si la distancia es de menos de 10
					pwm<=510; 
					apoyo<=pwm;
				elsif salida0=1 then--distancia entre 10 y 19
					pwm<=550;
					apoyo<=pwm;
				elsif salida0=2 then--distancia entre 20 y 29
					pwm<=600;
					apoyo<=pwm;
				elsif salida0=3 then--distancia entre 30 y 39
					pwm<=650;
					apoyo<=pwm;
				elsif salida0=4 then--distancia entre 40 y 49
					pwm<=700;
					apoyo<=pwm;
				elsif salida0=5 then--distancia entre 50 y 59
					pwm<=750;	
					apoyo<=pwm;
				elsif salida0=6 then--distancia entre 60 y 69
					pwm<=800;	
					apoyo<=pwm;
				elsif salida0=7 then--distancia entre 70 y 79
					pwm<=850;
					apoyo<=pwm;
				else 
					pwm<=999;-- cualquier distancia mayor a 79
					apoyo<=pwm;
				end if;
			

            -- Modificar el valor de PWM según la dirección
            if direccion = '1' then
                -- Movimiento hacia adelante (aumentar PWM hasta el valor máximo)
                if pwm < apoyo+1 then
                    pwm <= pwm + 1;--incremento en pwm
                end if;
            else
                -- Movimiento hacia atrás (disminuir PWM hasta el valor mínimo)
                if pwm > 500 then
                    pwm <= pwm - 1;--decremento en pwm
                end if;
            end if;
        end if;
    end process;

    ancho <= pwm;  -- Asignar el valor de PWM a la salida
end architecture;