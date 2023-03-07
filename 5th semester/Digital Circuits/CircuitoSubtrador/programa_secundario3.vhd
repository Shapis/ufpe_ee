library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity programa_secundario3 is
port(A,B,C,D: in  std_logic;
	  I, J, K: out	 std_logic);
end programa_secundario3;
	  
architecture comportamento of programa_secundario3 is
begin
 
I<= (A and (not B) and C and (not D)) or (A and (not B) and C and D) OR (A and B and C and (not D)) ;
J<= ((not A) and B and C and (not D)) or ((not A) and B and C and D) OR (A and (not B) and (not C) and D) or (A and (not B) and C and D) or (A and B and (not C) and D) OR (A and B and C and (not D));
K<= ((not A) and B and (not C) and D) or ((not A) and B and C and D) OR (A and B and (not C) and D) OR (A and B and C and (not D));

end comportamento;