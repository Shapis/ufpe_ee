LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE lcd_vhdl_package IS

	FUNCTION to_std_logic_vector( s : string ) RETURN std_logic_vector;
	FUNCTION reverse( s : string ) RETURN string;	
	
	COMPONENT lcd_controller IS
    PORT(
       clk        : IN  STD_LOGIC; --clock principal
       reset_n    : IN  STD_LOGIC; --ativo-baixo reinicializa o lcd
       lcd_enable : IN  STD_LOGIC; --(1) envia dados para o controlador LCD
       lcd_bus    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0); --instrução (9)rs, (8)rw e (7..0)char
       busy       : OUT STD_LOGIC; --feedback do controlador de LCD (1)ocupado (0)disponível
       rw, rs, e  : OUT STD_LOGIC; --leitura/escrita, instrução/dados, habilita LCD
       lcd_data   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); -- char enviado para o LCD(D7..D0)
   END COMPONENT;
	
END PACKAGE lcd_vhdl_package;

PACKAGE BODY lcd_vhdl_package IS
	--converte uma string em uma array de vetores de 8bits
	FUNCTION to_std_logic_vector( s : string ) RETURN std_logic_vector 
	IS --variavel auxiliar para armazenamento temporário
		VARIABLE r : std_logic_vector( 0 TO s'LENGTH * 8 - 1) ;
	BEGIN
		FOR i IN 1 TO s'HIGH LOOP --percorre todos os caracteres da string
			--converte cada caractere em um vetor de 8bits 
			--e armazena na variável auxiliar em ordem crescente
			r((i - 1) * 8  TO i * 8 - 1) := std_logic_vector( to_unsigned( character'POS(s(i)) , 8 ) ) ;
		END loop ;
	RETURN r ; --retorna a array de vetores de 8bits
	END FUNCTION ;
	--inverte a sequência de caracteres numa string
	FUNCTION reverse( s : string ) RETURN string 
	IS --variavel auxiliar para armazenamento temporário
		VARIABLE r : string(s'HIGH DOWNTO s'LOW) ;
	BEGIN
		FOR i IN 1 TO s'HIGH LOOP --percorre todos os caracteres da string
			--inverte a posição de cada caractere 
			--eg. 8bits r(7) := s(0) e r(0):= s(7)
			r(s'HIGH + 1 - i) := s(i) ;
		END LOOP ;
	RETURN r ;
	END FUNCTION ;
	
END PACKAGE BODY lcd_vhdl_package ;