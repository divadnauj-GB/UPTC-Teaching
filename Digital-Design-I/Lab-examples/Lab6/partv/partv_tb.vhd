library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity partv_tb is
end entity;


architecture testbench of partv_tb is

    signal s_X0    : std_logic_vector(3-1 downto 0);
    signal s_X1    : std_logic_vector(3-1 downto 0);
    signal s_X2    : std_logic_vector(3-1 downto 0);
    signal s_X3    : std_logic_vector(3-1 downto 0);
    signal s_X4    : std_logic_vector(3-1 downto 0);
    signal s_X5    : std_logic_vector(3-1 downto 0);
    signal s_X6    : std_logic_vector(3-1 downto 0);
    signal s_X7    : std_logic_vector(3-1 downto 0);
    signal s_sel   : std_logic_vector(2 downto 0);
    signal s_Z     : std_logic_vector(7-1 downto 0);

   signal s_counter : integer;

    type data is array(0 to 7) of std_logic_vector(6 downto 0);
    signal test_data1: data := ("1001001", 
                                "0000110", 
                                "1000111", 
                                "1000111", 
                                "1000000", 
                                "0111111",
                                "0111111",
                                "0111111");
    
    signal test_data2: data := ("0000110",
                                "1000111",
                                "1000111",
                                "1000000",
                                "0111111",
                                "0111111",
                                "0111111",
                                "1001001");
    
                                

begin

    UUT: entity work.partv port map(
        i_X0 => s_X0 ,
        i_X1 => s_X1 ,
        i_X2 => s_X2 ,
        i_X3 => s_X3 ,
        i_X4 => s_X4 ,
        i_X5 => s_X5 ,
        i_X6 => s_X6 ,
        i_X7 => s_X7 ,
        i_sel=> s_sel,
        o_Z  => s_Z  );

    process
    begin
            s_X0 <= "000"; 
            s_X1 <= "001";
            s_X2 <= "010";
            s_X3 <= "011";
            s_X4 <= "100";
            s_X5 <= "101";
            s_X6 <= "110";
            s_X7 <= "111";
            for i in 0 to 7 loop
                s_sel <= std_logic_vector(to_unsigned(i,3));
                wait for 10 ns;
                assert (s_Z = test_data1(i))
                    report "Warning: The expected output did not match " 
                    severity error;
            end loop;

            s_X0 <= "001"; 
            s_X1 <= "010";
            s_X2 <= "011";
            s_X3 <= "100";
            s_X4 <= "101";
            s_X5 <= "110";
            s_X6 <= "111";
            s_X7 <= "000";
            for i in 0 to 7 loop
                s_sel <= std_logic_vector(to_unsigned(i,3));
                wait for 10 ns;
                assert (s_Z = test_data2(i))
                    report "The expected data did not match"
                    severity error;
            end loop;
            report("Simulation_finished No errors!");
        wait;
    end process;



end architecture;