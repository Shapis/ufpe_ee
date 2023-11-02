LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.pkg_buzzer.ALL;

ENTITY controle IS
	PORT (
		clock, key1, key2, key3, key4 : IN std_logic;
		stop, play_pause, skip, mute : OUT std_logic
	);
END controle;

ARCHITECTURE estrutural OF controle IS
	SIGNAL b2, toggle2, b4, toggle4 : std_logic;
BEGIN
	debouncer1 : debouncer PORT MAP ( 
		clk => clock,
		button => key1,
		result => mute
	);
	
	debouncer2 : debouncer PORT MAP ( 
		clk => clock,
		button => key2,
		result => b2
	);
	
	debouncer3 : debouncer PORT MAP ( 
		clk => clock,
		button => key3,
		result => skip
	);
	
	debouncer4 : debouncer PORT MAP ( 
		clk => clock,
		button => key4,
		result => b4
	);
	
	PROCESS (b2)
		BEGIN
		IF (toggle4 = '1') THEN
			toggle2 <= '0';
		ELSIF FALLING_EDGE(b2) THEN
			IF (toggle2 = '0') THEN
				toggle2 <= '1';
			ELSE
				toggle2 <= '0';
			END IF;
		END IF;
	END PROCESS;
	
	play_pause <= toggle2;
	
	PROCESS (b4)
		BEGIN
		IF FALLING_EDGE(b4) THEN
			IF (toggle4 = '0') THEN
				toggle4 <= '1';
			ELSE
				toggle4 <= '0';
			END IF;
		END IF;
	END PROCESS;
	stop <= toggle4;
	
END estrutural;
