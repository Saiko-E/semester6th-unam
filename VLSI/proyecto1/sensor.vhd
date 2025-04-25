library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sensor is
port	(clk, reset, echo: in std_logic; --señales de entrada para sensor
		controlServo: out std_logic; --salida para servo
		b: out std_logic; --salida para sensor
		unidades, decenas: out std_logic_vector(6 downto 0) --Displays para distancia
		);
end entity;

architecture a of sensor is
	signal clkl1, clkl2, pwm, trig: std_logic;
	signal distancia, uni, dec: integer;
	signal duty: integer range 0 to 200:=85;
	
begin
	--servo
	u1: entity work.divf(arqdivf) generic map(500) port map(clk, clkl2); --Reloj para servomotor, 50KHz
	u2: entity work.divf(arqdivf) generic map(25) port map(clk, clkl1); --1MHZ - 1us
	
	senal: entity work.senal(arqsenal) port map(clk, 25000000, 500, pwm); --generacion de pwm para sensor
	
	a: entity work.trigger(arqtrigger) port map(pwm, reset, echo, trig); --disparo sensor
	b<=trig;
	medicion: entity work.contador(arqConta) port map(echo, clkl1, trig, distancia, uni, dec); --distancia sensor
	
	unidad: entity work.dec7seg(arqdec) port map(uni, unidades); --display unidades
	decena: entity work.dec7seg(arqdec) port map(dec, decenas); --display decimas
	
	posicion: entity work.movimiento(arqMov) port map(distancia, reset, duty); --posiciones del servo
	servo: entity work.senal(arqsenal) port map(clkl2, 1000, duty, controlServo); --control del servo
	
end architecture;