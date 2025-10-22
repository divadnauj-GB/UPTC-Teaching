library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity binary_encoder is
    port (
        w : in  std_logic_vector(3 downto 0);
        y : out std_logic_vector(1 downto 0)
    );
end entity;

architecture rtl of binary_encoder is

begin

    with w select
        y <= "00" when "0001",
             "01" when "0010",
             "10" when "0100",
             "11" when "1000",
             "00" when others;  -- Default case

end architecture;