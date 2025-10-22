library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity piso_tb is
end entity piso_tb;

architecture sim of piso_tb is

    constant N : integer := 8;

    signal clk      : std_logic := '0';
    signal rst_n    : std_logic := '0';
    signal load     : std_logic := '0';
    signal data_in  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal data_out : std_logic;


    -- Instantiate the Unit Under Test (UUT)
    component piso
        generic (
            N : integer := 8
        );
        port (
            clk     : in  std_logic;
            rst_n   : in  std_logic;
            load    : in  std_logic;
            data_in : in  std_logic_vector(N-1 downto 0);
            data_out: out std_logic
        );
    end component;


    begin

    uut: piso
        generic map (
            N => N
        )
        port map (
            clk      => clk,
            rst_n    => rst_n,
            load     => load,
            data_in  => data_in,
            data_out => data_out
        );
    -- Clock generation
    clk_process :process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;    

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the UUT
        rst_n <= '0';
        wait for 15 ns;
        rst_n <= '1';
        wait for 10 ns;
        -- Load data into the PISO register
        data_in <= "10101010";
        load <= '1';
        wait for 10 ns;
        load <= '0';
        -- Shift out the data
        for i in 0 to N-1 loop
            wait for 10 ns;
        end loop;
        -- Finish simulation
        wait;
    end process;
end architecture sim;
