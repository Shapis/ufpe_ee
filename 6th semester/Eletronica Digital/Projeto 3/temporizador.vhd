LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY temporizador IS
PORT ( Clk, Disparo :IN std_logic;
		 Overflow : IN std_logic_vector (27 DOWNTO 0);	
		 Q :OUT std_logic := '0');
END temporizador;
ARCHITECTURE sem_rearme OF temporizador IS
	SIGNAL cnt : integer := 0;
BEGIN
	PROCESS (Clk)
	BEGIN --reset assíncrono
		IF rising_edge(Clk) THEN
			IF (Disparo = '1' AND cnt = 0) THEN
				cnt <= to_integer(unsigned(Overflow)); --carrega o temp.
			ELSIF (Disparo = '0' AND cnt = 0) THEN cnt <= 0;--retem
			ELSE cnt <= cnt - 1 ; --decrementa
			END IF;
		END IF;
		--nível alto durante o período de contagem
		IF cnt /= 0 THEN Q <= '1';
		ELSE Q <= '0';
		END IF;
	END PROCESS;
END sem_rearme;