---------------------------------- Multplier REG ----------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

ENTITY myReg8_multiplier IS
generic(length: integer := 8);
	PORT( clk : IN STD_LOGIC;
        load: IN STD_LOGIC;
        shiftRight: IN STD_LOGIC;
         datain : IN STD_LOGIC_VECTOR(length-1 DOWNTO 0);
         reg_out : OUT STD_LOGIC
        );           
END ENTITY myReg8_multiplier;

ARCHITECTURE arch_myReg8_multiplier OF myReg8_multiplier IS
BEGIN
	PROCESS(clk)
    variable reg_temp: std_logic_vector(length-1 downto 0);
    BEGIN 
    	IF rising_edge(clk) THEN
			IF load = '1' then
					reg_temp := datain;
            elsif shiftRight = '1' then
            reg_temp :=  '0' & reg_temp(reg_temp'high downto reg_temp'low + 1); 
            
            END IF;
         END IF; 
         reg_out <= reg_temp(0); -- get LSB of reg_temp
    END PROCESS;    
END ARCHITECTURE arch_myReg8_multiplier;
---------------------------------- Multplier REG ----------------------------------