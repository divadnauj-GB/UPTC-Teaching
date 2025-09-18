library ieee;
use ieee.std_logic_1164.all;


entity mux8to1 is
    generic (
        N: natural :=3
    );
    port (
        i_X0 :in std_logic_vector(N-1 downto 0);
        i_X1 :in std_logic_vector(N-1 downto 0);
        i_X2 :in std_logic_vector(N-1 downto 0);
        i_X3 :in std_logic_vector(N-1 downto 0);
        i_X4 :in std_logic_vector(N-1 downto 0);
        i_X5 :in std_logic_vector(N-1 downto 0);
        i_X6 :in std_logic_vector(N-1 downto 0);
        i_X7 :in std_logic_vector(N-1 downto 0);
        i_sel :in std_logic_vector(2 downto 0);
        o_Z: out std_logic_vector(N-1 downto 0)
    );
end entity;




architecture rtl of mux8to1 is

begin

    with i_sel select
    o_Z <= i_X0 when "000",
           i_X1 when "001",
           i_X2 when "010",
           i_X3 when "011",
           i_X4 when "100",
           i_X5 when "101",
           i_X6 when "110", 
           i_X7 when others;

end architecture;