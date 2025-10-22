library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter is
    generic (
        WIDTH : integer := 4
    );
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;
        en    : in  std_logic;
        count : out std_logic_vector(WIDTH-1 downto 0)
    );
end entity counter;


architecture rtl of counter is
    signal count_reg : std_logic_vector(WIDTH-1 downto 0);
begin

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            count_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                count_reg <= std_logic_vector(unsigned(count_reg) + 1);
            end if;
        end if;
    end process;

    count <= count_reg;

end architecture;