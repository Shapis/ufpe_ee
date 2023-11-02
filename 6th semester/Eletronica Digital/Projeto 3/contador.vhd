LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY contador is
PORT(
	play_pause, stop, pulso: IN std_logic;
	dec_segundo, uni_segundo, uni_minuto: OUT integer RANGE 0 TO 9;
	dez_segundo: OUT integer RANGE 0 TO 5
);
END ENTITY;

ARCHITECTURE arc OF contador IS
	SIGNAL dec_seg, uni_seg, uni_min : INTEGER RANGE 0 TO 9;
	SIGNAL dez_seg : INTEGER RANGE 0 TO 5;
	SIGNAL play : std_logic;
BEGIN

	PROCESS(pulso)
	BEGIN
		play <= pulso and play_pause;
		IF (stop = '1') THEN
			dec_seg <= 0;
			uni_seg <= 0;
			dez_seg <= 0;
			uni_min <= 0;
		ELSIF(rising_edge(play)) THEN
			dec_seg <= dec_seg + 1;
			IF (dec_seg = 9) THEN
				dec_seg <= 0;
				uni_seg <= uni_seg + 1;
				IF (uni_seg = 9) THEN
					uni_seg <= 0;
					dez_seg <= dez_Seg + 1;
					IF (dez_seg = 5) THEN
						dez_seg <= 0;
						uni_min <= uni_min + 1;
						IF (uni_min = 9) THEN
							uni_min <= 0;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;

	dec_segundo <= dec_seg;
	uni_segundo <= uni_seg;
	dez_segundo <= dez_seg;
	uni_minuto <= uni_min;

END arc;