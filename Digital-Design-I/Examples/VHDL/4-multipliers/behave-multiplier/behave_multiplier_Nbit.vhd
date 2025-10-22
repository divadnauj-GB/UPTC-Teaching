library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity behave_multiplier_Nbit is
    generic (
        N : integer := 4
    );
    port (
        A, B : in  std_logic_vector(N-1 downto 0);
        P    : out std_logic_vector(2*N-1 downto 0)
    );
end entity;

architecture rtl of behave_multiplier_Nbit is

   
begin

    P <= std_logic_vector(unsigned(A) * unsigned(B));

end architecture;