---------------------------------- controller ----------------------------------

-------------------------------------------------------------------------------
-- IEEE libraries
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------
ENTITY myController_FSM IS
   PORT(
	
      clk      				: IN   STD_LOGIC;
      start    				: IN   STD_LOGIC;
      reset    				: IN   STD_LOGIC;
		
		--debug_state: OUT std_logic_vector (1 downto 0);
		----debug_counter: OUT std_logic_vector(2 downto 0);

      load_multiplier   	: OUT  STD_LOGIC;
		shift_multiplier   	: OUT  STD_LOGIC;
		shift_multiplicand   : OUT  STD_LOGIC;
		reset_product   		: OUT  STD_LOGIC;
		load_product   		: OUT  STD_LOGIC;
		shift_product   		: OUT  STD_LOGIC;
		done   					: OUT  STD_LOGIC
		
		);
				
END myController_FSM;

-------------------------------------------------------------------------------
-- architecture declaration
-------------------------------------------------------------------------------
ARCHITECTURE bhv OF myController_FSM IS
   TYPE STATE_TYPE IS (s0, s1, s2, s3);
   SIGNAL state   : STATE_TYPE;
	
BEGIN
   PROCESS (clk, reset)
	variable counter: std_logic_vector(2 downto 0); 
	variable overflowFlag: std_logic;
   BEGIN
      IF reset = '1' THEN
         state <= s0;
      ELSIF (clk'EVENT AND clk = '1') THEN
         CASE state IS
            WHEN s0=>	
               IF start = '1' THEN
                  state <= s1;
               ELSE
                  state <= s0;
               END IF;
					
					counter := (others => '0');
					
					
					
					
            WHEN s1=>
				
  
               state <= s2;
					if counter < "111" then
					counter := std_logic_vector(unsigned(counter) + 1);
					overflowFlag := '0';
					else
					overflowFlag := '1';
					counter := (others => '0');
					end if;

            WHEN s2=>
               IF overflowFlag = '1' THEN
                  state <= s3;
               ELSE
                  state <= s1;
               END IF;
					
				WHEN s3=>
					state <= s0;
					
         END CASE;
			----debug_counter <= counter;
      END IF;
   END PROCESS;
   
   PROCESS (state)
   BEGIN
      CASE state IS
			
			WHEN s0 =>
				done <= '0';
				load_multiplier   	  <=  '1'     ;
				shift_multiplier   	  <=  '0'     ;
				shift_multiplicand     <=     '1'  ;
				reset_product   		  <=    '1'   ;
				load_product   		  <=     '0'  ;
				shift_product   		  <=     '0';
				
				
				--debug_state <= "00";
		
         WHEN s1 =>
            
				load_multiplier <= '0';
				shift_multiplicand <= '0';
				reset_product <= '0';
				load_product <= '1';
				shift_multiplier   	  <= '0';
				shift_product   		  <=  '0';
				done <= 		'0';
				
				--debug_state <= "01";
				
         WHEN s2 =>
				shift_product <= '1';
				shift_multiplier <= '1';
				load_multiplier <= '0';
				shift_multiplicand <= '0';
				reset_product <= '0';
				load_product <= '0';
				done <= 		'0';
				
				--debug_state <= "10";
				
			WHEN s3 =>

				shift_product <= '0';
				shift_multiplier <= '0';
				load_multiplier <= '0';
				shift_multiplicand <= '0';
				reset_product <= '0';
				load_product <= '0';
				done <= 		'1';
				
				--debug_state <= "11";
				
      END CASE;
   END PROCESS;
   
END bhv;

---------------------------------- controller ----------------------------------