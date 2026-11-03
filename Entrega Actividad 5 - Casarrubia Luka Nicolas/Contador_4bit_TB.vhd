library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity contador_datapath_tb is
end contador_datapath_tb;


architecture tb of contador_datapath_tb is
    signal clk, reset, load, ena : std_logic := '0';
    signal D_in   : std_logic_vector(3 downto 0) := "0000";
    signal cuenta : std_logic_vector(3 downto 0);
    
    constant Periodo : time := 20 ns; 
begin

    
    DUT: entity work.contador_datapath 
        port map (
            clk    => clk,
            reset  => reset,
            load   => load,
            ena    => ena,
            D_in   => D_in,
            cuenta => cuenta
        );

    -- generación de reloj

    gen_clk: process is
    begin
        clk <= '0';
        wait for Periodo/2;

        clk <= '1';
        wait for Periodo/2;
    end process;


    -- estímulos
    estimulo: process is
    begin

        --  condicion inicial y reset
        reset <= '1';
        load  <= '0';
        ena   <= '0';
        wait until rising_edge(clk);
        wait for Periodo/4;
        
        reset <= '0';
        wait for 2 * Periodo;
        
        -- prueba de carga 
        D_in <= "0101"; 
        load <= '1';
        wait for Periodo;
        load <= '0';
        
        -- prueba de conteo 
        
        ena <= '1';
        wait for 5 * Periodo;
        ena <= '0';
        wait for 2 * Periodo;
        
        finish;

    end process;
end architecture tb;