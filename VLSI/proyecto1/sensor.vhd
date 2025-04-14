library ieee;
use ieee.std_logic_1164.all;

entity sensor is--definición de la entidad sensor
port (clk, rst, echo, reset, take: in std_logic;  -- Entradas del sistema: reloj, señal de reset y señal de eco del sensor
		trig, pwm_motor: out std_logic;  -- Salida del sistema: señal de trigger
		ss0, ss1: out std_logic_vector(6 downto 0);-- salidas del sistema en display de 7 segmentos
		ss2, ss3: out std_logic_vector(6 downto 0));  -- Salidas del sistema: segmentos de display de 7 segmentos
end entity;

architecture arqsns of sensor is --Definición de arquitectura de sensor
signal clkl, clkl1, clkl2, tr, inc, dec: std_logic;-- señales a usar derivadas de señal de reloj
signal salida0, salida1, salida2, salida3, duty_motor, sal: integer;-- enteros usados en el módulo
constant duty_sensor: integer := 500;--ciclo de trabajo para el sensor ultrasónico, definido en 500
constant limite_sensor: integer := 25000000;--periodo para el uso del sensor ultrasónico
constant limte_motor: integer := 1000;--periodo establecido para el movimiento del servomotor
signal dis: integer;--entero que describe la distancia del objeto con el sensor
begin

	u1: entity work.divf(arqdivf) generic map(25) port map(clk, clkl1); -- Generador de frecuencia dividida
	u2: entity work.senal(arqsenal) port map(clk, duty_sensor, limite_sensor,  clkl2); -- Generador de señal PWM
	u3: entity work.trigger(arqtrigger) port map(clkl2, rst, echo, tr); -- Controlador de trigger
	trig <= tr;  -- Asignación de la señal de trigger
	
	u4: entity work.contador(arqcontador) port map(echo, clkl1, tr, salida0, salida1, dis); -- Contador de salida
	u5: entity work.dec7seg(arqdec) port map(salida0, ss0); -- Conversor de decimal a display de 7 segmentos para la salida0
	u6: entity work.dec7seg(arqdec) port map(salida1, ss1); -- Conversor de decimal a display de 7 segmentos para la salida1
	
	u7: entity work.divf(arqdivf) generic map(60) port map(clk, clkl);--divisor de frecuencia para la señal de reloj incluida en el hardware en uso
	u8: entity work.movimiento(arqmov) port map(clkl, inc, dec, reset, salida0, duty_motor);--calcula movimiento del motor dependiendo de la salida del sensor
	u9: entity work.senal(arqsenal) port map(clkl, duty_motor, limte_motor, pwm_motor);--envía indicaciones al motor para hacer los movimientos correspondientes

end architecture;