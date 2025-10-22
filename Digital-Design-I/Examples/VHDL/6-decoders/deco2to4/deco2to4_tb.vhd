library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity deco2to4_tb is
end entity;

architecture rtl of deco2to4_tb is

    signal A  : std_logic_vector(1 downto 0) := (others => '0');
    signal en : std_logic := '0';
    signal Y  : std_logic_vector(3 downto 0);

    component deco2to4 is
        port (
            A : in  std_logic_vector(1 downto 0);
            en: in  std_logic;
            Y : out std_logic_vector(3 downto 0)
        );
    end component;
begin
    uut: deco2to4
        port map (
            A  => A,
            en => en,
            Y  => Y
        );  

    stim_proc: process
    begin        
        -- Test all combinations of 2-bit inputs with enable
        for i in 0 to 3 loop
            A <= std_logic_vector(to_unsigned(i, 2));
            en <= '0';
            wait for 10 ns;
            en <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;
end architecture;