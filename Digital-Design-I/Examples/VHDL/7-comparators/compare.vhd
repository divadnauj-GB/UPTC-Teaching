library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compare is
    generic (
        N : integer := 4
    );
    port (
        A : in  std_logic_vector(N-1 downto 0);
        B : in  std_logic_vector(N-1 downto 0);
        EQ : out std_logic;
        GT : out std_logic;
        LT : out std_logic
    );
end entity;


architecture rtl of compare is
begin

    EQ <= '1' when unsigned(A) = unsigned(B) else '0';
    GT <= '1' when unsigned(A) > unsigned(B) else '0';
    LT <= '1' when unsigned(A) < unsigned(B) else '0';

end architecture;