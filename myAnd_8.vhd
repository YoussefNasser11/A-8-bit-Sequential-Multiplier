---------------------------------- And ----------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity myAnd_8 is
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

end entity myAnd_8;

architecture bhv of myAnd_8 is
begin
process(multiplier, multiplicand)
begin
for i in length-1 downto 0 loop
andOUTPUT(i) <= multiplicand(i) and multiplier;
end loop;
end process;
end architecture;

---------------------------------- And ----------------------------------