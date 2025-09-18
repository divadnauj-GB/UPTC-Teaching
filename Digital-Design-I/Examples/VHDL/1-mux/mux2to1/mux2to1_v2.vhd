library ieee;
use ieee.std_logic_1164.all;


entity mux2to1_v2 is
    port (
        i_X0  : in std_logic;
        i_X1  : in std_logic;
        i_sel : in std_logic;
        o_Y   : out std_logic
    );
end entity;

architecture rtl of mux2to1_v2 is
begin

        --mux2-1 using with - select
    with i_sel select
    o_Y <= i_X0 when '0',
           i_X1 when others;            

end architecture;