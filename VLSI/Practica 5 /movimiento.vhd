library ieee;
use ieee.std_logic_1164.all;

entity movimiento is
    port (clk, clk2, pi, pf, inc, dec, rst: in std_logic;
          ancho: buffer integer);
end entity;

architecture arqmov of movimiento is
    signal valor: integer range 0 to 200 := 75;  -- valor es de tipo integer
begin
    -- Proceso único para manejar reset, posiciones inicial/final, e incrementos/decrementos
    process (clk, rst, pi, pf, inc, dec)
    begin
        if (rst = '1') then
            valor <= 75;  -- Posición neutral (1.5 ms)
            ancho <= 75;
        elsif (pi = '1') then
            valor <= 50;  -- Posición inicial (1 ms)
            ancho <= 50;
        elsif (pf = '1') then
            valor <= 100; -- Posición final (2 ms)
            ancho <= 100;
        elsif (rising_edge(clk2)) then
            -- Manejo de incrementos y decrementos
            if (inc = '1' and valor < 100) then
                valor <= valor + 1;  -- Incremento gradual
            elsif (dec = '1' and valor > 50) then
                valor <= valor - 1;  -- Decremento gradual
            end if;
            -- Asignar el valor actual al puerto de salida
            ancho <= valor;
        end if;
    end process;
end architecture;
