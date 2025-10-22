library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end entity counter_tb;


architecture sim of counter_tb is
    signal WIDTH : natural := 4;
    
    -- Component Declaration for the Unit Under Test (UUT)
    component counter
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

    -- Signals to connect to UUT
    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en    : std_logic := '0';
    signal count : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: counter
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
        -- Hold reset state for 20 ns.
        rst_n <= '0';
        wait for 20 ns;
        rst_n <= '1';
        wait for 20 ns;

        -- Enable counting
        en <= '1';
        wait for 100 ns;

        -- Disable counting
        en <= '0';
        wait for 50 ns;

        -- Re-enable counting
        en <= '1';
        wait for 100 ns;

        -- Finish simulation
        wait;
    end process;

end architecture sim;