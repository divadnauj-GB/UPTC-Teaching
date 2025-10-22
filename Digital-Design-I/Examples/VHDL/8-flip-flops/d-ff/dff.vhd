library ieee;
use ieee.std_logic_1164.all;


entity dff is
    port (
        D   : in  std_logic;
        clk : in  std_logic;
        rst_n : in  std_logic;
        en : in  std_logic;
        Q   : out std_logic;
        QN  : out std_logic
    );
end entity;

architecture behavioral of dff is
    signal Q_int : std_logic := '0';
begin

    process(clk, rst_n)
    begin
        if (rst_n = '0') then
            Q_int <= '0';
        elsif rising_edge(clk) then
            if (en = '1') then
                Q_int <= D;
            end if;
        end if;
    end process;   
    Q  <= Q_int;
    QN <= not Q_int;
end architecture;         