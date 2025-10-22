library  ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity siso is
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
end entity siso;

architecture rtl of siso is
    signal shift_reg : std_logic_vector(N-1 downto 0);
begin

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            shift_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                shift_reg <= shift_reg(N-2 downto 0) & din;
            end if;
        end if;
    end process;
    dout <= shift_reg(N-1);

end architecture;