library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sipo_tb is
end entity sipo_tb;

architecture sim of sipo_tb is

    constant N : integer := 8;

    signal clk      : std_logic := '0';
    signal rst_n    : std_logic := '0';
    signal en       : std_logic := '0';
    signal data_in  : std_logic := '0';
    signal data_out : std_logic_vector(N-1 downto 0) := (others => '0');
    signal tmp_conv : std_logic_vector(7 downto 0) := (others => '0');

    constant clk_period : time := 10 ns;

    component sipo
        generic (
            N : integer := 8
        );
        port (
            clk      : in  std_logic;
            rst_n    : in  std_logic;
            en       : in  std_logic;
            data_in  : in  std_logic;
            data_out : out std_logic_vector(N-1 downto 0)
        );
    end component sipo;

begin

    uut: sipo
        generic map (
            N => N
        )
        port map (
            clk      => clk,
            rst_n    => rst_n,
            en       => en,
            data_in  => data_in,
            data_out => data_out
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
        -- Reset the SIPO
        rst_n <= '0';
        wait for 20 ns;
        rst_n <= '1';
        wait for 20 ns;

        -- Shift in data bits
        en <= '1';
        for i in 0 to N-1 loop
            tmp_conv <= std_logic_vector(to_unsigned(i,8));
            data_in <= tmp_conv(0);-- Alternate between '0' and '1'
            wait for clk_period;
        end loop;

        en <= '0';
        wait for 40 ns;

        -- Finish simulation
        wait;
    end process stim_process;

end architecture sim;