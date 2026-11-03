library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador_datapath is
    Port(
        clk    : in  std_logic;
        reset  : in  std_logic;
        load   : in  std_logic;
        ena    : in  std_logic;
        D_in   : in  std_logic_vector(3 downto 0);
        cuenta : out std_logic_vector(3 downto 0)
    );
end contador_datapath;

architecture arch of contador_datapath is
    signal estado, estado_sig : unsigned(3 downto 0);
begin

    -- proceso de memoria (registro)
    memoria: process (clk) is
    begin
        if rising_edge(clk) then
            estado <= estado_sig;
        end if;
    end process memoria;

    -- logica de estado siguiente (Cascada de multiplexorea y sumador)
    estado_sig <= "0000"         when reset = '1' else 
                  unsigned(D_in) when load = '1'  else 
                  estado + 1     when ena = '1'   else 
                  estado;                              

    -- logica de salida
    cuenta <= std_logic_vector(estado);

end architecture;