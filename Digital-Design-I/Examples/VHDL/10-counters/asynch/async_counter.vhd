library ieee;
use ieee.std_logic_1164.all;

entity async_counter is
    generic (
        WIDTH : integer := 4
    );
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;
        en    : in  std_logic;
        count : out std_logic_vector(WIDTH-1 downto 0)
    );
end entity async_counter;


architecture rtl of async_counter is
    signal tff_q : std_logic_vector(WIDTH-1 downto 0);
    signal tff_qn : std_logic_vector(WIDTH-1 downto 0);
    signal clk_chain : std_logic_vector(WIDTH-1 downto 0);

    component tff
        port (
            T   : in  std_logic;
            clk : in  std_logic;
            rst_n : in  std_logic;
            en : in  std_logic;
            Q   : out std_logic;
            QN  : out std_logic
        );
    end component;
begin


    clk_chain(0) <= clk;

    gen_tff : for i in 0 to WIDTH-1 generate
        tff_inst : tff
            port map (
                T   => '1',
                clk => clk_chain(i),
                rst_n => rst_n,
                en => en,
                Q   => tff_q(i),
                QN  => tff_qn(i)
            );

        clkgen: if i < WIDTH-1 generate
            clk_chain(i+1) <= tff_qn(i);
        end generate clkgen;
    end generate gen_tff;

    count <= tff_q;

end architecture;