--BIBLIOTECAS USADAS PARA REALIZAÇÃO DO PROGRAMA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity teste3 is
	port
	(	
		--output ports
		LED : out std_logic_vector(4 downto 0); --LEDS que ficam na placa DEO-nano

		--Expansion Header UFPE/DES kit
		-- input ports
		ehkey : in std_logic_vector(0 to 3);-- bits 0-7=>chaves; bits 8 e 9 => pushbutton
		
		d7seg : out std_logic_vector(1 to 7) -- Indicator de 7seg selecionado por dig7seg

		
	);
end teste3;


architecture behaviorOfTest of teste3 is
signal temp: std_logic_vector(2 downto 0);

begin



--programa_secundario é o nome da entidade do programa secundario
--que deseja utilizar..

SOMADOR1: entity work.programa_secundario3
port map (A => ehkey(0), B => ehkey(1), C => ehkey(2), D => ehkey(3), I => temp(0), J => temp(1), K => temp(2));



--TABELA DO 7 segmentos
--d7seg(1) liga 'a'
--d7seg(2) liga 'b'
--d7seg(3) liga 'c'
--d7seg(4) liga 'd'
--d7seg(5) liga 'e'
--d7seg(6) liga 'f'
--d7seg(7) liga 'g'

with temp(3 downto 0) select
    d7seg(1 to 7) <= "11111100" when "0000", -- 0
             "0110000" when "0001", -- 1
             "1101101" when "0010", -- 2
             "1111001" when "0011", -- 3
             "0110011" when "0100", -- 4
             "1011011" when "0101", -- 5
				 "1011111" when "0110", -- 6
             "1110000" when "0111", -- 7
             "1111111" when "1000", -- 8
             "1111011" when "1001", -- 9
             "1110111" when "1010", -- a
				 "0011111" when "1011", -- b
             "1001110" when "1100", -- c
             "0111101" when "1101", -- d
             "1001111" when "1110", -- e
             "1000111" when "1111", -- f
             "0000000" when others;
end behaviorOfTest;