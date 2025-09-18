library ieee;
use ieee.std_logic_1164.all;


entity mux2to1_v0 is
    port (
        i_X0  : in std_logic;
        i_X1  : in std_logic;
        i_sel : in std_logic;
        o_Y   : out std_logic
    );
end entity;

architecture rtl of mux2to1_v0 is
begin

    --mux2-1 using boolean logic
    o_Y <= (i_X0 and (not i_sel)) or (i_X1 and i_sel);

end architecture;