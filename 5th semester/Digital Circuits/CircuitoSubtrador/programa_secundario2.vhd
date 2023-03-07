library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity programa_secundario2 is
port(A,B,Cin: in  std_logic;
	  Cout,S: out	 std_logic);
end programa_secundario2;
	  
architecture comportamento of programa_secundario2 is
begin
 
S<= (A xor B) xor Cin;
Cout<= not ((A nand Cin) and (B nand Cin) and (A nand B));

end comportamento;