library ieee;
use ieee.std_logic_1164.all;

--generación de valor de posicion. es variable dependiendo del input.

entity movimiento is
	port(
	distancia: in integer;
	reset: in std_logic; 
	ancho: out integer
	);
end entity;

architecture arqMov of movimiento is
	signal valor: integer range 0 to 200;
	
begin
	process(distancia, reset)
	begin
		if(reset='1')then --cuando es boton, el presionarlo es 0, no presionarlo es 1
			valor <=70;
		else 
			valor <= distancia * (50/38) * 9;
		end if;
		ancho<= valor;
	end process;
end architecture;
