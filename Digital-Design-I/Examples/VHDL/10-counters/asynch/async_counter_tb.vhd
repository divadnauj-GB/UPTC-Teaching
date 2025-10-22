library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity async_counter_tb is
end entity async_counter_tb;

architecture sim of async_counter_tb is

    constant WIDTH : integer := 4;

    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en    : std_logic := '0';
    signal count : std_logic_vector(WIDTH-1 downto 0);

    constant clk_period : time := 10 ns;

    component async_counter
        generic (
            WIDTH : integer := 4
        );
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            en    : in  std_logic;
            count : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component;

begin

    uut: async_counter
        generic map (
            WIDTH => WIDTH
        )
        port map (
            clk   => clk,
            rst_n => rst_n,
            en    => en,
            count => count
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the counter
        rst_n <= '0';
        wait for clk_period * 2;
        rst_n <= '1';
        wait for clk_period * 2;
        -- Enable counting
        en <= '1';
        wait for clk_period * 20;
        -- Disable counting
        en <= '0';
        wait for clk_period * 10;
        -- Enable counting again
        en <= '1';
        wait for clk_period * 20;
        -- Finish simulation
        wait;
    end process;

end architecture;