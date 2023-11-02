LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.pkg_buzzer.ALL;

ENTITY LED IS
	PORT (
		stop, play_pause : IN std_logic;
		leds : OUT std_logic_vector (1 TO 4)
		);
END LED;

ARCHITECTURE estrutural OF LED IS
	
BEGIN
	leds(1) <= not stop;
	leds(2) <= not play_pause;
	leds(3) <= play_pause;
	leds(4) <= not (not stop and not play_pause and play_pause);
END estrutural;
