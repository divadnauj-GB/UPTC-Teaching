library ieee;
use ieee.std_logic_1164.all;


entity mux4to1_v0 is
    port (
        i_X0  : in std_logic;
        i_X1  : in std_logic;
        i_X2  : in std_logic;
        i_X3  : in std_logic;
        i_sel : in std_logic_vector(1 downto 0);
        o_Y   : out std_logic
    );
end entity;

architecture rtl of mux4to1_v0 is

    signal s_M00 : std_logic;
    signal s_M01 : std_logic;
    signal s_M10 : std_logic;
begin

    M00: entity work.mux2to1_v0 port map(
        i_X0  => i_X0,
        i_X1  => i_X1,
        i_sel => i_sel(0),
        o_Y   => s_M00);        
        
    M01: entity work.mux2to1_v0 port map(
        i_X0  => i_X2,
        i_X1  => i_X3,
        i_sel => i_sel(0),
        o_Y   => s_M01);  

    
    M10: entity work.mux2to1_v0 port map(
        i_X0  => s_M00,
        i_X1  => s_M01,
        i_sel => i_sel(1),
        o_Y   => o_Y); 

end architecture;