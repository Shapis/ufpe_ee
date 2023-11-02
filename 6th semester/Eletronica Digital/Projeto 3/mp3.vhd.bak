LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.pkg_buzzer.ALL;

ENTITY sirene_estrutural IS
	PORT (clock, stop, play, skip, mute : IN std_logic;
			buzzer: OUT std_logic);
END sirene_estrutural;

ARCHITECTURE estrutural OF sirene_estrutural IS
	SIGNAL t1, t2, t4 : std_logic;
	SIGNAL t3, t5 : std_logic_vector (27 DOWNTO 0);
	SIGNAL musica1t2, musica1t4, musica2t2, musica2t4, musica3t2, musica3t4, musica4t2, musica4t4 : std_logic;
	SIGNAL musica1t3, musica1t5, musica2t3, musica2t5, musica3t3, musica3t5, musica4t3, musica4t5 : std_logic_vector (27 DOWNTO 0);
	SIGNAL musica1play, musica1stop, musica2play, musica2stop, musica3play, musica3stop, musica4play, musica4stop : std_logic;
	SIGNAL freq_nota : std_logic;
	
--FSM Declaração de estados 
	TYPE musicas IS (m1, m2, m3, m4);
	SIGNAL musica_atual: musicas;
	SIGNAL proxima_musica: musicas;
BEGIN
	temp : temporizador PORT MAP ( 
		Clk => clock,
		Disparo => t2,
		Overflow =>	t3,
		Q => t1
	);
		
	div_clock : divisor_clock PORT MAP (
		Clk_in 	=> clock,
		Overflow => t5,
		Clk_out	=> freq_nota
	);
	buzzer <= freq_nota and not mute;
	
	musica1 : furElise PORT MAP (
		Clk_out  => musica1t4, --t4,
		Disparo  => musica1t2, --t2,
		Temp_out => musica1t3, --t3,
		Freq_out => musica1t5, --t5,
		Clk_in  => clock,
		Stop_in => musica1stop, --stop,
		Play_in => musica1play, --play,
		Duracao => t1 --t1
	);
	
	musica2 : overTheWaves PORT MAP ( 	
		Clk_out  => musica2t4, --t4,
		Disparo  => musica2t2, --t2,
		Temp_out => musica2t3, --t3,
		Freq_out => musica2t5, --t5,
		Clk_in  => clock,
		Stop_in => musica2stop, --stop,
		Play_in => musica2play, --play,
		Duracao => t1 --t1
	);
	
	musica3 : overTheRainbow PORT MAP ( 	
		Clk_out  => musica3t4, --t4,
		Disparo  => musica3t2, --t2,
		Temp_out => musica3t3, --t3,
		Freq_out => musica3t5, --t5,
		Clk_in  => clock,
		Stop_in => musica3stop, --stop,
		Play_in => musica3play, --play,
		Duracao => t1 --t1
	);
	
	musica4 : frereJacque PORT MAP ( 	
		Clk_out  => musica4t4, --t4,
		Disparo  => musica4t2, --t2,
		Temp_out => musica4t3, --t3,
		Freq_out => musica4t5, --t5,
		Clk_in  => clock,
		Stop_in => musica4stop, --stop,
		Play_in => musica4play, --play,
		Duracao => t1 --t1
	);
	
	L1: PROCESS(skip)
	BEGIN
		IF rising_edge(skip) THEN 
			IF (stop = '1') THEN
				musica_atual <= proxima_musica;
			END IF;
		END IF;
	END PROCESS L1;
	
	L2: PROCESS (musica_atual)
	BEGIN
		CASE musica_atual IS
			WHEN m1 =>
				proxima_musica <= m2;	
			WHEN m2 =>
				proxima_musica <= m3;
			WHEN m3 =>
				proxima_musica <= m4;
			WHEN m4 =>
				proxima_musica <= m1;
			WHEN OTHERS =>
				--recupera de estado inválido
				proxima_musica <= m1; --reinicia
		END CASE;
	END PROCESS L2;
	
	L3: PROCESS (musica_atual)
	BEGIN
		CASE musica_atual IS
			WHEN m1 =>
				musica1play <= play;
				musica1stop <= stop;
				t2 <= musica1t2;
				t3 <= musica1t3;
				t5 <= musica1t5;
			WHEN m2 =>
				musica2play <= play;
				musica2stop <= stop;
				t2 <= musica2t2;
				t3 <= musica2t3;
				t5 <= musica2t5;
			WHEN m3 =>
				musica3play <= play;
				musica3stop <= stop;
				t2 <= musica3t2;
				t3 <= musica3t3;
				t5 <= musica3t5;
			WHEN m4 =>
				musica4play <= play;
				musica4stop <= stop;
				t2 <= musica4t2;
				t3 <= musica4t3;
				t5 <= musica4t5;
		END CASE;	
	END PROCESS;
END estrutural;
