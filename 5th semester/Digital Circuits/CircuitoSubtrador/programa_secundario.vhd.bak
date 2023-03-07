library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity programa_secundario is
port(A,B,Cin: in  std_logic;
	  Cout,S: out	 std_logic);
end programa_secundario;
	  
architecture comportamento of programa_secundario is
begin
 
S<=A xor B xor Cin;
Cout<= (A and B) or (A and Cin) or (B and Cin);

end comportamento;

