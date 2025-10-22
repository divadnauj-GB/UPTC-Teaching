library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_pl_tb is
end entity counter_pl_tb;


architecture sim of counter_pl_tb is
    constant WIDTH : natural :=4;
    

    -- Component Declaration for the Unit Under Test (UUT)
    component counter_pl
        generic (
            WIDTH : integer := 4
        );
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            en    : in  std_logic;
            load : in  std_logic;
            load_value : in  std_logic_vector(WIDTH-1 downto 0);
            count : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en    : std_logic := '0';
    signal load : std_logic := '0';
    signal load_value : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal count : std_logic_vector(WIDTH-1 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: counter_pl
        generic map (
            WIDTH => WIDTH
        )
        port map (
            clk   => clk,
            rst_n => rst_n,
            en    => en,
            load => load,
            load_value => load_value,
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
        wait for clk_period * 5;

        -- Load a value into the counter
        load_value <= "1010";  -- Load value 10
        load <= '1';
        wait for clk_period;
        load <= '0';
        wait for clk_period * 5;

        -- Disable counting
        en <= '0';
        wait for clk_period * 5;

        -- Re-enable counting
        en <= '1';
        wait for clk_period * 5;

        -- Finish simulation
        wait;
    end process;

end architecture sim;