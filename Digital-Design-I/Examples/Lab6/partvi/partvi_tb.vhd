library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity partvi_tb is
end entity;


architecture testbench of partvi_tb is
    signal s_sel   : std_logic_vector(2 downto 0);
    signal s_Z0     : std_logic_vector(7-1 downto 0);
    signal s_Z1     : std_logic_vector(7-1 downto 0);
    signal s_Z2     : std_logic_vector(7-1 downto 0);
    signal s_Z3     : std_logic_vector(7-1 downto 0);
    signal s_Z4     : std_logic_vector(7-1 downto 0);
    signal s_Z5     : std_logic_vector(7-1 downto 0);
    signal s_Z6     : std_logic_vector(7-1 downto 0);
    signal s_Z7     : std_logic_vector(7-1 downto 0);

    signal s_expected0 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected1 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected2 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected3 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected4 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected5 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected6 : std_logic_vector(6 downto 0) := (others => '0');
    signal s_expected7 : std_logic_vector(6 downto 0) := (others => '0');




    type data is array(0 to 7) of std_logic_vector(6 downto 0);
    signal test_data1: data := ("1000000", "1000111", "1000111", "0000110", "1001001", "0111111", "0111111", "0111111");
                                

begin

    UUT: entity work.partvi port map(
        i_sel=> s_sel,
        o_Z0  => s_Z0,
        o_Z1  => s_Z1,
        o_Z2  => s_Z2,
        o_Z3  => s_Z3,
        o_Z4  => s_Z4,
        o_Z5  => s_Z5,
        o_Z6  => s_Z6,
        o_Z7  => s_Z7);
    
    -- The following process apply the data to the UUT and then verify wheter the output corresponds to the expected results 
    process
    begin
        for i in 0 to 7 loop
            s_sel <= std_logic_vector(to_unsigned(i,3)); -- apply a value to the inputs
            wait for 10 ns;
            -- Generate the expected results
            if i=0 then
                s_expected0 <= test_data1(i);
            else
                s_expected0 <= test_data1(8-i);
            end if;
            if i<=1 then               
                s_expected1 <= test_data1(1-i);
            else
                s_expected1 <= test_data1(8-i+1);
            end if;
            if i<=2 then               
                s_expected2 <= test_data1(2-i);
            else
                s_expected2 <= test_data1(8-i+2);
            end if;
            if i<=3 then               
                s_expected3 <= test_data1(3-i);
            else
                s_expected3 <= test_data1(8-i+3);
            end if;
            if i<=4 then               
                s_expected4 <= test_data1(4-i);
            else
                s_expected4 <= test_data1(8-i+4);
            end if;
            if i<=5 then               
                s_expected5 <= test_data1(5-i);
            else
                s_expected5 <= test_data1(8-i+5);
            end if;
            if i<=6 then               
                s_expected6 <= test_data1(6-i);
            else
                s_expected6 <= test_data1(8-i+6);
            end if;            
            s_expected7 <= test_data1(7-i);
            wait for 1 ns;
            -- verify the results agains the expected outputs if there are diferences it will print a message
            assert (s_Z0 = s_expected0) report "Warning: The expected output0 did not match " severity warning;
            assert (s_Z1 = s_expected1) report "Warning: The expected output1 did not match " severity warning;
            assert (s_Z2 = s_expected2) report "Warning: The expected output2 did not match " severity warning;
            assert (s_Z3 = s_expected3) report "Warning: The expected output3 did not match " severity warning;
            assert (s_Z4 = s_expected4) report "Warning: The expected output4 did not match " severity warning;
            assert (s_Z5 = s_expected5) report "Warning: The expected output5 did not match " severity warning;
            assert (s_Z6 = s_expected6) report "Warning: The expected output6 did not match " severity warning;
            assert (s_Z7 = s_expected7) report "Warning: The expected output7 did not match " severity warning;
        end loop;
        report("Simulation_finished No errors!");
        wait;
    end process;



end architecture;