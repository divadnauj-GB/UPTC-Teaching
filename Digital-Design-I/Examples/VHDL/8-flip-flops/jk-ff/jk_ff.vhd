library ieee;
use ieee.std_logic_1164.all;


entity jk_ff is
    port (
        J   : in  std_logic;
        K   : in  std_logic;
        clk : in  std_logic;
        rst_n : in  std_logic;
        en : in  std_logic;
        Q   : out std_logic;
        QN  : out std_logic
    );
end entity;


architecture behavioral of jk_ff is
    signal Q_int : std_logic := '0';
begin

    process(clk, rst_n)
    begin
        if (rst_n = '0') then
            Q_int <= '0';
        elsif rising_edge(clk) then
            if (en = '1') then
                case (J & K) is
                    when "00" =>
                        Q_int <= Q_int;          -- No change
                    when "01" =>
                        Q_int <= '0';            -- Reset
                    when "10" =>
                        Q_int <= '1';            -- Set
                    when "11" =>
                        Q_int <= not Q_int;      -- Toggle
                    when others =>
                        Q_int <= Q_int;          -- No change (safety)
                end case;
            end if;
        end if;
    end process;   
    Q  <= Q_int;
    QN <= not Q_int;
end architecture;