---------------------------------- Total System ----------------------------------
-------------------------------------------------------------------------------
-- IEEE libraries
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------
entity Final_Project_VHDL is
generic(length: integer := 8);

  port
  (
    clk : IN std_logic;
    reset : IN std_logic;
    start : IN std_logic;
	 A: IN std_logic_vector(length-1 downto 0); 
	 B: IN std_logic_vector(length-1 downto 0);
    P : OUT std_logic_vector((2*length)-1 downto 0);
	 done : OUT std_logic
  );

end entity Final_Project_VHDL;

-------------------------------------------------------------------------------
-- architecture declaration
-------------------------------------------------------------------------------

architecture bhv of Final_Project_VHDL is

---------------------------------- Multplier REG ----------------------------------
component myReg8_multiplier IS

generic(length: integer := 8);
	PORT( clk : IN STD_LOGIC;
        load: IN STD_LOGIC;
        shiftRight: IN STD_LOGIC;
         datain : IN STD_LOGIC_VECTOR(length-1 DOWNTO 0);
         reg_out : OUT STD_LOGIC
        );           
END component myReg8_multiplier;

---------------------------------- Multplier REG ----------------------------------



---------------------------------- Multplicand REG ----------------------------------
component myReg8_multiplicand IS
generic(length: integer := 8);

	PORT( clk : IN STD_LOGIC;
        load: IN STD_LOGIC;
         datain : IN STD_LOGIC_VECTOR(length-1 DOWNTO 0);
         reg_out : OUT STD_LOGIC_VECTOR(length-1 DOWNTO 0)
        );           
END component myReg8_multiplicand;
---------------------------------- Multplicand REG ----------------------------------

---------------------------------- Adder ----------------------------------
component myAdder is
    generic(
        length : Integer := 8
    ); 
	 port(
       A : in std_logic_vector(length-1 downto 0);
       B : in std_logic_vector(length-1 downto 0);
       SUM : out std_logic_vector(length-1 downto 0);
		 COUT : OUT STD_logic
    );
end component myAdder;

---------------------------------- Adder ----------------------------------




---------------------------------- And ----------------------------------
component myAnd_8 is
  generic
  (
    length : integer:= 8
  );

  port
  (
    multiplier : IN std_logic;
    multiplicand : IN std_logic_vector(length-1 downto 0);
    andOUTPUT: OUT std_logic_vector(length-1 downto 0)
  );

end component myAnd_8;
---------------------------------- And ----------------------------------


---------------------------------- shift_17 ----------------------------------


-------------------------------------------------------------------------------
-- IEEE libraries
-------------------------------------------------------------------------------
 

-------------------------------------------------------------------------------
-- component declaration
-------------------------------------------------------------------------------
component myShiftReg_17 is
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

end component myShiftReg_17;

---------------------------------- shift_17 ----------------------------------


---------------------------------- controller ----------------------------------

-------------------------------------------------------------------------------
-- IEEE libraries
-------------------------------------------------------------------------------
 

-------------------------------------------------------------------------------
-- component declaration
-------------------------------------------------------------------------------
component myController_FSM IS
   PORT(
	
      clk      				: IN   STD_LOGIC;
      start    				: IN   STD_LOGIC;
      reset    				: IN   STD_LOGIC;

      load_multiplier   	: OUT  STD_LOGIC;
		shift_multiplier   	: OUT  STD_LOGIC;
		shift_multiplicand   : OUT  STD_LOGIC;
		reset_product   		: OUT  STD_LOGIC;
		load_product   		: OUT  STD_LOGIC;
		shift_product   		: OUT  STD_LOGIC;
		done   					: OUT  STD_LOGIC
		
		);
				
END component myController_FSM;

---------------------------------- controller ----------------------------------

-------------------------------------------------------------------------------
-- signal declaration
-------------------------------------------------------------------------------

signal      load_multiplier   	:   STD_LOGIC;
signal		shift_multiplier   	:   STD_LOGIC;
signal		shift_multiplicand   :   STD_LOGIC;
signal		reset_product   		:   STD_LOGIC;
signal		load_product   		:   STD_LOGIC;
signal		shift_product   		:   STD_LOGIC;

signal 		multiplier_0			: 	 STD_LOGIC;
signal 		multiplicand_out		: 	 STD_LOGIC_VECTOR(length-1 downto 0);

signal 		andOUTPUT				: 	 STD_LOGIC_VECTOR(length-1 downto 0);

signal 		prod_MSBs_out			: 	 STD_LOGIC_VECTOR(length-1 downto 0);
signal 		product_in				: 	 STD_LOGIC_VECTOR(length downto 0);
signal 		SUM						: 	 STD_LOGIC_VECTOR(length-1 downto 0);
signal 		COUT						: 	 STD_LOGIC;

signal 		product_main_out		: 	 STD_LOGIC_VECTOR((2*length)-1 downto 0);



begin 


--A(7 DOWNTO 2) <= "000000";

--B(7 DOWNTO 2) <= "000000";

cntrl: mycontroller_FSM port map (clk, start, reset, load_multiplier, shift_multiplier, shift_multiplicand, reset_product, load_product, shift_product, done);

multiplier_REG: myReg8_multiplier port map (clk, load_multiplier, shift_multiplier, A, multiplier_0);

multiplicand_REG : myReg8_multiplicand port map (clk, shift_multiplicand, B, multiplicand_out);

and_gate: myAnd_8 port map (multiplier_0, multiplicand_out, andOUTPUT);

myAdder_gate: myAdder port map (andOUTPUT, prod_MSBs_out, SUM, COUT);

product_in <= COUT & SUM;

shift_17_REG: myShiftReg_17 port map (clk, reset_product, load_product, shift_product, product_in, product_main_out);


P<= product_main_out;

prod_MSBs_out <=product_main_out((2*length)-1 downto length);

end architecture;
