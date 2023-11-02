LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY divisor_clock IS
	PORT (Clk_in 	: IN std_logic;
			Overflow : IN std_logic_vector (27 DOWNTO 0);
			Clk_out	: OUT std_logic := '0');		
END divisor_clock;

ARCHITECTURE clock OF divisor_clock IS
	SIGNAL toggle : std_logic := '0';
	SIGNAL cnt : integer := 0;
BEGIN
	PROCESS(Clk_in)
	BEGIN
		IF rising_edge(Clk_in) THEN
			IF cnt < to_integer(unsigned(Overflow)) THEN
				cnt <= cnt + 1; --incrementa
				toggle <= toggle;	
			ELSE
				cnt <= 0; --reinicia
				toggle <= not toggle; --alterna							
			END IF;
		END IF;
	END PROCESS;	
	Clk_out <= toggle;
END clock;