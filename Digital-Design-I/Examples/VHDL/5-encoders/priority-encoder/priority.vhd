LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY priority IS
PORT (      w : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
        y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) ;
        z : OUT STD_LOGIC ) ;
END priority ;


ARCHITECTURE Behavior OF priority IS
BEGIN

y <= "11" WHEN w(3)='1' ELSE
     "10" WHEN w(2)='1' ELSE
     "01" WHEN w(1)='1' ELSE
     "00" ;
z <= '0' WHEN w="0000" ELSE '1' ;

END Behavior ;