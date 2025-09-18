library ieee;
use ieee.std_logic_1164.all;


entity mux4to1Nbit_v0 is
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

architecture rtl of mux4to1Nbit_v0 is
begin

    U0: for i in 0 to N-1 generate 
        M: entity work.mux4to1_v0 port map(
        i_X0  => i_X0(i),
        i_X1  => i_X1(i),
        i_X2  => i_X2(i),
        i_X3  => i_X3(i),
        i_sel => i_sel,
        o_Y   => o_Y(i)); 
    end generate;    

end architecture;