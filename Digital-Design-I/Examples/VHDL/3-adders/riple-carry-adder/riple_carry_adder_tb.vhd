
library ieee;
use ieee.std_logic_1164.all;



entity riple_carry_adder_tb is
end entity;



architecture tb of riple_carry_adder_tb is

    constant N : integer := 4;

    signal a,b   : std_logic_vector(N-1 downto 0);
    signal ci    : std_logic;
    signal co    : std_logic;
    signal s     : std_logic_vector(N-1 downto 0);

    component riple_carry_adder is
        generic (
            N : integer := 4
        );
        port (
            a,b   : in  std_logic_vector(N-1 downto 0);
            ci    : in  std_logic;
            co    : out std_logic;
            s     : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    uut : riple_carry_adder
        generic map (
            N => N
        )
        port map (
            a  => a,
            b  => b,
            ci => ci,
            co => co,
            s  => s
        );

    stim_proc: process
    begin        
        -- Test case 1
        a  <= "0001";
        b  <= "0010";
        ci <= '0';
        wait for 10 ns;

        -- Test case 2
        a  <= "0110";
        b  <= "0101";
        ci <= '0';
        wait for 10 ns;

        -- Test case 3
        a  <= "1111";
        b  <= "0001";
        ci <= '0';
        wait for 10 ns;

        -- Test case 4
        a  <= "1010";
        b  <= "0101";
        ci <= '1';
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end architecture;