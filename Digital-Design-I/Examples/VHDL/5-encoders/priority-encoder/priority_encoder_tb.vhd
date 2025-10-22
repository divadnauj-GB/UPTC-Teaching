library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity priority_encoder_tb is
end entity;

architecture rtl of priority_encoder_tb is

    signal w : std_logic_vector(3 downto 0) := (others => '0');
    signal y : std_logic_vector(1 downto 0);
    signal z : std_logic := '0';
    

    component priority is
        port (
            w : in  std_logic_vector(3 downto 0);
            y : out std_logic_vector(1 downto 0);
            z : OUT STD_LOGIC 
        );
    end component;
begin
    uut: priority
        port map (
            w => w,
            y => y,
            z => z
        );

    stim_proc: process
    begin
        -- Test all single high input combinations
        for i in 0 to 15 loop
            w <= std_logic_vector(to_unsigned(i,4));
            wait for 10 ns;
        end loop;

        wait;
    end process;    

end architecture;