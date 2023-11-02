LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.pkg_buzzer.ALL;
USE IEEE.numeric_std.ALL;

ENTITY display IS
	PORT (
		clock, stop, play_pause : IN std_logic;
		dig : OUT std_logic_vector (1 TO 4);
		seg : OUT std_logic_vector (0 TO 7)
		);
END display;

ARCHITECTURE estrutural OF display IS
	SIGNAL pulso, ena, seletor_display, play, seg7 : std_logic;
	SIGNAL q : std_logic_vector (3 DOWNTO 0);
	SIGNAL segmentos : std_logic_vector (0 TO 6);
	SIGNAL dec_seg, uni_seg, uni_min, temp : INTEGER RANGE 0 TO 9;
	SIGNAL dez_seg : INTEGER RANGE 0 TO 5;
	SIGNAL alterna : INTEGER RANGE 0 TO 3;
BEGIN
	clock_10Hz : divisor_clock PORT MAP (
		Clk_in 	=> clock,
		Overflow => std_logic_vector(to_unsigned(2500000, 28)),
		Clk_out	=> pulso
	);
	
	alterna_display : divisor_clock PORT MAP (
		Clk_in 	=> clock,
		Overflow => std_logic_vector(to_unsigned(16666, 28)),
		Clk_out	=> seletor_display
	);
	
	contador: ENTITY WORK.contador
	PORT MAP(pulso => pulso, play_pause => play_pause, stop => stop, dec_segundo => dec_seg, uni_segundo => uni_seg, dez_segundo => dez_seg, uni_minuto => uni_min);
	
	PROCESS(seletor_display)
	BEGIN
		IF(rising_edge(seletor_display)) THEN
			alterna <= alterna + 1;
			IF (alterna = 3) THEN
				alterna <= 0;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS (clock)
	BEGIN
		CASE alterna IS
			WHEN 0 =>
				dig(1) <= '0';
				dig(2) <= '1';
				dig(3) <= '1';
				dig(4) <= '1';
				temp 	 <= dec_seg;
				seg7 <= '1';
			WHEN 1 =>
				dig(1) <= '1';
				dig(2) <= '0';
				dig(3) <= '1';
				dig(4) <= '1';
				temp 	 <= uni_seg;
				seg7 <= '0';
			WHEN 2 =>
				dig(1) <= '1';
				dig(2) <= '1';
				dig(3) <= '0';
				dig(4) <= '1';
				temp 	 <= dez_seg;
				seg7 <= '1';
			WHEN 3 =>
				dig(1) <= '1';
				dig(2) <= '1';
				dig(3) <= '1';
				dig(4) <= '0';
				temp 	 <= uni_min;
				seg7 <= '0';
		END CASE;
		
		CASE temp IS
			WHEN 0 =>
				segmentos <= "0000001";
			WHEN 1 =>
				segmentos <= "1001111";
			WHEN 2 =>
				segmentos <= "0010010";
			WHEN 3 =>
				segmentos <= "0000110";
			WHEN 4 =>
				segmentos <= "1001100";
			WHEN 5 =>
				segmentos <= "0100100";
			WHEN 6 =>
				segmentos <= "0100000";
			WHEN 7 =>
				segmentos <= "0001111";
			WHEN 8 =>
				segmentos <= "0000000";
			WHEN 9 =>
				segmentos <= "0000100";
			WHEN OTHERS =>
				segmentos <= "1111111";
		END CASE;	 
	END PROCESS;
	
	seg <= segmentos & seg7;
							 
END estrutural;
