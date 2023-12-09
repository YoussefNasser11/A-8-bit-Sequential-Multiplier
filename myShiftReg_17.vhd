---------------------------------- shift_17 ----------------------------------


-------------------------------------------------------------------------------
-- IEEE libraries
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------
entity myShiftReg_17 is
generic(length: integer := 8);
  port
  (
    clk : IN std_logic;
    reset : IN std_logic;
    load : IN std_logic;
    shiftRight : IN std_logic;
    datain : IN std_logic_vector(length downto 0);
    dataout : OUT std_logic_vector((2*length)-1 downto 0)

  );

end entity myShiftReg_17;

-------------------------------------------------------------------------------
-- architecture declaration
-------------------------------------------------------------------------------

architecture bhv of myShiftReg_17 is
begin 
PROCESS(clk)

-------------------------------------------------------------------------------
-- variable declaration
-------------------------------------------------------------------------------
    variable reg_temp: std_logic_vector((2*length) downto 0);
    BEGIN 
    	IF rising_edge(clk) THEN
			if reset = '1' then
				reg_temp := (others => '0');
			elsif load = '1' then
				reg_temp((2*length) downto length) := datain;
			elsif shiftRight = '1' then
            reg_temp :=  '0' & reg_temp(reg_temp'high downto reg_temp'low + 1);
         END IF;
         END IF; 
         dataout <= reg_temp((2*length)-1 downto 0);
    END PROCESS;
end architecture;


---------------------------------- shift_17 ----------------------------------