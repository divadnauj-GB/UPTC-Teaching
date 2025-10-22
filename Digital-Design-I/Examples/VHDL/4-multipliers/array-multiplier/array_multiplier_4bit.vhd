library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity array_multiplier_4bit is
    port (
        A, B : in  std_logic_vector(4-1 downto 0);
        P    : out std_logic_vector(2*4-1 downto 0)
    );
end entity;

architecture rtl of array_multiplier_4bit is

    signal pp0 : std_logic_vector(4 downto 0) := (others => '0'); -- Partial products
    signal pp1 : std_logic_vector(4 downto 0) := (others => '0'); -- Partial products
    signal pp2 : std_logic_vector(4 downto 0) := (others => '0'); -- Partial products
    signal pp3 : std_logic_vector(4 downto 0) := (others => '0'); -- Partial products

    signal p_carry1 : std_logic_vector(4 downto 0);
    signal p_carry2 : std_logic_vector(4 downto 0);
    signal p_carry3 : std_logic_vector(4 downto 0);

    signal p_sum1 : std_logic_vector(4 downto 0);
    signal p_sum2 : std_logic_vector(4 downto 0);
    signal p_sum3 : std_logic_vector(4 downto 0);
    
    signal sum : std_logic_vector(2*4-1 downto 0) := (others => '0');

    component fa is
        port (
            a,b,ci   : in std_logic;
            co,s : out std_logic
        );
    end component;

begin

    -- Generate partial products
    gen_pp0: for i in 0 to 4-1 generate
        pp0(i) <= A(0) and B(i);
    end generate;
        pp0(4) <= '0'; -- Extend to match size

    gen_pp1: for i in 0 to 4-1 generate
        pp1(i) <= A(1) and B(i);
    end generate;
        pp1(4) <= '0'; -- Extend to match size
    
    gen_pp2: for i in 0 to 4-1 generate
        pp2(i) <= A(2) and B(i);
    end generate;
        pp2(4) <= '0'; -- Extend to match size

    gen_pp3: for i in 0 to 4-1 generate
        pp3(i) <= A(3) and B(i);
    end generate;
        pp3(4) <= '0'; -- Extend to match size
    
    p_carry1(0) <= '0';
    gen_add1: for i in 0 to 4-1 generate
        fa_inst: fa
            port map (
                a  => pp0(i+1),
                b  => pp1(i),
                ci => p_carry1(i),
                s  => p_sum1(i),
                co => p_carry1(i+1)
            );
    end generate;
    p_sum1(4) <= p_carry1(4);

    p_carry2(0) <= '0';
    gen_add2: for i in 0 to 4-1 generate
        fa_inst: fa
            port map (
                a  => p_sum1(i+1),
                b  => pp2(i),
                ci => p_carry2(i),
                s  => p_sum2(i),
                co => p_carry2(i+1)
            );
    end generate;
        p_sum2(4) <= p_carry2(4);


    p_carry3(0) <= '0';
    gen_add3: for i in 0 to 4-1 generate
        fa_inst: fa
            port map (
                a  => p_sum2(i+1),
                b  => pp3(i),
                ci => p_carry3(i),
                s  => p_sum3(i),
                co => p_carry3(i+1)
            );
    end generate;
    p_sum3(4) <= p_carry3(4);

    P(0) <= pp0(0);
    P(1) <= p_sum1(0);
    P(2) <= p_sum2(0);
    P(7 downto 3) <= p_sum3(4 downto 0);

end architecture;