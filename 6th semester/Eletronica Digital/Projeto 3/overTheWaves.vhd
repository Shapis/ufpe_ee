LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY overTheWaves IS
PORT ( 	Clk_out, Disparo  : OUT std_logic := '0';
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END overTheWaves;
ARCHITECTURE bhv OF overTheWaves IS
  -- Subprograma para aplicar o tempo e frequencia
  --para atribuição de saídas nos estados
  PROCEDURE nota (CONSTANT ov_f : IN integer;
						CONSTANT ov_t : IN integer ) IS
  BEGIN
		Temp_out <= std_logic_vector(to_unsigned(ov_t,Temp_out'LENGTH)); --define a duração	proxima nota			
		Freq_out <= std_logic_vector(to_unsigned(ov_f,Freq_out'LENGTH)); --define a frequência nota atual
		Disparo <= '1';  --dispara o temp a próxima nota	
  END nota;
	--clock principal da placa
	CONSTANT clk_FPGA : integer := 50000000; --50MHz
	--overflow para frequencias (50MHz)
	CONSTANT C4 : integer := 47802; --50MHz/1046Hz (C4 ou Dó4)
	CONSTANT D4 : integer := 42553; --50MHz/1175Hz (D4 ou Ré4)
	CONSTANT E4 : integer := 37937; --50MHz/1318Hz (E4 ou Mi4)
	CONSTANT F4 : integer := 35791; --50MHz/1397Hz (F4 ou Fá4)
	CONSTANT G4 : integer := 31290; --50MHz/1598Hz (G4 ou Sol4)
	
	CONSTANT D_4 : integer := 40193; --50MHz/1175Hz (D#4 ou Ré#4)
	
	CONSTANT C3 : integer := 95602; --50MHz/1046Hz (C3 ou Dó3)
	CONSTANT D3 : integer := 85179; --50MHz/1175Hz (D3 ou Ré3)
	CONSTANT E3 : integer := 75873; --50MHz/1318Hz (E3 ou Mi3)
	CONSTANT F3 : integer := 71633; --50MHz/1397Hz (F3 ou Fá3)
	CONSTANT G3 : integer := 63776; --50MHz/1598Hz (G3 ou Sol3)
	CONSTANT H3 : integer := 56818; --50MHz/1175Hz (H3 ou Lá3)
	CONSTANT I3 : integer := 50607; --50MHz/1175Hz (I3 ou Si3)
	
	CONSTANT D_3 : integer := 80386; --50MHz/1175Hz (D#3 ou Ré#3)
	CONSTANT G_3 : integer := 60168; --50MHz/1175Hz (G#3 ou Sol#3)
	CONSTANT H_3 : integer := 53648; --50MHz/1175Hz (H#3 ou Lá#3)
	
	--overflow para tempos (50MHz)
	-- BPM igual a 60 implica que t1, 1 batida, representa 1 seg
	-- BPM igual a 120 implica que t1, 1 batida, representa 0.5 seg
	CONSTANT BPM : integer := 120; --batidas por minuto
	CONSTANT BPS : integer := BPM / 60; --batidas por segundo
	CONSTANT ov_t4 : integer := (4 * clk_FPGA) / BPS; --overflow 4 batidas
	CONSTANT ov_t2 : integer := (2 * clk_FPGA) / BPS; --overflow 2 batidas
	CONSTANT ov_t1 : integer := clk_FPGA / BPS; --overflow 1 batida
	CONSTANT ov_t1_2 : integer := (clk_FPGA / 2) / BPS; --overflow 1/2 batidas
	CONSTANT ov_t1_4	: integer := (clk_FPGA / 4) / BPS; --overflow 1/4 batidas
	
	--FSM Declaração de estados 
	TYPE estados IS (s0, s1, s2, s3, s4 ,s5 ,s6,
						  s7, s8, s9, s10, s11, s12,
						  s13, s14, s15, s16, s17, s18,
						  s19, s20, s21, s22, s23, s24,
						  s25, s26, s27, s28, s29, s30,
						  s31, s32, s33);
	SIGNAL estado_atual: estados;
	SIGNAL proximo_estado: estados;
BEGIN
	--Lógica para controle do estado atual
	L1: PROCESS(Clk_in)
	BEGIN
		IF rising_edge(Clk_in) THEN 
			estado_atual <= proximo_estado;
		END IF;
	END PROCESS L1;
	--Lógica para próximo estado
	L2: PROCESS (estado_atual, Duracao)
	BEGIN
		CASE estado_atual IS
			WHEN s0 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s1;
					ELSE proximo_estado <= s0;
					END IF;
				END IF;
			WHEN s1 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s2;
					ELSE proximo_estado <= s1;					
					END IF;
				END IF;	
			WHEN s2 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s3;					
					ELSE proximo_estado <= s2;
					END IF;	
				END IF;
			WHEN s3 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s4;					
					ELSE proximo_estado <= s3;
					END IF;	
				END IF;
			WHEN s4 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s5;					
					ELSE proximo_estado <= s4;
					END IF;	
				END IF;
			WHEN s5 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s6;					
					ELSE proximo_estado <= s5;
					END IF;	
				END IF;
			WHEN s6 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s7;					
					ELSE proximo_estado <= s6;
					END IF;	
				END IF;
			WHEN s7 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s8;					
					ELSE proximo_estado <= s7;
					END IF;	
				END IF;
			WHEN s8 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s9;					
					ELSE proximo_estado <= s8;
					END IF;	
				END IF;
			WHEN s9 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s10;					
					ELSE proximo_estado <= s9;
					END IF;
				END IF;
			WHEN s10 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s11;
					ELSE proximo_estado <= s10;
					END IF;
				END IF;
			WHEN s11 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s12;
					ELSE proximo_estado <= s11;					
					END IF;
				END IF;	
			WHEN s12 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s13;					
					ELSE proximo_estado <= s12;
					END IF;	
				END IF;
			WHEN s13 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s14;					
					ELSE proximo_estado <= s13;
					END IF;	
				END IF;
			WHEN s14 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s15;					
					ELSE proximo_estado <= s14;
					END IF;	
				END IF;
			WHEN s15 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s16;					
					ELSE proximo_estado <= s15;
					END IF;	
				END IF;
			WHEN s16 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s17;					
					ELSE proximo_estado <= s16;
					END IF;	
				END IF;
			WHEN s17 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s18;					
					ELSE proximo_estado <= s17;
					END IF;	
				END IF;
			WHEN s18 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s19;					
					ELSE proximo_estado <= s18;
					END IF;	
				END IF;
			WHEN s19 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s20;					
					ELSE proximo_estado <= s19;
					END IF;
				END IF;
			WHEN s20 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s21;
					ELSE proximo_estado <= s20;
					END IF;
				END IF;
			WHEN s21 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s22;
					ELSE proximo_estado <= s21;					
					END IF;
				END IF;	
			WHEN s22 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s23;					
					ELSE proximo_estado <= s22;
					END IF;	
				END IF;
			WHEN s23 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s24;					
					ELSE proximo_estado <= s23;
					END IF;	
				END IF;
			WHEN s24 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s25;					
					ELSE proximo_estado <= s24;
					END IF;	
				END IF;
			WHEN s25 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s26;					
					ELSE proximo_estado <= s25;
					END IF;	
				END IF;
			WHEN s26 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s27;					
					ELSE proximo_estado <= s26;
					END IF;	
				END IF;
			WHEN s27 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s28;					
					ELSE proximo_estado <= s27;
					END IF;	
				END IF;
			WHEN s28 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s29;					
					ELSE proximo_estado <= s28;
					END IF;	
				END IF;
			WHEN s29 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s30;					
					ELSE proximo_estado <= s29;
					END IF;
				END IF;
			WHEN s30 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s31;
					ELSE proximo_estado <= s30;
					END IF;
				END IF;
			WHEN s31 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s32;
					ELSE proximo_estado <= s31;					
					END IF;
				END IF;	
			WHEN s32 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s33;					
					ELSE proximo_estado <= s32;
					END IF;	
				END IF;
			WHEN s33 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s1;					
					ELSE proximo_estado <= s33;
					END IF;	
				END IF;
			WHEN OTHERS =>
				--recupera de estado inválido
				proximo_estado <= s0; --reinicia
		END CASE;
	END PROCESS L2;
	--Lógica para saída da FSM
	L3: PROCESS (Clk_in, estado_atual)
	BEGIN
		IF rising_edge(Clk_in) THEN
			CASE estado_atual IS 
				WHEN s0 => nota(0, ov_t2); --s0 apenas inicia a prox nota
				WHEN s1 => nota(E3, ov_t2);
				WHEN s2 => nota(E3, ov_t1);
				WHEN s3 => nota(D_3, ov_t1);
				WHEN s4 => nota(E3, ov_t1);
				WHEN s5 => nota(G3, ov_t1);
				WHEN s6 => nota(C4, ov_t2);
				WHEN s7 => nota(C4, ov_t2);
				WHEN s8 => nota(I3, ov_t1);
				WHEN s9 => nota(C4, ov_t1);
				WHEN s10 => nota(D4, ov_t1);
				WHEN s11 => nota(C4, ov_t1);
				WHEN s12 => nota(I3, ov_t1);
				WHEN s13 => nota(C4, ov_t1);
				WHEN s14 => nota(E3, ov_t1);
				WHEN s15 => nota(G3, ov_t1);
				WHEN s16 => nota(I3, ov_t4);
				WHEN s17 => nota(I3, ov_t2);
				WHEN s18 => nota(F3, ov_t2);
				WHEN s19 => nota(F3, ov_t1);
				WHEN s20 => nota(E3, ov_t1);
				WHEN s21 => nota(F3, ov_t1);
				WHEN s22 => nota(G3, ov_t1);
				WHEN s23 => nota(I3, ov_t4);
				WHEN s24 => nota(H_3, ov_t1);
				WHEN s25 => nota(I3, ov_t1);
				WHEN s26 => nota(C4, ov_t1);
				WHEN s27 => nota(I3, ov_t1);
				WHEN s28 => nota(H_3, ov_t1);
				WHEN s29 => nota(I3, ov_t1);
				WHEN s30 => nota(F3, ov_t1);
				WHEN s31 => nota(I3, ov_t1);
				WHEN s32 => nota(G3, ov_t4);
				WHEN s33 => nota(0, ov_t2);
--Não é necessário WHEN OTHERS pois
--o controle é feito no processo L2
			END CASE;
		END IF;
	END PROCESS L3;
	
	--Atribuição contínua
	Clk_out <= Duracao AND Clk_in;
END bhv;