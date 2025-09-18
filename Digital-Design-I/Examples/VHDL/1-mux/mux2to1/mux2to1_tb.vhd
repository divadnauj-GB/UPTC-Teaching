library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mux2to1_tb is
end entity;


architecture testbench of mux2to1_tb is
    signal   s0_X0   : std_logic := '0';
    signal   s0_X1   : std_logic := '0';
    signal   s0_sel  : std_logic := '0';
    signal   s0_Y    : std_logic := '0';        


    signal   s1_X0   : std_logic := '0';
    signal   s1_X1   : std_logic := '0';
    signal   s1_sel  : std_logic := '0';
    signal   s1_Y    : std_logic := '0'; 


    signal   s2_X0   : std_logic := '0';
    signal   s2_X1   : std_logic := '0';
    signal   s2_sel  : std_logic := '0';
    signal   s2_Y    : std_logic := '0'; 

    signal s0_idx : integer := 0;
    signal s1_idx : integer := 0;
    signal s2_idx : integer := 0;
    signal s3_idx : integer := 0;


    type data is array(0 to 3) of std_logic_vector(1 downto 0);
    signal test_data1: data := ("00", "01", "10", "11");

begin

    MUX0: entity work.mux2to1_v0 port map(
    i_X0  => s0_X0 ,
    i_X1  => s0_X1 ,
    i_sel => s0_sel,
    o_Y   => s0_Y  );


    MUX1: entity work.mux2to1_v1 port map(
    i_X0  => s1_X0 ,
    i_X1  => s1_X1 ,
    i_sel => s1_sel,
    o_Y   => s1_Y  );


    MUX2: entity work.mux2to1_v2 port map(
    i_X0  => s2_X0 ,
    i_X1  => s2_X1 ,
    i_sel => s2_sel,
    o_Y   => s2_Y  );
    

    -- generate stimuli MUX0
    process 
    begin
        s0_sel <= '0';
        for i in 0 to 3 loop
            s0_X0 <= test_data1(i)(0);
            s0_X1 <= test_data1(i)(1);
            wait for 10 ns;
            assert (s0_Y = test_data1(i)(to_integer(unsigned'('0' & s0_sel))))
                report "The expected output did not match"
                severity warning;
        end loop;
        s0_sel <= '1';
        for i in 0 to 3 loop
            s0_X0 <= test_data1(i)(0);
            s0_X1 <= test_data1(i)(1);
            wait for 10 ns;
            assert (s0_Y = test_data1(i)(to_integer(unsigned'('0' & s0_sel))))
                report "The expected output did not match"
                severity warning;
        end loop;
            s0_idx <= 1;
            wait;
    end process;


    -- generate stimuli MUX1
    process 
    begin
    s1_sel <= '0';
        for i in 0 to 3 loop
            s1_X0 <= test_data1(i)(0);
            s1_X1 <= test_data1(i)(1);
            wait for 10 ns;
            assert (s1_Y = test_data1(i)(to_integer(unsigned'('0' & s1_sel))))
                report "The expected output did not match"
                severity warning;
        end loop;
        s1_sel <= '1';
        for i in 0 to 3 loop
            s1_X0 <= test_data1(i)(0);
            s1_X1 <= test_data1(i)(1);
            wait for 10 ns;
            assert (s1_Y = test_data1(i)(to_integer(unsigned'('0' & s1_sel))))
                report "The expected output did not match"
                severity warning;
        end loop;    
            s1_idx <= 1;
            wait;
    end process;


    -- generate stimuli MUX2
    process 
    begin
    s2_sel <= '0';
        for i in 0 to 3 loop
            s2_X0 <= test_data1(i)(0);
            s2_X1 <= test_data1(i)(1);
            wait for 10 ns;
            assert (s2_Y = test_data1(i)(to_integer(unsigned'('0' & s2_sel))))
                report "The expected output did not match"
                severity warning;
        end loop;
        s2_sel <= '1';
        for i in 0 to 3 loop
            s2_X0 <= test_data1(i)(0);
            s2_X1 <= test_data1(i)(1);
            wait for 10 ns;
            assert (s2_Y = test_data1(i)(to_integer(unsigned'('0' & s2_sel))))
                report "The expected output did not match"
                severity warning;
        end loop;
         s2_idx <= 1;
         wait;
    end process;



    process(s0_idx,s1_idx,s2_idx)
    begin
        if s0_idx=1 and s1_idx=1 and s2_idx=1 then
            report("Simulation_finished No errors!");
        end if;
    end process;

end architecture;