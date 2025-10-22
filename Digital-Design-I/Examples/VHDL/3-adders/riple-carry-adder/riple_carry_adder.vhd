library ieee;
use ieee.std_logic_1164.all;


entity riple_carry_adder is
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



architecture rtl of riple_carry_adder is

    component fa is
        port (
            a,b,ci   : in std_logic;
            co,s : out std_logic
        );
    end component;

    signal internal_carry : std_logic_vector(N downto 0);

begin   


    internal_carry(0) <= ci;
    co   <= internal_carry(N);

    -- this is a generate statement that creates N instances of the full adders interconnected to form the ripple carry adder
    gen_fa : for i in 0 to N-1 generate
        fa_inst : fa
            port map (
                a  => a(i),
                b  => b(i),
                ci => internal_carry(i),
                co => internal_carry(i+1),
                s  => s(i)
            );
    end generate;

end architecture;