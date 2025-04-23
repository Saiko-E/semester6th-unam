library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sensor is
port	(clk, reset, echo: in std_logic; --señales de entrada para sensor
		controlServo: out std_logic; --salida para servo
		disparo: out std_logic; --salida para sensor
		ssU, ssD: out std_logic_vector(6 downto 0) --Displays para distancia
		);
end entity;

architecture a of sensor is
	signal clkSensor, clkServo, PWMSensor, trig: std_logic;
	signal posIni, posFin: std_logic:='0';
	signal distancia, uni, dec: integer;
	signal dutyServo: integer range 0 to 200:=85;
	
begin
	--servo
	relojServo: entity work.divf(arqdivf) generic map(500) port map(clk, clkServo); --Reloj para servomotor, 50KHz
	relojSensor: entity work.divf(arqdivf) generic map(25) port map(clk, clkSensor); --1MHZ - 1us
	
	senalPWM: entity work.senal(arqsenal) port map(clk, 25000000, 500, PWMSensor); --generacion de pwm para sensor
	
	gatillo: entity work.trigger(arqtrigger) port map(PWMSensor, reset, echo, trig); --disparo sensor
	disparo<=trig;
	medicion: entity work.contador(arqConta) port map(echo, clkSensor, trig, distancia, uni, dec); --distancia sensor
	
	bcdUni: entity work.dec7seg(arqdec) port map(uni, ssU); --display unidades
	bcdDec: entity work.dec7seg(arqdec) port map(dec, ssD); --display decimas
	
	posiServo: entity work.movimiento(arqMov) port map(distancia, reset, dutyServo); --posiciones del servo
	
	pwmServo: entity work.senal(arqsenal) port map(clkServo, 1000, dutyServo, controlServo); --control del servo
	
end architecture;