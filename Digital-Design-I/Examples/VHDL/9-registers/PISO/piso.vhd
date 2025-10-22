library ieee;
use ieee.std_logic_1164.all;

entity piso is
    generic (
        N : integer := 8
    );
    port (
        clk     : in  std_logic;
        rst_n     : in  std_logic;
        load    : in  std_logic;
        data_in : in  std_logic_vector(N-1 downto 0);
        data_out: out std_logic
    );
end entity piso;

architecture rtl of piso is

    signal reg : std_logic_vector(N-1 downto 0);

begin

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                reg <= data_in;
            else
                reg <= reg(N-2 downto 0) & '0';
            end if;
        end if;
    end process;

    data_out <= reg(N-1);
    
end architecture;
