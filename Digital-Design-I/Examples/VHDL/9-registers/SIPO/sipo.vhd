library ieee;
use ieee.std_logic_1164.all;

entity sipo is
    generic (
        N : integer := 8
    );
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        en      : in  std_logic;
        data_in  : in  std_logic;
        data_out : out std_logic_vector(N-1 downto 0)
    );
end entity sipo;

architecture rtl of sipo is
    signal shift_reg : std_logic_vector(N-1 downto 0);

begin

    process(clk, rst_n )
    begin
        if rst_n = '0' then
            shift_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                shift_reg <= shift_reg(N-2 downto 0) & data_in;
            end if;
        end if;
    end process;

    data_out <= shift_reg;
end architecture;