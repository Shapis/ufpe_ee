--BIBLIOTECAS USADAS PARA REALIZAÇÃO DO PROGRAMA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity teste1 is
	port
	(	
		--output ports
		LED : out std_logic_vector(4 downto 0); --LEDS que ficam na placa DEO-nano

		--Expansion Header UFPE/DES kit
		-- input ports
		ehkey : in std_logic_vector(0 to 7);-- bits 0-7=>chaves; bits 8 e 9 => pushbutton
		
		d7seg : out std_logic_vector(1 to 8) -- Indicator de 7seg selecionado por dig7seg

		
	);
end teste1;


architecture behaviorOfTest of teste1 is
signal v_aux: std_logic_vector(3 downto 0);
signal temp: std_logic_vector(3 downto 0);

begin



--programa_secundario é o nome da entidade do programa secundario
--que deseja utilizar..

SOMADOR1: entity work.programa_secundario
port map (A => ehkey(3), B => ehkey(7), Cin => '0', S => temp(0), Cout => v_aux(2));
SOMADOR2: entity work.programa_secundario
port map (A => ehkey(2), B => ehkey(6), Cin => v_aux(2), S => temp(1), Cout => v_aux(1));
SOMADOR3: entity work.programa_secundario
port map (A => ehkey(1), B => ehkey(5), Cin => v_aux(1), S => temp(2), Cout => v_aux(0));
SOMADOR4: entity work.programa_secundario
port map (A => ehkey(0), B => ehkey(4), Cin => v_aux(0), S => temp(3), Cout => led(0));


--TABELA DO 7 segmentos
--d7seg(1) liga 'a'
--d7seg(2) liga 'b'
--d7seg(3) liga 'c'
--d7seg(4) liga 'd'
--d7seg(5) liga 'e'
--d7seg(6) liga 'f'
--d7seg(7) liga 'g'

with temp(3 downto 0) select
    d7seg(1 to 8) <= "11111100" when "0000", -- 0
             "01100000" when "0001", -- 1
             "11011010" when "0010", -- 2
             "11110010" when "0011", -- 3
             "01100110" when "0100", -- 4
             "10110110" when "0101", -- 5
				 "10111110" when "0110", -- 6
             "11100000" when "0111", -- 7
             "11111111" when "1000", -- -8
             "11100001" when "1001", -- -7
             "10111111" when "1010", -- -6
				 "10110111" when "1011", -- -5
             "01100111" when "1100", -- -4
             "11110011" when "1101", -- -3
             "11011011" when "1110", -- -2
             "01100001" when "1111", -- -1
             "00000000" when others;
end behaviorOfTest;