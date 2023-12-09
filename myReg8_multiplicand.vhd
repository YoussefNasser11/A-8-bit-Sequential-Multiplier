---------------------------------- Multplicand REG ----------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

ENTITY myReg8_multiplicand IS
generic(length: integer := 8);

	PORT( clk : IN STD_LOGIC;
        load: IN STD_LOGIC;
         datain : IN STD_LOGIC_VECTOR(length-1 DOWNTO 0);
         reg_out : OUT STD_LOGIC_VECTOR(length-1 DOWNTO 0)
        );           
END ENTITY myReg8_multiplicand;

ARCHITECTURE arch_myReg8_multiplicand OF myReg8_multiplicand IS
BEGIN
	PROCESS(clk)
    BEGIN 
    	IF rising_edge(clk) THEN
			IF load = '1' then
					reg_out <= datain;
         END IF;
         END IF; 
    END PROCESS;    
END ARCHITECTURE arch_myReg8_multiplicand;

---------------------------------- Multplicand REG ----------------------------------