library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity array_multiplier_4bit_tb is
end entity; 


architecture tb of array_multiplier_4bit_tb is

    signal A, B : std_logic_vector(4-1 downto 0) := (others => '0');
    signal P    : std_logic_vector(2*4-1 downto 0);

    component array_multiplier_4bit is
        port (
            A, B : in  std_logic_vector(4-1 downto 0);
            P    : out std_logic_vector(2*4-1 downto 0)
        );
    end component;  

begin   

    uut: array_multiplier_4bit
        port map (
            A => A,
            B => B,
            P => P
        );

    stim_proc: process
    begin        
        -- Test all combinations of 4-bit inputs
        for i in 0 to 15 loop
            for j in 0 to 15 loop
                A <= std_logic_vector(to_unsigned(i, 4));
                B <= std_logic_vector(to_unsigned(j, 4));
                wait for 10 ns;
            end loop;
        end loop;

        wait;
    end process;

end architecture;