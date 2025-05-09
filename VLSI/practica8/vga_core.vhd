library ieee;
use ieee.std_logic_1164.all;

entity vga_core is
    generic(h_pulse: integer := 96;
            h_bp: integer := 48;
            h_pixels: integer := 640;
            h_fp: integer := 16;
            v_pulse: integer := 2;
            v_bp: integer := 33;
            v_pixels: integer := 480;
            v_fp: integer := 10);
    port(clk: in std_logic;
         display_ena, h_sync, v_sync: out std_logic;
         column, row: out integer);
end entity;

architecture arqcr of vga_core is
    signal h_period: integer := h_pulse + h_bp + h_pixels + h_fp; -- 800
    signal v_period: integer := v_pulse + v_bp + v_pixels + v_fp; -- 525
    signal h_count: integer range 0 to h_period-1 := 0;
    signal v_count: integer range 0 to v_period-1 := 0;
begin
    --contadores de pixeles horizontales y verticales. Se recorre por renglon
    --cuando se acaba el renglon se pasa al siguiente renglon.
    process(clk)
    begin
        if(rising_edge(clk)) then
            if (h_count < (h_period-1)) then
                h_count <= h_count + 1;
            else
                h_count <= 0;
                if (v_count < (v_period-1)) then
                    v_count <= v_count + 1;
                else
                    v_count <= 0;
                end if;
            end if;
end if;
    end process;

    --sincronizacion horizontal.
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(((h_count > (h_pixels+h_fp)) or (h_count > (h_pixels+h_fp+h_pulse)))) then
                h_sync <= '0';
            else
                h_sync <= '1';
            end if;
        end if;
    end process;

    --sincronizacion vertical
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(((v_count > (v_pixels+v_fp)) or (v_count > (v_pixels+v_fp+v_pulse)))) then
                v_sync <= '0';
            else
                v_sync <= '1';
            end if;
        end if;
    end process;

    --renombramiento
    process(clk)
		begin
        if(rising_edge(clk)) then
            if(h_count < h_pixels) then
                column <= h_count;
            end if;
            if(v_count < v_pixels) then
                row <= v_count;
            end if;
        end if;
    end process;

    --habilitador de imagen --- h_pixels=640; y_pixels=480
    process(clk)
    begin
        if(rising_edge(clk)) then
            if((h_count < h_pixels) and (v_count < v_pixels)) THEN
                display_ena <= '1';
            else
                display_ena <= '0';
            end if;
        end if;
    end process;

end architecture;
