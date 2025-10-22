library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity bcdto7seg is
    port (
        BCD : in  std_logic_vector(3 downto 0);
        SEG : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of bcdto7seg is

begin
    --the segments turned on are represented by a '0' the order of the segments is: a,b,c,d,e,f,g
    with BCD select
        SEG <= "0000001" when "0000", -- 0
               "1001111" when "0001", -- 1
               "0010010" when "0010", -- 2
               "0000110" when "0011", -- 3
               "1001100" when "0100", -- 4
               "0100100" when "0101", -- 5
               "0100000" when "0110", -- 6
               "0001111" when "0111", -- 7
               "0000000" when "1000", -- 8
               "0000100" when "1001", -- 9
               "1111111" when others;  -- blank

end architecture;   