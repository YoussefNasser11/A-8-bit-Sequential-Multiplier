library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use work.all;

entity Sequential_Multiplier_TB is
	-- empty
	generic(length: integer := 8);

end Sequential_Multiplier_TB;

architecture arch_tb of Sequential_Multiplier_TB is
constant T : time	:=20ns;
--input

signal clk 	: std_logic :='0';
signal reset 	: std_logic;
signal start 	: std_logic;
signal A 	: std_logic_vector(length-1 downto 0);
signal B 	: std_logic_vector(length-1 downto 0);

--output

signal    P :  std_logic_vector((2*length)-1 downto 0);
signal done : std_logic;

--COMPONENTS
component Final_Project_VHDL is
generic(length: integer :=8);

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
  
end component Final_Project_VHDL;

begin

UUT:Final_Project_VHDL
port map (clk,reset,start,A,B,P,done);

	clock_process:process
	begin
		clk <= not clk;
		wait for T/2 ;
		clk <= not clk;
		wait for T/2;
	end process;
	
	STIMULUS_RESET : process
begin
 reset <= '0';
 wait for 15*T;
 reset <= '1';
 wait for T/2;
 reset <= '0';
 wait ;
end process STIMULUS_RESET;
	
	
start_process:process
	begin
	start <='0';
	Wait for 5*T;
	start <='1';
	Wait for 5*T;
	start <='0';
	END PROcess;
	
		A_process: process
begin
wait for T; A <="11111111";
assert A <= "11111111" 
   report "initial value too large"
   severity warning;


                 end process; 
					  
			B_process: process
begin
wait for T; B <="11111111";
assert B <= "11111111" 
   report "initial value too large"
   severity warning;

                 end process;   


					  
end arch_tb;