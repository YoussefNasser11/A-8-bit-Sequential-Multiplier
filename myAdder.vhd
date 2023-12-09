---------------------------------- Adder ----------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity myAdder is
    generic(
        length : Integer := 8
    ); 
	 port(
       A : in std_logic_vector(length-1 downto 0);
       B : in std_logic_vector(length-1 downto 0);
       SUM : out std_logic_vector(length-1 downto 0);
		 COUT : OUT STD_logic
    );
end entity myAdder;

architecture Generic_Adder of myAdder is
    
begin
    process(A,B)
	 variable cin: std_logic_vector(length downto 0);
    begin
	 cin(0) := '0';
        for i in 0 to length-1 loop
sum(i)<= a(i) xor b(i) xor cin(i);
cin(i+1) := (A(i) and B(i)) or (A(i) and Cin(i)) or (B(i) and Cin(i));     
		 end loop;
		 cout<= cin(length);
    end process;
end Generic_Adder;

---------------------------------- Adder ----------------------------------