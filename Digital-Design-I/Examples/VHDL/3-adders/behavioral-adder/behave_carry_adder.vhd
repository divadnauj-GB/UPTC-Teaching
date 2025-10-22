library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity behave_carry_adder is
    generic (
        N : integer := 4
    );
    port (
        a,b   : in  std_logic_vector(N-1 downto 0);
        ci    : in  std_logic;
        co    : out std_logic;
        s     : out std_logic_vector(N-1 downto 0)
    );
end entity;



architecture rtl of behave_carry_adder is

    signal temp_add : std_logic_vector(N downto 0);
    signal a_ext, b_ext, ci_ext : std_logic_vector(N downto 0);

begin   

    -- Extend inputs to N+1 bits
    a_ext <= '0' & a;
    b_ext <= '0' & b;
    ci_ext(N downto 1) <= (others => '0');
    ci_ext(0) <= ci;
    -- Behavioral description of the carry adder
    temp_add <= std_logic_vector((unsigned(a_ext) + unsigned(b_ext)) + unsigned(ci_ext));

    -- Assign outputs 
    s  <= temp_add(N-1 downto 0);
    co <= temp_add(N);
    

end architecture;