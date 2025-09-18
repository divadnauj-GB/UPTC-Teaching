library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mux4to1Nbit_tb is
end entity;


architecture testbench of mux4to1Nbit_tb is
    constant  N : natural := 8;
    
    signal   s0_X0   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s0_X1   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s0_X2   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s0_X3   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s0_sel  : std_logic_vector(1 downto 0) := "00";
    signal   s0_Y    : std_logic_vector(N-1 downto 0) := (others => '0');        


    signal   s1_X0   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s1_X1   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s1_X2   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s1_X3   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal   s1_sel  : std_logic_vector(1 downto 0) := "00";
    signal   s1_Y    : std_logic_vector(N-1 downto 0) := (others => '0');


    signal s0_idx : integer := 0;
    signal s1_idx : integer := 0;

    type data is array(0 to 3) of std_logic_vector(N-1 downto 0);

begin

    MUX0: entity work.mux4to1Nbit_v0 
    generic map(
        N => N
    )
    port map(
    i_X0  => s0_X0 ,
    i_X1  => s0_X1 ,
    i_X2  => s0_X2 ,
    i_X3  => s0_X3 ,
    i_sel => s0_sel,
    o_Y   => s0_Y  );


    MUX1: entity work.mux4to1Nbit_v1 
    generic map(
        N => N
    )
    port map(
    i_X0  => s1_X0 ,
    i_X1  => s1_X1 ,
    i_X2  => s1_X2 ,
    i_X3  => s1_X3 ,
    i_sel => s1_sel,
    o_Y   => s1_Y  );
    

    -- generate stimuli MUX0
    process 
        variable v_test_data1 : data := (others => (others => '0'));
    begin
        for sel in 0 to 3 loop
            s0_sel <= std_logic_vector(to_unsigned(sel,2));
            v_test_data1 := (others => (others => '0'));
            for i in 0 to 2**N-1 loop
                v_test_data1(sel) := std_logic_vector(to_unsigned(i,N));
                s0_X0 <= v_test_data1(0);
                s0_X1 <= v_test_data1(1);
                s0_X2 <= v_test_data1(2);
                s0_X3 <= v_test_data1(3);
                wait for 10 ns;
                assert (s0_Y = v_test_data1(sel))
                    report "The expected output did not match for MUX0"
                    severity warning;
            end loop;
        end loop;
        s0_idx <= 1;
        wait;
    end process;


   -- generate stimuli MUX0
    process 
        variable v_test_data1 : data := (others => (others => '0'));
    begin
        for sel in 0 to 3 loop
            s1_sel <= std_logic_vector(to_unsigned(sel,2));
            v_test_data1 := (others => (others => '0'));
            for i in 0 to 2**N-1 loop
                v_test_data1(sel) := std_logic_vector(to_unsigned(i,N));
                s1_X0 <= v_test_data1(0);
                s1_X1 <= v_test_data1(1);
                s1_X2 <= v_test_data1(2);
                s1_X3 <= v_test_data1(3);
                wait for 10 ns;
                assert (s1_Y = v_test_data1(sel))
                    report "The expected output did not match for MUX0"
                    severity warning;
            end loop;
        end loop;
        s1_idx <= 1;
        wait;
    end process;



    process(s0_idx,s1_idx)
    begin
        if s0_idx=1 and s1_idx=1 then
            report("Simulation_finished No errors!");
        end if;
    end process;

end architecture;