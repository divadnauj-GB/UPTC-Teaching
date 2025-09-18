library ieee;
use ieee.std_logic_1164.all;


entity mux4to1Nbit_v1 is
    generic (
        N : natural := 8
    );
    port (
        i_X0  : in std_logic_vector(N-1 downto 0);
        i_X1  : in std_logic_vector(N-1 downto 0);
        i_X2  : in std_logic_vector(N-1 downto 0);
        i_X3  : in std_logic_vector(N-1 downto 0);
        i_sel : in std_logic_vector(1 downto 0);
        o_Y   : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture rtl of mux4to1Nbit_v1 is
begin

    with i_sel select
    o_Y <= i_X0 when "00",
           i_X1 when "01",
           i_X2 when "10",
           i_X3 when others;

end architecture;