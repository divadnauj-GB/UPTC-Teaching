library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compare_tb is
end entity;

architecture behavior of compare_tb is

    constant N : integer := 4;

    signal A : std_logic_vector(N-1 downto 0) := (others => '0');
    signal B : std_logic_vector(N-1 downto 0) := (others => '0');
    signal EQ : std_logic;
    signal GT : std_logic;
    signal LT : std_logic;

    component compare
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
    end component;
begin

    uut: compare
        generic map (
            N => N
        )
        port map (
            A => A,
            B => B,
            EQ => EQ,
            GT => GT,
            LT => LT
        );

    stim_proc: process
    begin
        -- Test case 1: A = 3, B = 3
        A <= "0011";
        B <= "0011";
        wait for 10 ns;

        -- Test case 2: A = 5, B = 2
        A <= "0101";
        B <= "0010";
        wait for 10 ns;

        -- Test case 3: A = 1, B = 4
        A <= "0001";
        B <= "0100";
        wait for 10 ns;

        -- Test case 4: A = 0, B = 0
        A <= "0000";
        B <= "0000";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end architecture;   