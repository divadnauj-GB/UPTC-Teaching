library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pipo_tb is
end entity pipo_tb;


architecture sim of pipo_tb is
    signal WIDTH : integer := 4;
    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en    : std_logic := '0';
    signal d     : std_logic_vector(3 downto 0) := (others => '0');
    signal q     : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

    component pipo
        generic (
            WIDTH : integer := 4
        );
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            en : in std_logic;
            d   : in std_logic_vector(WIDTH-1 downto 0);
            q   : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component pipo;

begin

    uut: pipo
        generic map (
            WIDTH => WIDTH
        )
        port map (
            clk => clk,
            rst_n => rst_n,
            en => en,
            d => d,
            q => q
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process clk_process;

    stim_process : process
    begin
        -- Reset the design
        rst_n <= '0';
        wait for 15 ns;
        rst_n <= '1';
        wait for 10 ns;

        -- Test case 1: Load data when enable is high
        en <= '1';
        d <= "1010";
        wait for clk_period;
        
        -- Test case 2: Change data when enable is low (should not change)
        en <= '0';
        d <= "1100";
        wait for clk_period;

        -- Test case 3: Load new data when enable is high
        en <= '1';
        d <= "1111";
        wait for clk_period;

        -- Finish simulation
        wait for 20 ns;
        assert false report "End of simulation" severity note;
        wait;
    end process stim_process;

end architecture sim;
