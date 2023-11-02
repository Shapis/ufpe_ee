LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
PACKAGE pkg_buzzer IS

COMPONENT debouncer
	PORT(
		clk, button : IN std_logic;
		result: OUT std_logic);
END COMPONENT;

COMPONENT contador
	PORT (clock, enable, clear : IN std_logic;
			overflow : IN std_logic_vector (3 DOWNTO 0);
			contagem: OUT std_logic);
END COMPONENT;

COMPONENT divisor_clock
	PORT (Clk_in : IN std_logic;
			Overflow : IN std_logic_vector (27 DOWNTO 0);
			Clk_out: OUT std_logic);
END COMPONENT;

COMPONENT temporizador IS
PORT ( Clk, Disparo :IN std_logic;
		 Overflow : IN std_logic_vector (27 DOWNTO 0);	
		 Q :OUT std_logic );
END COMPONENT;

COMPONENT furElise IS
PORT ( 	Clk_out, Disparo  : OUT std_logic;
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END COMPONENT;

COMPONENT overTheWaves IS
PORT ( 	Clk_out, Disparo  : OUT std_logic;
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END COMPONENT;

COMPONENT overTheRainbow IS
PORT ( 	Clk_out, Disparo  : OUT std_logic;
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END COMPONENT;

COMPONENT frereJacque IS
PORT ( 	Clk_out, Disparo  : OUT std_logic;
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END COMPONENT;

COMPONENT topGear IS
PORT ( 	Clk_out, Disparo  : OUT std_logic;
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END COMPONENT;

END PACKAGE;