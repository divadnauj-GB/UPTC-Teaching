library ieee;
use ieee.std_logic_1164.all;


entity partvi is
    port (
        i_sel :in std_logic_vector(2 downto 0);
        o_Z0: out std_logic_vector(7-1 downto 0);
        o_Z1: out std_logic_vector(7-1 downto 0);
        o_Z2: out std_logic_vector(7-1 downto 0);
        o_Z3: out std_logic_vector(7-1 downto 0);
        o_Z4: out std_logic_vector(7-1 downto 0);
        o_Z5: out std_logic_vector(7-1 downto 0);
        o_Z6: out std_logic_vector(7-1 downto 0);
        o_Z7: out std_logic_vector(7-1 downto 0)
    );
end entity;


architecture rtl of partvi is

    signal s_X0    : std_logic_vector(3-1 downto 0);
    signal s_X1    : std_logic_vector(3-1 downto 0);
    signal s_X2    : std_logic_vector(3-1 downto 0);
    signal s_X3    : std_logic_vector(3-1 downto 0);
    signal s_X4    : std_logic_vector(3-1 downto 0);
    signal s_X5    : std_logic_vector(3-1 downto 0);
    signal s_X6    : std_logic_vector(3-1 downto 0);
    signal s_X7    : std_logic_vector(3-1 downto 0);
    
    signal s_Z0     : std_logic_vector(7-1 downto 0);
    signal s_Z1     : std_logic_vector(7-1 downto 0);
    signal s_Z2     : std_logic_vector(7-1 downto 0);
    signal s_Z3     : std_logic_vector(7-1 downto 0);
    signal s_Z4     : std_logic_vector(7-1 downto 0);
    signal s_Z5     : std_logic_vector(7-1 downto 0);
    signal s_Z6     : std_logic_vector(7-1 downto 0);
    signal s_Z7     : std_logic_vector(7-1 downto 0);


    signal s_H     : std_logic_vector(2 downto 0);
    signal s_E     : std_logic_vector(2 downto 0);
    signal s_L1    : std_logic_vector(2 downto 0);
    signal s_L2    : std_logic_vector(2 downto 0);
    signal s_O     : std_logic_vector(2 downto 0);
    signal s_S     : std_logic_vector(2 downto 0);

begin

    s_H <= "000";
    s_E <= "001";
    s_L1 <= "010";
    s_L2 <= "011";
    s_O <= "100";
    s_S <= "101";

    o_Z0 <= s_Z0;
    o_Z1 <= s_Z1;
    o_Z2 <= s_Z2;
    o_Z3 <= s_Z3;
    o_Z4 <= s_Z4;
    o_Z5 <= s_Z5;
    o_Z6 <= s_Z6;
    o_Z7 <= s_Z7;


    SEG7_DISP_0: entity work.partv port map(
        i_X0 => s_O ,
        i_X1 => s_S ,
        i_X2 => s_S ,
        i_X3 => s_S ,
        i_X4 => s_H ,
        i_X5 => s_E ,
        i_X6 => s_L1 ,
        i_X7 => s_L2 ,
        i_sel=> i_sel,
        o_Z  => s_Z0  );

    SEG7_DISP_1: entity work.partv port map(
        i_X0 => s_L2 ,
        i_X1 => s_O,
        i_X2 => s_S ,
        i_X3 => s_S ,
        i_X4 => s_S ,
        i_X5 => s_H ,
        i_X6 => s_E ,
        i_X7 => s_L1 ,
        i_sel=> i_sel,
        o_Z  => s_Z1  );

    SEG7_DISP_2: entity work.partv port map(
        i_X0 => s_L1 ,
        i_X1 => s_L2 ,
        i_X2 => s_O ,
        i_X3 => s_S ,
        i_X4 => s_S ,
        i_X5 => s_S ,
        i_X6 => s_H ,
        i_X7 => s_E ,
        i_sel=> i_sel,
        o_Z  => s_Z2  );

    SEG7_DISP_3: entity work.partv port map(
        i_X0 => s_E ,
        i_X1 => s_L1 ,
        i_X2 => s_L2 ,
        i_X3 => s_O ,
        i_X4 => s_S ,
        i_X5 => s_S ,
        i_X6 => s_S ,
        i_X7 => s_H ,
        i_sel=> i_sel,
        o_Z  => s_Z3  );

    SEG7_DISP_4: entity work.partv port map(
        i_X0 => s_H ,
        i_X1 => s_E ,
        i_X2 => s_L1 ,
        i_X3 => s_L2 ,
        i_X4 => s_O ,
        i_X5 => s_S ,
        i_X6 => s_S ,
        i_X7 => s_S ,
        i_sel=> i_sel,
        o_Z  => s_Z4  );

    SEG7_DISP_5: entity work.partv port map(
        i_X0 => s_S ,
        i_X1 => s_H ,
        i_X2 => s_E ,
        i_X3 => s_L1 ,
        i_X4 => s_L2 ,
        i_X5 => s_O ,
        i_X6 => s_S ,
        i_X7 => s_S ,
        i_sel=> i_sel,
        o_Z  => s_Z5  );

    SEG7_DISP_6: entity work.partv port map(
        i_X0 => s_S ,
        i_X1 => s_S ,
        i_X2 => s_H ,
        i_X3 => s_E ,
        i_X4 => s_L1 ,
        i_X5 => s_L2 ,
        i_X6 => s_O ,
        i_X7 => s_S ,
        i_sel=> i_sel,
        o_Z  => s_Z6  );

    SEG7_DISP_7: entity work.partv port map(
        i_X0 => s_S ,
        i_X1 => s_S ,
        i_X2 => s_S ,
        i_X3 => s_H ,
        i_X4 => s_E ,
        i_X5 => s_L1 ,
        i_X6 => s_L2 ,
        i_X7 => s_O ,
        i_sel=> i_sel,
        o_Z  => s_Z7  );



end architecture;