library ieee; 
use ieee.std_logic_1164.all;

entity jk_ff_tb is
end entity;

architecture behavioral of jk_ff_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component jk_ff
        port (
            J   : in  std_logic;
            K   : in  std_logic;
            clk : in  std_logic;
            rst_n : in  std_logic;
            en : in  std_logic;
            Q   : out std_logic;
            QN  : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal J   : std_logic := '0';
    signal K   : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst_n : std_logic := '1';
    signal en : std_logic := '0';
    signal Q   : std_logic;
    signal QN  : std_logic;

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: jk_ff
        port map (
            J   => J,
            K   => K,
            clk => clk,
            rst_n => rst_n,
            en => en,
            Q   => Q,
            QN  => QN
        );

    -- Clock generation
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- Reset the flip-flop
        rst_n <= '0';
        wait for clk_period * 2;
        rst_n <= '1';
        wait for clk_period * 2;
        -- Enable the flip-flop
        en <= '1';
        wait for clk_period * 2;
        -- Test J=0, K=0 (No change)
        J <= '0';
        K <= '0';
        wait for clk_period * 4;
        -- Test J=0, K=1 (Reset)
        J <= '0';
        K <= '1';
        wait for clk_period * 4;
        -- Test J=1, K=0 (Set)      
        J <= '1';
        K <= '0';
        wait for clk_period * 4;
        -- Test J=1, K=1 (Toggle)
        J <= '1';
        K <= '1';
        wait for clk_period * 4;
        -- Test J=0, K=0 (No change)
        J <= '0';
        K <= '0';
        wait for clk_period * 4;
        -- Finish simulation
        wait;
    end process;    
end architecture;
