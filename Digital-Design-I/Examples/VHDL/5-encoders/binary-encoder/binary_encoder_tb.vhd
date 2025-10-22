library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity binary_encoder_tb is
end entity;

architecture rtl of binary_encoder_tb is

    signal w : std_logic_vector(3 downto 0) := (others => '0');
    signal y : std_logic_vector(1 downto 0);

    component binary_encoder is
        port (
            w : in  std_logic_vector(3 downto 0);
            y : out std_logic_vector(1 downto 0)
        );
    end component;
begin
    uut: binary_encoder
        port map (
            w => w,
            y => y
        );

    stim_proc: process
    begin
        -- Test all single high input combinations
        w <= "0001";
        wait for 10 ns;
        w <= "0010";
        wait for 10 ns;
        w <= "0100";
        wait for 10 ns;
        w <= "1000";
        wait for 10 ns;

        -- Test no input high
        w <= "0000";
        wait for 10 ns;

        wait;
    end process;    

end architecture;