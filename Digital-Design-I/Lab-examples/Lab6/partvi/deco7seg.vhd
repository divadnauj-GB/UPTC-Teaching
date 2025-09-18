library ieee;
use ieee.std_logic_1164.all;


entity deco7seg is
    port (
        i_deco :in std_logic_vector(2 downto 0);
        o_disp: out std_logic_vector(6 downto 0)
    );
end entity;




architecture rtl of deco7seg is

begin

    -- When you use with select or when else statements your circuti will be implemented as multiplexors
    -- the diplay segement in this order "6543210" according to the DE1 board    
    with i_deco select
    --        "6543210"
    o_disp <= "1001001" when "000",
              "0000110" when "001",
              "1000111" when "010",
              "1000111" when "011",
              "1000000" when "100",
              "0111111" when others;

end architecture;