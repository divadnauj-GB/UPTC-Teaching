library ieee;
use ieee.std_logic_1164.all;


entity partv is
    port (
        i_X0 :in std_logic_vector(3-1 downto 0);
        i_X1 :in std_logic_vector(3-1 downto 0);
        i_X2 :in std_logic_vector(3-1 downto 0);
        i_X3 :in std_logic_vector(3-1 downto 0);
        i_X4 :in std_logic_vector(3-1 downto 0);
        i_X5 :in std_logic_vector(3-1 downto 0);
        i_X6 :in std_logic_vector(3-1 downto 0);
        i_X7 :in std_logic_vector(3-1 downto 0);
        i_sel :in std_logic_vector(2 downto 0);
        o_Z: out std_logic_vector(7-1 downto 0)
    );
end entity;


architecture rtl of partv is

    signal s_Z_mux : std_logic_vector(2 downto 0);
    

begin

    MUX0: entity work.mux8to1 port map(
    i_X0 => i_X0,
    i_X1 => i_X1,
    i_X2 => i_X2,
    i_X3 => i_X3,
    i_X4 => i_X4,
    i_X5 => i_X5,
    i_X6 => i_X6,
    i_X7 => i_X7,
    i_sel=> i_sel,
    o_Z =>  s_Z_mux );

    SEG7_DISP: entity work.deco7seg port map(
        i_deco  => s_Z_mux,
        o_disp => o_Z );


end architecture;