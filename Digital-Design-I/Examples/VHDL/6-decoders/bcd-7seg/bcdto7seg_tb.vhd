library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity bcdto7seg_tb is
end entity;

architecture rtl of bcdto7seg_tb is

    signal BCD : std_logic_vector(3 downto 0) := (others => '0');
    signal SEG : std_logic_vector(6 downto 0);

    component bcdto7seg is
        port (
            BCD : in  std_logic_vector(3 downto 0);
            SEG : out std_logic_vector(6 downto 0)
        );
    end component;
begin
    uut: bcdto7seg
        port map (
            BCD => BCD,
            SEG => SEG
        );  

    stim_proc: process
    begin        
        -- Test all BCD inputs from 0 to 9
        for i in 0 to 9 loop
            BCD <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;
end architecture;