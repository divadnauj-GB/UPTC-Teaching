library ieee;
use ieee.std_logic_1164.all;

entity deco2to4 is
    port (
        A : in  std_logic_vector(1 downto 0);
        en: in  std_logic;
        Y : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of deco2to4 is
signal  en_w : std_logic_vector(2 downto 0);

begin

    en_w <= en & A;

    with en_w select
        Y <= "0001" when "100",
             "0010" when "101",
             "0100" when "110",
             "1000" when "111",
             "0000" when others;
    

end architecture;