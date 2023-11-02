LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY lcd_controller IS
  GENERIC(
    clk_freq       :  INTEGER    := 50;    --clock principal em MHz
    display_lines  :  STD_LOGIC  := '0';   --número de linhas do display (0 = uma linha, 1 = duas linhas)
    character_font :  STD_LOGIC  := '0';   --fonte (0 = 5x8 pontos, 1 = 5x10 pontos)
    display_on_off :  STD_LOGIC  := '1';   --display on/off (0 = off, 1 = on)
    cursor         :  STD_LOGIC  := '0';   --cursor on/off (0 = off, 1 = on)
    blink          :  STD_LOGIC  := '0';   --blink on/off (0 = off, 1 = on)
    inc_dec        :  STD_LOGIC  := '1';   --incremento/decremento (0 = decremento, 1 = incremento)
    shift          :  STD_LOGIC  := '0');  --shift on/off (0 = off, 1 = on)
  PORT(
    clk        : IN   STD_LOGIC; --clock principal
    reset_n    : IN   STD_LOGIC;                     --ativo-baixo, reinicializa o LCD
    lcd_enable : IN   STD_LOGIC;                     --retem os dados no controlador LCD
    lcd_bus    : IN   STD_LOGIC_VECTOR(9 DOWNTO 0);  --(9) rs (8) rw (7..0) dado char
    busy       : OUT  STD_LOGIC := '1';              --feedback do controlador (1)ocupado/(0)disponível
    rw, rs, e  : OUT  STD_LOGIC;                     --leitura/escrita, instrução/dado, habilita LCD ativo-alto
    lcd_data   : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)); --sinal de dado (char) para o LCD
END lcd_controller;
ARCHITECTURE bhv OF lcd_controller IS
	--Declaração de estados da FSM
	TYPE ESTADOS IS(ENERGIZACAO, INICIALIZACAO, PRONTO, ENVIAR);
	SIGNAL  estado  : ESTADOS;
BEGIN
	--FSM do 
	PROCESS(clk)
		VARIABLE clk_count : INTEGER := 0; --contador para temporização de eventos
	BEGIN
		IF rising_edge(clk) THEN
			--reinicializa a FSM
			IF(reset_n = '0') THEN
				estado <= ENERGIZACAO;
			END IF;
			CASE estado IS
        -- espera 50ms para garantir a energização do LCD
			WHEN ENERGIZACAO =>
				busy <= '1';
				IF(clk_count < (50000 * clk_freq)) THEN    --espera 50 ms
					clk_count := clk_count + 1;
					estado <= ENERGIZACAO;
				ELSE                                       --energização completa
					clk_count := 0;
					rs <= '0';
					rw <= '0';
					lcd_data <= "00110000"; --8-bits 1L*16 5*8 function_set
					estado <= INICIALIZACAO;
				END IF;
			--sequência de inicialização do display LCD  
			WHEN INICIALIZACAO =>
				busy <= '1'; --LCD ocupado
				clk_count := clk_count + 1;
				IF(clk_count < (10 * clk_freq)) THEN       --function set
					lcd_data <= "0011" & display_lines & character_font & "00";
					e <= '1'; --habilita o LCD (executa o comando)
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (60 * clk_freq)) THEN    --espera 50 us
					lcd_data <= "00000000"; --nenhuma nova instrução, apenas aguarda
					e <= '0'; --desabilita o LCD
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (70 * clk_freq)) THEN    --display on/off control
					lcd_data <= "00001" & display_on_off & cursor & blink;
					e <= '1'; --habilita o LCD (executa o comando)
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (120 * clk_freq)) THEN   --espera 50 us
					lcd_data <= "00000000";
					e <= '0';
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (130 * clk_freq)) THEN   --display clear
					lcd_data <= "00000001";
					e <= '1'; --habilita o LCD (executa o comando)
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (2130 * clk_freq)) THEN  --wait 2 ms
					lcd_data <= "00000000";
					e <= '0';
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (2140 * clk_freq)) THEN  --entry mode set
					lcd_data <= "000001" & inc_dec & shift;
					e <= '1'; --habilita o LCD (executa o comando)
					estado <= INICIALIZACAO;
				ELSIF(clk_count < (2200 * clk_freq)) THEN  --wait 60 us
					lcd_data <= "00000000";
					e <= '0';
					estado <= INICIALIZACAO;
				ELSE                                       --initialization complete
					clk_count := 0;
					busy <= '0';
					estado <= PRONTO;
				END IF;    
			--wait for the enable signal and then latch in the instruction
			WHEN PRONTO =>
				IF(lcd_enable = '1') THEN
					busy <= '1';
					rs <= lcd_bus(9);
					rw <= lcd_bus(8);
					lcd_data <= lcd_bus(7 DOWNTO 0);
					clk_count := 0;            
					estado <= ENVIAR;
				ELSE
					busy <= '0';
					rs <= '0';
					rw <= '0';
					lcd_data <= "00000000";
					clk_count := 0;
					estado <= PRONTO;
				END IF;			
			--envia instrução para o LCD
			WHEN ENVIAR =>
				busy <= '1'; --LCD ocupado
				IF(clk_count < (50 * clk_freq)) THEN       --espera 50 us
					IF(clk_count < clk_freq) THEN            --enable negativo
						e <= '0'; --desabilita o LCD
					ELSIF(clk_count < (14 * clk_freq)) THEN  --enable positivo em metade do ciclo (25us)
						e <= '1'; --habilita o LCD (executa o comando)
					ELSIF(clk_count < (27 * clk_freq)) THEN  --enable negativo na outra metade do ciclo (25us)
						e <= '0'; --desabilita o LCD
					END IF;
					clk_count := clk_count + 1;
					estado <= ENVIAR;
				ELSE
					clk_count := 0;
					estado <= PRONTO;
				END IF;	
			END CASE;        
		END IF;
	END PROCESS;
END bhv;
