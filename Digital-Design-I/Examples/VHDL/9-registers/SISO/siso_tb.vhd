library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity siso_tb is
end entity siso_tb;

architecture sim of siso_tb is

    constant N : integer := 4;

    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en    : std_logic := '0';
    signal din   : std_logic := '0';
    signal dout  : std_logic;

    component siso
        generic (
            N : integer := 4
        );
        port (
            clk   : in  std_logic;
            rst_n   : in  std_logic;
            en   : in  std_logic;
            din   : in  std_logic;
            dout  : out std_logic
        );
    end component;

begin

    uut: siso
        generic map (
            N => N
        )
        port map (
            clk   => clk,
            rst_n   => rst_n,
            en   => en,
            din   => din,
            dout  => dout
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_process : process
    begin
        -- Reset the design
        rst_n <= '0';
        wait for 12 ns;
        rst_n <= '1';
        wait for 10 ns;

        -- Enable shifting and provide input data
        en <= '1';
        din <= '1';
        wait for 10 ns;
        din <= '0';
        wait for 10 ns;
        din <= '1';
        wait for 10 ns;
        din <= '1';
        wait for 10 ns;
        din <= '0';
        wait for 10 ns;

        -- Disable shifting
        en <= '0';
        wait for 20 ns;

        -- Finish simulation
        wait;
    end process;

end architecture sim;