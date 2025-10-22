library ieee;
use ieee.std_logic_1164.all;



entity fa is
    port (
        a,b,ci   : in std_logic;
        co,s : out std_logic
    );
end entity;


architecture rtl of fa is

begin

    s  <= a xor b xor ci;
    co <= (a and b) or (ci and (a xor b));
    
end architecture;