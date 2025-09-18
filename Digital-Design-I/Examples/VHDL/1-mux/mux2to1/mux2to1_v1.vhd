library ieee;
use ieee.std_logic_1164.all;


entity mux2to1_v1 is
    port (
        i_X0  : in std_logic;
        i_X1  : in std_logic;
        i_sel : in std_logic;
        o_Y   : out std_logic
    );
end entity;

architecture rtl of mux2to1_v1 is
begin

        --mux2-1 using when - else statements
    o_Y <= i_X0 when i_sel='0' else i_X1;

end architecture;