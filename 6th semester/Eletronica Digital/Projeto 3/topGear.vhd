LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY topGear IS
PORT ( 	Clk_out, Disparo  : OUT std_logic := '0';
			Temp_out, Freq_out : OUT std_logic_vector (27 DOWNTO 0);	
			Clk_in, Duracao, Stop_in, Play_in : IN std_logic
		);
END topGear;
ARCHITECTURE bhv OF topGear IS
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
	
	CONSTANT B0 	: integer := 50000000/31;
	CONSTANT C1 	: integer := 50000000/33;
	CONSTANT DB1	: integer := 50000000/35;
	CONSTANT D1		: integer := 50000000/37;
	CONSTANT EB1	: integer := 50000000/39;
	CONSTANT E1		: integer := 50000000/41;
	CONSTANT F1 	: integer := 50000000/44;
	CONSTANT GB1 	: integer := 50000000/46;
	CONSTANT G1		: integer := 50000000/49;
	CONSTANT AB1	: integer := 50000000/52;
	CONSTANT A1		: integer := 50000000/55;
	CONSTANT BB1	: integer := 50000000/58;
	CONSTANT B1		: integer := 50000000/62;
	CONSTANT C2		: integer := 50000000/65;
	CONSTANT DB2	: integer := 50000000/69;
	CONSTANT D2		: integer := 50000000/73;
	CONSTANT EB2	: integer := 50000000/78;
	CONSTANT E2		: integer := 50000000/82;
	CONSTANT F2		: integer := 50000000/87;
	CONSTANT GB2 	: integer := 50000000/93;
	CONSTANT G2		: integer := 50000000/98;
	CONSTANT AB2	: integer := 50000000/104;
	CONSTANT A2		: integer := 50000000/110;
	CONSTANT BB2	: integer := 50000000/117;
	CONSTANT B2		: integer := 50000000/123;
	CONSTANT C3 	: integer := 50000000/131;
	CONSTANT DB3 	: integer := 50000000/139;
	CONSTANT D3  	: integer := 50000000/147;
	CONSTANT EB3 	: integer := 50000000/156;
	CONSTANT E3 	: integer := 50000000/165;
	CONSTANT F3 	: integer := 50000000/175;
	CONSTANT GB3 	: integer := 50000000/185;
	CONSTANT G3  	: integer := 50000000/196;
	CONSTANT AB3 	: integer := 50000000/208;
	CONSTANT A3 	: integer := 50000000/220;
	CONSTANT BB3 	: integer := 50000000/233;
	CONSTANT B3 	: integer := 50000000/247;
	CONSTANT C4 	: integer := 50000000/262;
	CONSTANT DB4 	: integer := 50000000/277;
	CONSTANT D4 	: integer := 50000000/294;
	CONSTANT EB4 	: integer := 50000000/311;
	CONSTANT E4 	: integer := 50000000/330;
	CONSTANT F4 	: integer := 50000000/349;
	CONSTANT GB4	: integer := 50000000/370;
	CONSTANT G4 	: integer := 50000000/392;
	CONSTANT AB4	: integer := 50000000/415;
	CONSTANT A4 	: integer := 50000000/440;
	CONSTANT BB4 	: integer := 50000000/466;
	CONSTANT B4 	: integer := 50000000/494;
	CONSTANT C5 	: integer := 50000000/523;
	CONSTANT DB5	: integer := 50000000/554;
	CONSTANT D5 	: integer := 50000000/587;
	CONSTANT EB5	: integer := 50000000/622;
	CONSTANT E5 	: integer := 50000000/659;
	CONSTANT F5 	: integer := 50000000/698;
	CONSTANT GB5 	: integer := 50000000/740;
	CONSTANT G5 	: integer := 50000000/784;
	CONSTANT AB5 	: integer := 50000000/831;
	CONSTANT A5 	: integer := 50000000/880;
	CONSTANT BB5	: integer := 50000000/932;
	CONSTANT B5 	: integer := 50000000/988;
	CONSTANT C6 	: integer := 50000000/1047;
	CONSTANT DB6 	: integer := 50000000/1109;
	CONSTANT D6 	: integer := 50000000/1175;
	CONSTANT EB6 	: integer := 50000000/1245;
	CONSTANT E6 	: integer := 50000000/1319;
	CONSTANT F6 	: integer := 50000000/1397;
	CONSTANT GB6 	: integer := 50000000/1480;
	CONSTANT G6 	: integer := 50000000/1568;
	CONSTANT AB6	: integer := 50000000/1661;
	CONSTANT A6 	: integer := 50000000/1760;
	CONSTANT BB6	: integer := 50000000/1865;
	CONSTANT B6 	: integer := 50000000/1976;
	CONSTANT C7 	: integer := 50000000/2093;
	CONSTANT DB7	: integer := 50000000/2217;
	CONSTANT D7 	: integer := 50000000/2349;
	CONSTANT EB7	: integer := 50000000/2489;
	CONSTANT E7 	: integer := 50000000/2637;
	CONSTANT F7 	: integer := 50000000/2794;
	CONSTANT GB7	: integer := 50000000/2960;
	CONSTANT G7 	: integer := 50000000/3136;
	CONSTANT AB7	: integer := 50000000/3322;
	CONSTANT A7 	: integer := 50000000/3520;
	CONSTANT BB7	: integer := 50000000/3729;
	CONSTANT B7 	: integer := 50000000/3951;
	CONSTANT C8 	: integer := 50000000/4186;
	CONSTANT DB8 	: integer := 50000000/4435;
	CONSTANT D8 	: integer := 50000000/4699;
	CONSTANT EB8 	: integer := 50000000/4978;
	
	--overflow para tempos (50MHz)
	-- BPM igual a 60 implica que t1, 1 batida, representa 1 seg
	-- BPM igual a 120 implica que t1, 1 batida, representa 0.5 seg
	CONSTANT BPM : integer := 125; --batidas por minuto
	CONSTANT BPS : integer := BPM / 60; --batidas por segundo
	
	CONSTANT ov_t1 : integer := (4 * clk_FPGA) / BPS;
	CONSTANT ov_t2 : integer := (2 * clk_FPGA) / BPS;
	CONSTANT ov_t4 : integer := clk_FPGA / BPS;
	CONSTANT ov_t8 : integer := (clk_FPGA / 2) / BPS;
	CONSTANT ov_t16 : integer := (clk_FPGA / 4) / BPS;
	CONSTANT ov_t32 : integer := (clk_FPGA / 8) / BPS;
	
	--FSM Declaração de estados 
	TYPE estados IS (s0, s1, s2, s3, s4 ,s5 ,s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, s33, s34, s35, s36, s37, s38, s39, s40, s41, s42, s43, s44 ,s45 ,s46, s47, s48, s49, s50, s51, s52, s53, s54 ,s55 ,s56, s57, s58, s59, s60, s61, s62, s63, s64 ,s65 ,s66, s67, s68, s69, s70, s71, s72, s73, s74 ,s75 ,s76, s77, s78, s79, s80, s81, s82, s83, s84 ,s85 ,s86, s87, s88, s89, s90, s91, s92, s93, s94 ,s95 ,s96, s97, s98, s99,
	s100, s101, s102, s103, s104 ,s105 ,s106, s107, s108, s109, s110, s111, s112, s113, s114, s115, s116, s117, s118, s119, s120, s121, s122, s123, s124, s125, s126, s127, s128, s129, s130, s131, s132, s133, s134, s135, s136, s137, s138, s139, s140, s141, s142, s143, s144 ,s145 ,s146, s147, s148, s149, s150, s151, s152, s153, s154 ,s155 ,s156, s157, s158, s159, s160, s161, s162, s163, s164 ,s165 ,s166, s167, s168, s169, s170, s171, s172, s173, s174 ,s175 ,s176, s177, s178, s179, s180, s181, s182, s183, s184 ,s185 ,s186, s187, s188, s189, s190, s191, s192, s193, s194 ,s195 ,s196, s197, s198, s199,
	s200, s201, s202, s203, s204 ,s205 ,s206, s207, s208, s209, s210, s211, s212, s213, s214, s215, s216, s217, s218, s219, s220, s221, s222, s223, s224, s225, s226, s227, s228, s229, s230, s231, s232, s233, s234, s235, s236, s237, s238, s239, s240, s241, s242, s243, s244 ,s245 ,s246, s247, s248, s249, s250, s251, s252, s253, s254 ,s255 ,s256, s257, s258, s259, s260, s261, s262, s263, s264 ,s265 ,s266, s267, s268, s269, s270, s271, s272, s273, s274 ,s275 ,s276, s277, s278, s279, s280, s281, s282, s283, s284 ,s285 ,s286, s287, s288, s289, s290, s291, s292, s293, s294 ,s295 ,s296, s297, s298, s299,
	s300, s301, s302, s303, s304 ,s305 ,s306, s307, s308, s309, s310, s311, s312, s313, s314, s315, s316, s317, s318, s319, s320, s321, s322, s323, s324, s325, s326, s327, s328, s329, s330, s331, s332, s333, s334, s335, s336, s337, s338, s339, s340, s341, s342, s343, s344 ,s345 ,s346, s347, s348, s349, s350, s351, s352, s353, s354 ,s355 ,s356, s357, s358, s359, s360, s361, s362, s363, s364 ,s365 ,s366, s367, s368, s369, s370, s371, s372, s373, s374 ,s375 ,s376, s377, s378, s379, s380, s381, s382, s383, s384 ,s385 ,s386, s387, s388, s389, s390, s391, s392, s393, s394 ,s395 ,s396, s397, s398, s399,
	s400, s401, s402, s403, s404 ,s405 ,s406, s407, s408, s409, s410, s411, s412, s413, s414, s415, s416, s417, s418, s419, s420, s421, s422, s423, s424, s425, s426, s427, s428, s429, s430, s431, s432, s433, s434, s435, s436, s437, s438, s439, s440, s441, s442, s443, s444 ,s445 ,s446, s447, s448, s449, s450, s451, s452, s453, s454 ,s455 ,s456, s457, s458, s459, s460, s461, s462, s463, s464 ,s465 ,s466, s467, s468);
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
						proximo_estado <= s34;					
					ELSE proximo_estado <= s33;
					END IF;	
				END IF;
			WHEN s34 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s35;					
					ELSE proximo_estado <= s34;
					END IF;	
				END IF;
			WHEN s35 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s36;					
					ELSE proximo_estado <= s35;
					END IF;	
				END IF;
			WHEN s36 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s37;					
					ELSE proximo_estado <= s36;
					END IF;	
				END IF;
			WHEN s37 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s38;					
					ELSE proximo_estado <= s37;
					END IF;	
				END IF;
			WHEN s38 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s39;					
					ELSE proximo_estado <= s38;
					END IF;	
				END IF;
			WHEN s39 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s40;					
					ELSE proximo_estado <= s39;
					END IF;
				END IF;
			WHEN s40 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s41;					
					ELSE proximo_estado <= s40;
					END IF;
				END IF;
			WHEN s41 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s42;					
					ELSE proximo_estado <= s41;
					END IF;
				END IF;
			WHEN s42 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s43;					
					ELSE proximo_estado <= s42;
					END IF;	
				END IF;
			WHEN s43 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s44;					
					ELSE proximo_estado <= s43;
					END IF;	
				END IF;
			WHEN s44 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s45;					
					ELSE proximo_estado <= s44;
					END IF;	
				END IF;
			WHEN s45 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s46;					
					ELSE proximo_estado <= s45;
					END IF;	
				END IF;
			WHEN s46 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s47;					
					ELSE proximo_estado <= s46;
					END IF;	
				END IF;
			WHEN s47 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s48;					
					ELSE proximo_estado <= s47;
					END IF;	
				END IF;
			WHEN s48 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s49;					
					ELSE proximo_estado <= s48;
					END IF;	
				END IF;
			WHEN s49 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s50;					
					ELSE proximo_estado <= s49;
					END IF;
				END IF;
			WHEN s50 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s51;					
					ELSE proximo_estado <= s50;
					END IF;
				END IF;
			WHEN s51 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s52;					
					ELSE proximo_estado <= s51;
					END IF;
				END IF;
			WHEN s52 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s53;					
					ELSE proximo_estado <= s52;
					END IF;	
				END IF;
			WHEN s53 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s54;					
					ELSE proximo_estado <= s53;
					END IF;	
				END IF;
			WHEN s54 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s55;					
					ELSE proximo_estado <= s54;
					END IF;	
				END IF;
			WHEN s55 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s56;					
					ELSE proximo_estado <= s55;
					END IF;	
				END IF;
			WHEN s56 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s57;					
					ELSE proximo_estado <= s56;
					END IF;	
				END IF;
			WHEN s57 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s58;					
					ELSE proximo_estado <= s57;
					END IF;	
				END IF;
			WHEN s58 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s59;					
					ELSE proximo_estado <= s58;
					END IF;	
				END IF;
			WHEN s59 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s60;					
					ELSE proximo_estado <= s59;
					END IF;
				END IF;
			WHEN s60 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s61;					
					ELSE proximo_estado <= s60;
					END IF;
				END IF;
			WHEN s61 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s62;					
					ELSE proximo_estado <= s61;
					END IF;
				END IF;
			WHEN s62 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s63;					
					ELSE proximo_estado <= s62;
					END IF;	
				END IF;
			WHEN s63 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s64;					
					ELSE proximo_estado <= s63;
					END IF;	
				END IF;
			WHEN s64 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s65;					
					ELSE proximo_estado <= s64;
					END IF;	
				END IF;
			WHEN s65 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s66;					
					ELSE proximo_estado <= s65;
					END IF;	
				END IF;
			WHEN s66 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s67;					
					ELSE proximo_estado <= s66;
					END IF;	
				END IF;
			WHEN s67 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s68;					
					ELSE proximo_estado <= s67;
					END IF;	
				END IF;
			WHEN s68 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s69;					
					ELSE proximo_estado <= s68;
					END IF;	
				END IF;
			WHEN s69 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s70;					
					ELSE proximo_estado <= s69;
					END IF;
				END IF;
			WHEN s70 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s71;					
					ELSE proximo_estado <= s70;
					END IF;
				END IF;
			WHEN s71 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s72;					
					ELSE proximo_estado <= s71;
					END IF;
				END IF;
			WHEN s72 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s73;					
					ELSE proximo_estado <= s72;
					END IF;	
				END IF;
			WHEN s73 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s74;					
					ELSE proximo_estado <= s73;
					END IF;	
				END IF;
			WHEN s74 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s75;					
					ELSE proximo_estado <= s74;
					END IF;	
				END IF;
			WHEN s75 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s76;					
					ELSE proximo_estado <= s75;
					END IF;	
				END IF;
			WHEN s76 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s77;					
					ELSE proximo_estado <= s76;
					END IF;	
				END IF;
			WHEN s77 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s78;					
					ELSE proximo_estado <= s77;
					END IF;	
				END IF;
			WHEN s78 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s79;					
					ELSE proximo_estado <= s78;
					END IF;	
				END IF;
			WHEN s79 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s80;					
					ELSE proximo_estado <= s79;
					END IF;
				END IF;
			WHEN s80 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s81;					
					ELSE proximo_estado <= s80;
					END IF;
				END IF;
			WHEN s81 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s82;					
					ELSE proximo_estado <= s81;
					END IF;
				END IF;
			WHEN s82 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s83;					
					ELSE proximo_estado <= s82;
					END IF;	
				END IF;
			WHEN s83 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s84;					
					ELSE proximo_estado <= s83;
					END IF;	
				END IF;
			WHEN s84 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s85;					
					ELSE proximo_estado <= s84;
					END IF;	
				END IF;
			WHEN s85 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s86;					
					ELSE proximo_estado <= s85;
					END IF;	
				END IF;
			WHEN s86 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s87;					
					ELSE proximo_estado <= s86;
					END IF;	
				END IF;
			WHEN s87 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s88;					
					ELSE proximo_estado <= s87;
					END IF;	
				END IF;
			WHEN s88 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s89;					
					ELSE proximo_estado <= s88;
					END IF;	
				END IF;
			WHEN s89 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s90;					
					ELSE proximo_estado <= s89;
					END IF;
				END IF;
			WHEN s90 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s91;					
					ELSE proximo_estado <= s90;
					END IF;
				END IF;
			WHEN s91 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s92;					
					ELSE proximo_estado <= s91;
					END IF;
				END IF;
			WHEN s92 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s93;					
					ELSE proximo_estado <= s92;
					END IF;	
				END IF;
			WHEN s93 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s94;					
					ELSE proximo_estado <= s93;
					END IF;	
				END IF;
			WHEN s94 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s95;					
					ELSE proximo_estado <= s94;
					END IF;	
				END IF;
			WHEN s95 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s96;					
					ELSE proximo_estado <= s95;
					END IF;	
				END IF;
			WHEN s96 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s97;					
					ELSE proximo_estado <= s96;
					END IF;	
				END IF;
			WHEN s97 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s98;					
					ELSE proximo_estado <= s97;
					END IF;	
				END IF;
			WHEN s98 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s99;					
					ELSE proximo_estado <= s98;
					END IF;	
				END IF;
			WHEN s99 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s100;					
					ELSE proximo_estado <= s99;
					END IF;
				END IF;
			WHEN s100 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s101;
					ELSE proximo_estado <= s100;
					END IF;
				END IF;
			WHEN s101 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s102;
					ELSE proximo_estado <= s101;					
					END IF;
				END IF;	
			WHEN s102 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s103;					
					ELSE proximo_estado <= s102;
					END IF;	
				END IF;
			WHEN s103 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s104;					
					ELSE proximo_estado <= s103;
					END IF;	
				END IF;
			WHEN s104 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s105;					
					ELSE proximo_estado <= s104;
					END IF;	
				END IF;
			WHEN s105 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s106;					
					ELSE proximo_estado <= s105;
					END IF;	
				END IF;
			WHEN s106 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s107;					
					ELSE proximo_estado <= s106;
					END IF;	
				END IF;
			WHEN s107 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s108;					
					ELSE proximo_estado <= s107;
					END IF;	
				END IF;
			WHEN s108 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s109;					
					ELSE proximo_estado <= s108;
					END IF;	
				END IF;
			WHEN s109 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s110;					
					ELSE proximo_estado <= s109;
					END IF;
				END IF;
			WHEN s110 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s111;
					ELSE proximo_estado <= s110;
					END IF;
				END IF;
			WHEN s111 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s112;
					ELSE proximo_estado <= s111;					
					END IF;
				END IF;	
			WHEN s112 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s113;					
					ELSE proximo_estado <= s112;
					END IF;	
				END IF;
			WHEN s113 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s114;					
					ELSE proximo_estado <= s113;
					END IF;	
				END IF;
			WHEN s114 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s115;					
					ELSE proximo_estado <= s114;
					END IF;	
				END IF;
			WHEN s115 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s116;					
					ELSE proximo_estado <= s115;
					END IF;	
				END IF;
			WHEN s116 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s117;					
					ELSE proximo_estado <= s116;
					END IF;	
				END IF;
			WHEN s117 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s118;					
					ELSE proximo_estado <= s117;
					END IF;	
				END IF;
			WHEN s118 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s119;					
					ELSE proximo_estado <= s118;
					END IF;	
				END IF;
			WHEN s119 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s120;					
					ELSE proximo_estado <= s119;
					END IF;
				END IF;
			WHEN s120 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s121;
					ELSE proximo_estado <= s120;
					END IF;
				END IF;
			WHEN s121 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s122;
					ELSE proximo_estado <= s121;					
					END IF;
				END IF;	
			WHEN s122 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s123;					
					ELSE proximo_estado <= s122;
					END IF;	
				END IF;
			WHEN s123 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s124;					
					ELSE proximo_estado <= s123;
					END IF;	
				END IF;
			WHEN s124 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s125;					
					ELSE proximo_estado <= s124;
					END IF;	
				END IF;
			WHEN s125 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s126;					
					ELSE proximo_estado <= s125;
					END IF;	
				END IF;
			WHEN s126 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s127;					
					ELSE proximo_estado <= s126;
					END IF;	
				END IF;
			WHEN s127 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s128;					
					ELSE proximo_estado <= s127;
					END IF;	
				END IF;
			WHEN s128 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s129;					
					ELSE proximo_estado <= s128;
					END IF;	
				END IF;
			WHEN s129 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s130;					
					ELSE proximo_estado <= s129;
					END IF;
				END IF;
			WHEN s130 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s131;
					ELSE proximo_estado <= s130;
					END IF;
				END IF;
			WHEN s131 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s132;
					ELSE proximo_estado <= s131;					
					END IF;
				END IF;	
			WHEN s132 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s133;					
					ELSE proximo_estado <= s132;
					END IF;	
				END IF;
			WHEN s133 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s134;					
					ELSE proximo_estado <= s133;
					END IF;	
				END IF;
			WHEN s134 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s135;					
					ELSE proximo_estado <= s134;
					END IF;	
				END IF;
			WHEN s135 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s136;					
					ELSE proximo_estado <= s315;
					END IF;	
				END IF;
			WHEN s136 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s137;					
					ELSE proximo_estado <= s136;
					END IF;	
				END IF;
			WHEN s137 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s138;					
					ELSE proximo_estado <= s137;
					END IF;	
				END IF;
			WHEN s138 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s139;					
					ELSE proximo_estado <= s138;
					END IF;	
				END IF;
			WHEN s139 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s140;					
					ELSE proximo_estado <= s139;
					END IF;
				END IF;
			WHEN s140 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s141;					
					ELSE proximo_estado <= s140;
					END IF;
				END IF;
			WHEN s141 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s142;					
					ELSE proximo_estado <= s141;
					END IF;
				END IF;
			WHEN s142 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s143;					
					ELSE proximo_estado <= s142;
					END IF;	
				END IF;
			WHEN s143 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s144;					
					ELSE proximo_estado <= s143;
					END IF;	
				END IF;
			WHEN s144 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s145;					
					ELSE proximo_estado <= s144;
					END IF;	
				END IF;
			WHEN s145 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s146;					
					ELSE proximo_estado <= s145;
					END IF;	
				END IF;
			WHEN s146 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s147;					
					ELSE proximo_estado <= s146;
					END IF;	
				END IF;
			WHEN s147 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s148;					
					ELSE proximo_estado <= s147;
					END IF;	
				END IF;
			WHEN s148 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s149;					
					ELSE proximo_estado <= s148;
					END IF;	
				END IF;
			WHEN s149 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s150;					
					ELSE proximo_estado <= s149;
					END IF;
				END IF;
			WHEN s150 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s151;					
					ELSE proximo_estado <= s150;
					END IF;
				END IF;
			WHEN s151 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s152;					
					ELSE proximo_estado <= s151;
					END IF;
				END IF;
			WHEN s152 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s153;					
					ELSE proximo_estado <= s152;
					END IF;	
				END IF;
			WHEN s153 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s154;					
					ELSE proximo_estado <= s153;
					END IF;	
				END IF;
			WHEN s154 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s155;					
					ELSE proximo_estado <= s154;
					END IF;	
				END IF;
			WHEN s155 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s156;					
					ELSE proximo_estado <= s155;
					END IF;	
				END IF;
			WHEN s156 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s157;					
					ELSE proximo_estado <= s156;
					END IF;	
				END IF;
			WHEN s157 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s158;					
					ELSE proximo_estado <= s157;
					END IF;	
				END IF;
			WHEN s158 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s159;					
					ELSE proximo_estado <= s158;
					END IF;	
				END IF;
			WHEN s159 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s160;					
					ELSE proximo_estado <= s159;
					END IF;
				END IF;
			WHEN s160 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s161;					
					ELSE proximo_estado <= s160;
					END IF;
				END IF;
			WHEN s161 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s162;					
					ELSE proximo_estado <= s161;
					END IF;
				END IF;
			WHEN s162 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s163;					
					ELSE proximo_estado <= s162;
					END IF;	
				END IF;
			WHEN s163 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s164;					
					ELSE proximo_estado <= s163;
					END IF;	
				END IF;
			WHEN s164 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s165;					
					ELSE proximo_estado <= s164;
					END IF;	
				END IF;
			WHEN s165 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s166;					
					ELSE proximo_estado <= s165;
					END IF;	
				END IF;
			WHEN s166 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s167;					
					ELSE proximo_estado <= s166;
					END IF;	
				END IF;
			WHEN s167 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s168;					
					ELSE proximo_estado <= s167;
					END IF;	
				END IF;
			WHEN s168 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s169;					
					ELSE proximo_estado <= s168;
					END IF;	
				END IF;
			WHEN s169 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s170;					
					ELSE proximo_estado <= s169;
					END IF;
				END IF;
			WHEN s170 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s171;					
					ELSE proximo_estado <= s170;
					END IF;
				END IF;
			WHEN s171 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s172;					
					ELSE proximo_estado <= s171;
					END IF;
				END IF;
			WHEN s172 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s173;					
					ELSE proximo_estado <= s172;
					END IF;	
				END IF;
			WHEN s173 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s174;					
					ELSE proximo_estado <= s173;
					END IF;	
				END IF;
			WHEN s174 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s175;					
					ELSE proximo_estado <= s174;
					END IF;	
				END IF;
			WHEN s175 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s176;					
					ELSE proximo_estado <= s175;
					END IF;	
				END IF;
			WHEN s176 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s177;					
					ELSE proximo_estado <= s176;
					END IF;	
				END IF;
			WHEN s177 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s178;					
					ELSE proximo_estado <= s177;
					END IF;	
				END IF;
			WHEN s178 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s179;					
					ELSE proximo_estado <= s178;
					END IF;	
				END IF;
			WHEN s179 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s180;					
					ELSE proximo_estado <= s179;
					END IF;
				END IF;
			WHEN s180 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s181;					
					ELSE proximo_estado <= s180;
					END IF;
				END IF;
			WHEN s181 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s182;					
					ELSE proximo_estado <= s181;
					END IF;
				END IF;
			WHEN s182 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s183;					
					ELSE proximo_estado <= s182;
					END IF;	
				END IF;
			WHEN s183 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s184;					
					ELSE proximo_estado <= s183;
					END IF;	
				END IF;
			WHEN s184 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s185;					
					ELSE proximo_estado <= s184;
					END IF;	
				END IF;
			WHEN s185 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s186;					
					ELSE proximo_estado <= s185;
					END IF;	
				END IF;
			WHEN s186 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s187;					
					ELSE proximo_estado <= s186;
					END IF;	
				END IF;
			WHEN s187 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s188;					
					ELSE proximo_estado <= s187;
					END IF;	
				END IF;
			WHEN s188 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s189;					
					ELSE proximo_estado <= s188;
					END IF;	
				END IF;
			WHEN s189 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s190;					
					ELSE proximo_estado <= s189;
					END IF;
				END IF;
			WHEN s190 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s191;					
					ELSE proximo_estado <= s190;
					END IF;
				END IF;
			WHEN s191 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s192;					
					ELSE proximo_estado <= s191;
					END IF;
				END IF;
			WHEN s192 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s193;					
					ELSE proximo_estado <= s192;
					END IF;	
				END IF;
			WHEN s193 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s194;					
					ELSE proximo_estado <= s193;
					END IF;	
				END IF;
			WHEN s194 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s195;					
					ELSE proximo_estado <= s194;
					END IF;	
				END IF;
			WHEN s195 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s196;					
					ELSE proximo_estado <= s195;
					END IF;	
				END IF;
			WHEN s196 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s197;					
					ELSE proximo_estado <= s196;
					END IF;	
				END IF;
			WHEN s197 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s198;					
					ELSE proximo_estado <= s197;
					END IF;	
				END IF;
			WHEN s198 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s199;					
					ELSE proximo_estado <= s198;
					END IF;	
				END IF;
			WHEN s199 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s200;					
					ELSE proximo_estado <= s199;
					END IF;
				END IF;
			WHEN s200 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s201;
					ELSE proximo_estado <= s200;
					END IF;
				END IF;
			WHEN s201 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s202;
					ELSE proximo_estado <= s201;					
					END IF;
				END IF;	
			WHEN s202 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s203;					
					ELSE proximo_estado <= s202;
					END IF;	
				END IF;
			WHEN s203 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s204;					
					ELSE proximo_estado <= s203;
					END IF;	
				END IF;
			WHEN s204 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s205;					
					ELSE proximo_estado <= s204;
					END IF;	
				END IF;
			WHEN s205 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s206;					
					ELSE proximo_estado <= s205;
					END IF;	
				END IF;
			WHEN s206 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s207;					
					ELSE proximo_estado <= s206;
					END IF;	
				END IF;
			WHEN s207 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s208;					
					ELSE proximo_estado <= s207;
					END IF;	
				END IF;
			WHEN s208 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s209;					
					ELSE proximo_estado <= s208;
					END IF;	
				END IF;
			WHEN s209 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s210;					
					ELSE proximo_estado <= s209;
					END IF;
				END IF;
			WHEN s210 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s211;
					ELSE proximo_estado <= s210;
					END IF;
				END IF;
			WHEN s211 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s212;
					ELSE proximo_estado <= s211;					
					END IF;
				END IF;	
			WHEN s212 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s213;					
					ELSE proximo_estado <= s212;
					END IF;	
				END IF;
			WHEN s213 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s214;					
					ELSE proximo_estado <= s213;
					END IF;	
				END IF;
			WHEN s214 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s215;					
					ELSE proximo_estado <= s214;
					END IF;	
				END IF;
			WHEN s215 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s216;					
					ELSE proximo_estado <= s215;
					END IF;	
				END IF;
			WHEN s216 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s217;					
					ELSE proximo_estado <= s216;
					END IF;	
				END IF;
			WHEN s217 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s218;					
					ELSE proximo_estado <= s217;
					END IF;	
				END IF;
			WHEN s218 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s219;					
					ELSE proximo_estado <= s218;
					END IF;	
				END IF;
			WHEN s219 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s220;					
					ELSE proximo_estado <= s219;
					END IF;
				END IF;
			WHEN s220 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s221;
					ELSE proximo_estado <= s220;
					END IF;
				END IF;
			WHEN s221 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s222;
					ELSE proximo_estado <= s221;					
					END IF;
				END IF;	
			WHEN s222 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s223;					
					ELSE proximo_estado <= s222;
					END IF;	
				END IF;
			WHEN s223 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s224;					
					ELSE proximo_estado <= s223;
					END IF;	
				END IF;
			WHEN s224 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s225;					
					ELSE proximo_estado <= s224;
					END IF;	
				END IF;
			WHEN s225 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s226;					
					ELSE proximo_estado <= s225;
					END IF;	
				END IF;
			WHEN s226 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s227;					
					ELSE proximo_estado <= s226;
					END IF;	
				END IF;
			WHEN s227 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s228;					
					ELSE proximo_estado <= s227;
					END IF;	
				END IF;
			WHEN s228 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s229;					
					ELSE proximo_estado <= s228;
					END IF;	
				END IF;
			WHEN s229 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s230;					
					ELSE proximo_estado <= s229;
					END IF;
				END IF;
			WHEN s230 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s231;
					ELSE proximo_estado <= s230;
					END IF;
				END IF;
			WHEN s231 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s232;
					ELSE proximo_estado <= s231;					
					END IF;
				END IF;	
			WHEN s232 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s233;					
					ELSE proximo_estado <= s232;
					END IF;	
				END IF;
			WHEN s233 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s234;					
					ELSE proximo_estado <= s233;
					END IF;	
				END IF;
			WHEN s234 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s235;					
					ELSE proximo_estado <= s234;
					END IF;	
				END IF;
			WHEN s235 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s236;					
					ELSE proximo_estado <= s235;
					END IF;	
				END IF;
			WHEN s236 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s237;					
					ELSE proximo_estado <= s236;
					END IF;	
				END IF;
			WHEN s237 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s238;					
					ELSE proximo_estado <= s237;
					END IF;	
				END IF;
			WHEN s238 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s239;					
					ELSE proximo_estado <= s238;
					END IF;	
				END IF;
			WHEN s239 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s240;					
					ELSE proximo_estado <= s239;
					END IF;
				END IF;
			WHEN s240 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s241;					
					ELSE proximo_estado <= s240;
					END IF;
				END IF;
			WHEN s241 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s242;					
					ELSE proximo_estado <= s241;
					END IF;
				END IF;
			WHEN s242 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s243;					
					ELSE proximo_estado <= s242;
					END IF;	
				END IF;
			WHEN s243 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s244;					
					ELSE proximo_estado <= s243;
					END IF;	
				END IF;
			WHEN s244 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s245;					
					ELSE proximo_estado <= s244;
					END IF;	
				END IF;
			WHEN s245 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s246;					
					ELSE proximo_estado <= s245;
					END IF;	
				END IF;
			WHEN s246 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s247;					
					ELSE proximo_estado <= s246;
					END IF;	
				END IF;
			WHEN s247 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s248;					
					ELSE proximo_estado <= s247;
					END IF;	
				END IF;
			WHEN s248 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s249;					
					ELSE proximo_estado <= s248;
					END IF;	
				END IF;
			WHEN s249 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s250;					
					ELSE proximo_estado <= s249;
					END IF;
				END IF;
			WHEN s250 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s251;					
					ELSE proximo_estado <= s250;
					END IF;
				END IF;
			WHEN s251 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s252;					
					ELSE proximo_estado <= s251;
					END IF;
				END IF;
			WHEN s252 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s253;					
					ELSE proximo_estado <= s252;
					END IF;	
				END IF;
			WHEN s253 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s254;					
					ELSE proximo_estado <= s253;
					END IF;	
				END IF;
			WHEN s254 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s255;					
					ELSE proximo_estado <= s254;
					END IF;	
				END IF;
			WHEN s255 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s256;					
					ELSE proximo_estado <= s255;
					END IF;	
				END IF;
			WHEN s256 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s257;					
					ELSE proximo_estado <= s256;
					END IF;	
				END IF;
			WHEN s257 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s258;					
					ELSE proximo_estado <= s257;
					END IF;	
				END IF;
			WHEN s258 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s259;					
					ELSE proximo_estado <= s258;
					END IF;	
				END IF;
			WHEN s259 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s260;					
					ELSE proximo_estado <= s259;
					END IF;
				END IF;
			WHEN s260 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s261;					
					ELSE proximo_estado <= s260;
					END IF;
				END IF;
			WHEN s261 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s262;					
					ELSE proximo_estado <= s261;
					END IF;
				END IF;
			WHEN s262 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s263;					
					ELSE proximo_estado <= s262;
					END IF;	
				END IF;
			WHEN s263 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s264;					
					ELSE proximo_estado <= s263;
					END IF;	
				END IF;
			WHEN s264 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s265;					
					ELSE proximo_estado <= s264;
					END IF;	
				END IF;
			WHEN s265 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s266;					
					ELSE proximo_estado <= s265;
					END IF;	
				END IF;
			WHEN s266 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s267;					
					ELSE proximo_estado <= s266;
					END IF;	
				END IF;
			WHEN s267 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s268;					
					ELSE proximo_estado <= s267;
					END IF;	
				END IF;
			WHEN s268 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s269;					
					ELSE proximo_estado <= s268;
					END IF;	
				END IF;
			WHEN s269 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s270;					
					ELSE proximo_estado <= s269;
					END IF;
				END IF;
			WHEN s270 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s271;					
					ELSE proximo_estado <= s270;
					END IF;
				END IF;
			WHEN s271 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s272;					
					ELSE proximo_estado <= s271;
					END IF;
				END IF;
			WHEN s272 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s273;					
					ELSE proximo_estado <= s272;
					END IF;	
				END IF;
			WHEN s273 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s274;					
					ELSE proximo_estado <= s273;
					END IF;	
				END IF;
			WHEN s274 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s275;					
					ELSE proximo_estado <= s274;
					END IF;	
				END IF;
			WHEN s275 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s276;					
					ELSE proximo_estado <= s275;
					END IF;	
				END IF;
			WHEN s276 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s277;					
					ELSE proximo_estado <= s276;
					END IF;	
				END IF;
			WHEN s277 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s278;					
					ELSE proximo_estado <= s277;
					END IF;	
				END IF;
			WHEN s278 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s279;					
					ELSE proximo_estado <= s278;
					END IF;	
				END IF;
			WHEN s279 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s280;					
					ELSE proximo_estado <= s279;
					END IF;
				END IF;
			WHEN s280 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s281;					
					ELSE proximo_estado <= s280;
					END IF;
				END IF;
			WHEN s281 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s282;					
					ELSE proximo_estado <= s281;
					END IF;
				END IF;
			WHEN s282 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s283;					
					ELSE proximo_estado <= s282;
					END IF;	
				END IF;
			WHEN s283 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s284;					
					ELSE proximo_estado <= s283;
					END IF;	
				END IF;
			WHEN s284 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s285;					
					ELSE proximo_estado <= s284;
					END IF;	
				END IF;
			WHEN s285 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s286;					
					ELSE proximo_estado <= s285;
					END IF;	
				END IF;
			WHEN s286 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s287;					
					ELSE proximo_estado <= s286;
					END IF;	
				END IF;
			WHEN s287 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s288;					
					ELSE proximo_estado <= s287;
					END IF;	
				END IF;
			WHEN s288 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s289;					
					ELSE proximo_estado <= s288;
					END IF;	
				END IF;
			WHEN s289 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s290;					
					ELSE proximo_estado <= s289;
					END IF;
				END IF;
			WHEN s290 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s291;					
					ELSE proximo_estado <= s290;
					END IF;
				END IF;
			WHEN s291 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s292;					
					ELSE proximo_estado <= s291;
					END IF;
				END IF;
			WHEN s292 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s293;					
					ELSE proximo_estado <= s292;
					END IF;	
				END IF;
			WHEN s293 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s294;					
					ELSE proximo_estado <= s293;
					END IF;	
				END IF;
			WHEN s294 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s295;					
					ELSE proximo_estado <= s294;
					END IF;	
				END IF;
			WHEN s295 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s296;					
					ELSE proximo_estado <= s295;
					END IF;	
				END IF;
			WHEN s296 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s297;					
					ELSE proximo_estado <= s296;
					END IF;	
				END IF;
			WHEN s297 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s298;					
					ELSE proximo_estado <= s297;
					END IF;	
				END IF;
			WHEN s298 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s299;					
					ELSE proximo_estado <= s298;
					END IF;	
				END IF;
			WHEN s299 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s300;					
					ELSE proximo_estado <= s299;
					END IF;
				END IF;
			WHEN s300 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s301;
					ELSE proximo_estado <= s300;
					END IF;
				END IF;
			WHEN s301 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s302;
					ELSE proximo_estado <= s301;					
					END IF;
				END IF;	
			WHEN s302 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s303;					
					ELSE proximo_estado <= s302;
					END IF;	
				END IF;
			WHEN s303 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s304;					
					ELSE proximo_estado <= s303;
					END IF;	
				END IF;
			WHEN s304 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s305;					
					ELSE proximo_estado <= s304;
					END IF;	
				END IF;
			WHEN s305 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s306;					
					ELSE proximo_estado <= s305;
					END IF;	
				END IF;
			WHEN s306 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s307;					
					ELSE proximo_estado <= s306;
					END IF;	
				END IF;
			WHEN s307 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s308;					
					ELSE proximo_estado <= s307;
					END IF;	
				END IF;
			WHEN s308 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s309;					
					ELSE proximo_estado <= s308;
					END IF;	
				END IF;
			WHEN s309 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s310;					
					ELSE proximo_estado <= s309;
					END IF;
				END IF;
			WHEN s310 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s311;
					ELSE proximo_estado <= s310;
					END IF;
				END IF;
			WHEN s311 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s312;
					ELSE proximo_estado <= s311;					
					END IF;
				END IF;	
			WHEN s312 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s313;					
					ELSE proximo_estado <= s312;
					END IF;	
				END IF;
			WHEN s313 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s314;					
					ELSE proximo_estado <= s313;
					END IF;	
				END IF;
			WHEN s314 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s315;					
					ELSE proximo_estado <= s314;
					END IF;	
				END IF;
			WHEN s315 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s316;					
					ELSE proximo_estado <= s315;
					END IF;	
				END IF;
			WHEN s316 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s317;					
					ELSE proximo_estado <= s316;
					END IF;	
				END IF;
			WHEN s317 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s318;					
					ELSE proximo_estado <= s317;
					END IF;	
				END IF;
			WHEN s318 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s319;					
					ELSE proximo_estado <= s318;
					END IF;	
				END IF;
			WHEN s319 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s320;					
					ELSE proximo_estado <= s319;
					END IF;
				END IF;
			WHEN s320 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s321;
					ELSE proximo_estado <= s320;
					END IF;
				END IF;
			WHEN s321 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s322;
					ELSE proximo_estado <= s321;					
					END IF;
				END IF;	
			WHEN s322 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s323;					
					ELSE proximo_estado <= s322;
					END IF;	
				END IF;
			WHEN s323 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s324;					
					ELSE proximo_estado <= s323;
					END IF;	
				END IF;
			WHEN s324 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s325;					
					ELSE proximo_estado <= s324;
					END IF;	
				END IF;
			WHEN s325 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s326;					
					ELSE proximo_estado <= s325;
					END IF;	
				END IF;
			WHEN s326 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s327;					
					ELSE proximo_estado <= s326;
					END IF;	
				END IF;
			WHEN s327 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s328;					
					ELSE proximo_estado <= s327;
					END IF;	
				END IF;
			WHEN s328 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s329;					
					ELSE proximo_estado <= s328;
					END IF;	
				END IF;
			WHEN s329 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s330;					
					ELSE proximo_estado <= s329;
					END IF;
				END IF;
			WHEN s330 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s331;
					ELSE proximo_estado <= s330;
					END IF;
				END IF;
			WHEN s331 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s332;
					ELSE proximo_estado <= s331;					
					END IF;
				END IF;	
			WHEN s332 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s333;					
					ELSE proximo_estado <= s332;
					END IF;	
				END IF;
			WHEN s333 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s334;					
					ELSE proximo_estado <= s333;
					END IF;	
				END IF;
			WHEN s334 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s335;					
					ELSE proximo_estado <= s334;
					END IF;	
				END IF;
			WHEN s335 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s336;					
					ELSE proximo_estado <= s315;
					END IF;	
				END IF;
			WHEN s336 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s337;					
					ELSE proximo_estado <= s336;
					END IF;	
				END IF;
			WHEN s337 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s338;					
					ELSE proximo_estado <= s337;
					END IF;	
				END IF;
			WHEN s338 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s339;					
					ELSE proximo_estado <= s338;
					END IF;	
				END IF;
			WHEN s339 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s340;					
					ELSE proximo_estado <= s339;
					END IF;
				END IF;
			WHEN s340 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s341;					
					ELSE proximo_estado <= s340;
					END IF;
				END IF;
			WHEN s341 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s342;					
					ELSE proximo_estado <= s341;
					END IF;
				END IF;
			WHEN s342 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s343;					
					ELSE proximo_estado <= s342;
					END IF;	
				END IF;
			WHEN s343 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s344;					
					ELSE proximo_estado <= s343;
					END IF;	
				END IF;
			WHEN s344 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s345;					
					ELSE proximo_estado <= s344;
					END IF;	
				END IF;
			WHEN s345 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s346;					
					ELSE proximo_estado <= s345;
					END IF;	
				END IF;
			WHEN s346 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s347;					
					ELSE proximo_estado <= s346;
					END IF;	
				END IF;
			WHEN s347 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s348;					
					ELSE proximo_estado <= s347;
					END IF;	
				END IF;
			WHEN s348 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s349;					
					ELSE proximo_estado <= s348;
					END IF;	
				END IF;
			WHEN s349 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s350;					
					ELSE proximo_estado <= s349;
					END IF;
				END IF;
			WHEN s350 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s351;					
					ELSE proximo_estado <= s350;
					END IF;
				END IF;
			WHEN s351 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s352;					
					ELSE proximo_estado <= s351;
					END IF;
				END IF;
			WHEN s352 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s353;					
					ELSE proximo_estado <= s352;
					END IF;	
				END IF;
			WHEN s353 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s354;					
					ELSE proximo_estado <= s353;
					END IF;	
				END IF;
			WHEN s354 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s355;					
					ELSE proximo_estado <= s354;
					END IF;	
				END IF;
			WHEN s355 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s356;					
					ELSE proximo_estado <= s355;
					END IF;	
				END IF;
			WHEN s356 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s357;					
					ELSE proximo_estado <= s356;
					END IF;	
				END IF;
			WHEN s357 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s358;					
					ELSE proximo_estado <= s357;
					END IF;	
				END IF;
			WHEN s358 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s359;					
					ELSE proximo_estado <= s358;
					END IF;	
				END IF;
			WHEN s359 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s360;					
					ELSE proximo_estado <= s359;
					END IF;
				END IF;
			WHEN s360 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s361;					
					ELSE proximo_estado <= s360;
					END IF;
				END IF;
			WHEN s361 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s362;					
					ELSE proximo_estado <= s361;
					END IF;
				END IF;
			WHEN s362 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s363;					
					ELSE proximo_estado <= s362;
					END IF;	
				END IF;
			WHEN s363 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s364;					
					ELSE proximo_estado <= s363;
					END IF;	
				END IF;
			WHEN s364 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s365;					
					ELSE proximo_estado <= s364;
					END IF;	
				END IF;
			WHEN s365 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s366;					
					ELSE proximo_estado <= s365;
					END IF;	
				END IF;
			WHEN s366 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s367;					
					ELSE proximo_estado <= s366;
					END IF;	
				END IF;
			WHEN s367 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s368;					
					ELSE proximo_estado <= s367;
					END IF;	
				END IF;
			WHEN s368 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s369;					
					ELSE proximo_estado <= s368;
					END IF;	
				END IF;
			WHEN s369 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s370;					
					ELSE proximo_estado <= s369;
					END IF;
				END IF;
			WHEN s370 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s371;					
					ELSE proximo_estado <= s370;
					END IF;
				END IF;
			WHEN s371 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s372;					
					ELSE proximo_estado <= s371;
					END IF;
				END IF;
			WHEN s372 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s373;					
					ELSE proximo_estado <= s372;
					END IF;	
				END IF;
			WHEN s373 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s374;					
					ELSE proximo_estado <= s373;
					END IF;	
				END IF;
			WHEN s374 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s375;					
					ELSE proximo_estado <= s374;
					END IF;	
				END IF;
			WHEN s375 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s376;					
					ELSE proximo_estado <= s375;
					END IF;	
				END IF;
			WHEN s376 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s377;					
					ELSE proximo_estado <= s376;
					END IF;	
				END IF;
			WHEN s377 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s378;					
					ELSE proximo_estado <= s377;
					END IF;	
				END IF;
			WHEN s378 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s379;					
					ELSE proximo_estado <= s378;
					END IF;	
				END IF;
			WHEN s379 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s380;					
					ELSE proximo_estado <= s379;
					END IF;
				END IF;
			WHEN s380 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s381;					
					ELSE proximo_estado <= s380;
					END IF;
				END IF;
			WHEN s381 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s382;					
					ELSE proximo_estado <= s381;
					END IF;
				END IF;
			WHEN s382 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s383;					
					ELSE proximo_estado <= s382;
					END IF;	
				END IF;
			WHEN s383 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s384;					
					ELSE proximo_estado <= s383;
					END IF;	
				END IF;
			WHEN s384 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s385;					
					ELSE proximo_estado <= s384;
					END IF;	
				END IF;
			WHEN s385 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s386;					
					ELSE proximo_estado <= s385;
					END IF;	
				END IF;
			WHEN s386 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s387;					
					ELSE proximo_estado <= s386;
					END IF;	
				END IF;
			WHEN s387 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s388;					
					ELSE proximo_estado <= s387;
					END IF;	
				END IF;
			WHEN s388 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s389;					
					ELSE proximo_estado <= s388;
					END IF;	
				END IF;
			WHEN s389 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s390;					
					ELSE proximo_estado <= s389;
					END IF;
				END IF;
			WHEN s390 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s391;					
					ELSE proximo_estado <= s390;
					END IF;
				END IF;
			WHEN s391 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s392;					
					ELSE proximo_estado <= s391;
					END IF;
				END IF;
			WHEN s392 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s393;					
					ELSE proximo_estado <= s392;
					END IF;	
				END IF;
			WHEN s393 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s394;					
					ELSE proximo_estado <= s393;
					END IF;	
				END IF;
			WHEN s394 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s395;					
					ELSE proximo_estado <= s394;
					END IF;	
				END IF;
			WHEN s395 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s396;					
					ELSE proximo_estado <= s395;
					END IF;	
				END IF;
			WHEN s396 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s397;					
					ELSE proximo_estado <= s396;
					END IF;	
				END IF;
			WHEN s397 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s398;					
					ELSE proximo_estado <= s397;
					END IF;	
				END IF;
			WHEN s398 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s399;					
					ELSE proximo_estado <= s398;
					END IF;	
				END IF;
			WHEN s399 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s400;					
					ELSE proximo_estado <= s399;
					END IF;
				END IF;
			WHEN s400 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s401;
					ELSE proximo_estado <= s400;
					END IF;
				END IF;
			WHEN s401 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s402;
					ELSE proximo_estado <= s401;					
					END IF;
				END IF;	
			WHEN s402 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s403;					
					ELSE proximo_estado <= s402;
					END IF;	
				END IF;
			WHEN s403 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s404;					
					ELSE proximo_estado <= s403;
					END IF;	
				END IF;
			WHEN s404 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s405;					
					ELSE proximo_estado <= s404;
					END IF;	
				END IF;
			WHEN s405 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s406;					
					ELSE proximo_estado <= s405;
					END IF;	
				END IF;
			WHEN s406 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s407;					
					ELSE proximo_estado <= s406;
					END IF;	
				END IF;
			WHEN s407 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s408;					
					ELSE proximo_estado <= s407;
					END IF;	
				END IF;
			WHEN s408 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s409;					
					ELSE proximo_estado <= s408;
					END IF;	
				END IF;
			WHEN s409 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s410;					
					ELSE proximo_estado <= s409;
					END IF;
				END IF;
			WHEN s410 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s411;
					ELSE proximo_estado <= s410;
					END IF;
				END IF;
			WHEN s411 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s412;
					ELSE proximo_estado <= s411;					
					END IF;
				END IF;	
			WHEN s412 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s413;					
					ELSE proximo_estado <= s412;
					END IF;	
				END IF;
			WHEN s413 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s414;					
					ELSE proximo_estado <= s413;
					END IF;	
				END IF;
			WHEN s414 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s415;					
					ELSE proximo_estado <= s414;
					END IF;	
				END IF;
			WHEN s415 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s416;					
					ELSE proximo_estado <= s415;
					END IF;	
				END IF;
			WHEN s416 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s417;					
					ELSE proximo_estado <= s416;
					END IF;	
				END IF;
			WHEN s417 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s418;					
					ELSE proximo_estado <= s417;
					END IF;	
				END IF;
			WHEN s418 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s419;					
					ELSE proximo_estado <= s418;
					END IF;	
				END IF;
			WHEN s419 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s420;					
					ELSE proximo_estado <= s419;
					END IF;
				END IF;
			WHEN s420 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s421;
					ELSE proximo_estado <= s420;
					END IF;
				END IF;
			WHEN s421 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s422;
					ELSE proximo_estado <= s421;					
					END IF;
				END IF;	
			WHEN s422 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s423;					
					ELSE proximo_estado <= s422;
					END IF;	
				END IF;
			WHEN s423 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s424;					
					ELSE proximo_estado <= s423;
					END IF;	
				END IF;
			WHEN s424 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s425;					
					ELSE proximo_estado <= s424;
					END IF;	
				END IF;
			WHEN s425 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s426;					
					ELSE proximo_estado <= s425;
					END IF;	
				END IF;
			WHEN s426 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s427;					
					ELSE proximo_estado <= s426;
					END IF;	
				END IF;
			WHEN s427 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s428;					
					ELSE proximo_estado <= s427;
					END IF;	
				END IF;
			WHEN s428 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s429;					
					ELSE proximo_estado <= s428;
					END IF;	
				END IF;
			WHEN s429 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s430;					
					ELSE proximo_estado <= s429;
					END IF;
				END IF;
			WHEN s430 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s431;
					ELSE proximo_estado <= s430;
					END IF;
				END IF;
			WHEN s431 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s432;
					ELSE proximo_estado <= s431;					
					END IF;
				END IF;	
			WHEN s432 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s433;					
					ELSE proximo_estado <= s432;
					END IF;	
				END IF;
			WHEN s433 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s434;					
					ELSE proximo_estado <= s433;
					END IF;	
				END IF;
			WHEN s434 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s435;					
					ELSE proximo_estado <= s434;
					END IF;	
				END IF;
			WHEN s435 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s436;					
					ELSE proximo_estado <= s415;
					END IF;	
				END IF;
			WHEN s436 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s437;					
					ELSE proximo_estado <= s436;
					END IF;	
				END IF;
			WHEN s437 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s438;					
					ELSE proximo_estado <= s437;
					END IF;	
				END IF;
			WHEN s438 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s439;					
					ELSE proximo_estado <= s438;
					END IF;	
				END IF;
			WHEN s439 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s440;					
					ELSE proximo_estado <= s439;
					END IF;
				END IF;
			WHEN s440 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s441;					
					ELSE proximo_estado <= s440;
					END IF;
				END IF;
			WHEN s441 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s442;					
					ELSE proximo_estado <= s441;
					END IF;
				END IF;
			WHEN s442 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s443;					
					ELSE proximo_estado <= s442;
					END IF;	
				END IF;
			WHEN s443 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s444;					
					ELSE proximo_estado <= s443;
					END IF;	
				END IF;
			WHEN s444 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s445;					
					ELSE proximo_estado <= s444;
					END IF;	
				END IF;
			WHEN s445 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s446;					
					ELSE proximo_estado <= s445;
					END IF;	
				END IF;
			WHEN s446 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s447;					
					ELSE proximo_estado <= s446;
					END IF;	
				END IF;
			WHEN s447 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s448;					
					ELSE proximo_estado <= s447;
					END IF;	
				END IF;
			WHEN s448 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s449;					
					ELSE proximo_estado <= s448;
					END IF;	
				END IF;
			WHEN s449 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s450;					
					ELSE proximo_estado <= s449;
					END IF;
				END IF;
			WHEN s450 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s451;					
					ELSE proximo_estado <= s450;
					END IF;
				END IF;
			WHEN s451 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s452;					
					ELSE proximo_estado <= s451;
					END IF;
				END IF;
			WHEN s452 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s453;					
					ELSE proximo_estado <= s452;
					END IF;	
				END IF;
			WHEN s453 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s454;					
					ELSE proximo_estado <= s453;
					END IF;	
				END IF;
			WHEN s454 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s455;					
					ELSE proximo_estado <= s454;
					END IF;	
				END IF;
			WHEN s455 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s456;					
					ELSE proximo_estado <= s455;
					END IF;	
				END IF;
			WHEN s456 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s457;					
					ELSE proximo_estado <= s456;
					END IF;	
				END IF;
			WHEN s457 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s458;					
					ELSE proximo_estado <= s457;
					END IF;	
				END IF;
			WHEN s458 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s459;					
					ELSE proximo_estado <= s458;
					END IF;	
				END IF;
			WHEN s459 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s460;					
					ELSE proximo_estado <= s459;
					END IF;
				END IF;
			WHEN s460 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s461;					
					ELSE proximo_estado <= s460;
					END IF;
				END IF;
			WHEN s461 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s462;					
					ELSE proximo_estado <= s461;
					END IF;
				END IF;
			WHEN s462 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s463;					
					ELSE proximo_estado <= s462;
					END IF;	
				END IF;
			WHEN s463 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s464;					
					ELSE proximo_estado <= s463;
					END IF;	
				END IF;
			WHEN s464 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s465;					
					ELSE proximo_estado <= s464;
					END IF;	
				END IF;
			WHEN s465 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s466;					
					ELSE proximo_estado <= s465;
					END IF;	
				END IF;
			WHEN s466 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s467;					
					ELSE proximo_estado <= s466;
					END IF;	
				END IF;
			WHEN s467 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s468;					
					ELSE proximo_estado <= s467;
					END IF;	
				END IF;
			WHEN s468 =>
				IF (Stop_in = '1') THEN
					proximo_estado <= s0;
				ELSE
					IF (Duracao = '0' and Play_in = '1') THEN
						proximo_estado <= s1;					
					ELSE proximo_estado <= s468;
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
				WHEN s0 => nota(0, ov_t16); --s0 apenas inicia a prox nota
				WHEN s1 => nota(C4, ov_t16);
				WHEN s2 => nota(EB4, ov_t16);
				WHEN s3 => nota(G4, ov_t16);
				WHEN s4 => nota(C5, ov_t16);
				WHEN s5 => nota(EB5, ov_t16);
				WHEN s6 => nota(G5, ov_t16);
				WHEN s7 => nota(C6, ov_t16);
				WHEN s8 => nota(EB6, ov_t16);
				WHEN s9 => nota(G7, ov_t16);
				WHEN s10 => nota(EB6, ov_t16);
				WHEN s11 => nota(C6, ov_t16);
				WHEN s12 => nota(G5, ov_t16);
				WHEN s13 => nota(EB5, ov_t16);
				WHEN s14 => nota(C5, ov_t16);
				WHEN s15 => nota(G4, ov_t16);
				WHEN s16 => nota(EB4, ov_t16);
				
				WHEN s17 => nota(EB4, ov_t16);
				WHEN s18 => nota(G4, ov_t16);
				WHEN s19 => nota(BB4, ov_t16);
				WHEN s20 => nota(EB5, ov_t16);
				WHEN s21 => nota(G5, ov_t16);
				WHEN s22 => nota(BB5, ov_t16);
				WHEN s23 => nota(EB6, ov_t16);
				WHEN s24 => nota(G6, ov_t16);
				WHEN s25 => nota(BB7, ov_t16);
				WHEN s26 => nota(G6, ov_t16);
				WHEN s27 => nota(EB6, ov_t16);
				WHEN s28 => nota(BB5, ov_t16);
				WHEN s29 => nota(G5, ov_t16);
				WHEN s30 => nota(EB5, ov_t16);
				WHEN s31 => nota(EB4, ov_t16);
				WHEN s32 => nota(G4, ov_t16);
				
				WHEN s33 => nota(BB3, ov_t16);
				WHEN s34 => nota(D4, ov_t16);
				WHEN s35 => nota(F4, ov_t16);
				WHEN s36 => nota(BB4, ov_t16);
				WHEN s37 => nota(D5, ov_t16);
				WHEN s38 => nota(F5, ov_t16);
				WHEN s39 => nota(BB5, ov_t16);
				WHEN s40 => nota(D6, ov_t16);
				WHEN s41 => nota(F7, ov_t16);
				WHEN s42 => nota(D6, ov_t16);
				WHEN s43 => nota(BB5, ov_t16);
				WHEN s44 => nota(F5, ov_t16);
				WHEN s45 => nota(D5, ov_t16);
				WHEN s46 => nota(BB4, ov_t16);
				WHEN s47 => nota(F4, ov_t16);
				WHEN s48 => nota(D4, ov_t16);
				
				WHEN s49 => nota(C4, ov_t16);
				WHEN s50 => nota(EB4, ov_t16);
				WHEN s51 => nota(G4, ov_t16);
				WHEN s52 => nota(C5, ov_t16);
				WHEN s53 => nota(EB5, ov_t16);
				WHEN s54 => nota(G5, ov_t16);
				WHEN s55 => nota(C6, ov_t16);
				WHEN s56 => nota(EB6, ov_t16);
				WHEN s57 => nota(G7, ov_t16);
				WHEN s58 => nota(EB6, ov_t16);
				WHEN s59 => nota(C6, ov_t16);
				WHEN s60 => nota(G5, ov_t16);
				WHEN s61 => nota(EB5, ov_t16);
				WHEN s62 => nota(C5, ov_t16);
				WHEN s63 => nota(G4, ov_t16);
				WHEN s64 => nota(EB4, ov_t16);
				
				WHEN s65 => nota(C4, ov_t16);
				WHEN s66 => nota(EB4, ov_t16);
				WHEN s67 => nota(G4, ov_t16);
				WHEN s68 => nota(C5, ov_t16);
				WHEN s69 => nota(EB5, ov_t16);
				WHEN s70 => nota(G5, ov_t16);
				WHEN s71 => nota(C6, ov_t16);
				WHEN s72 => nota(EB6, ov_t16);
				WHEN s73 => nota(G7, ov_t16);
				WHEN s74 => nota(EB6, ov_t16);
				WHEN s75 => nota(C6, ov_t16);
				WHEN s76 => nota(G5, ov_t16);
				WHEN s77 => nota(EB5, ov_t16);
				WHEN s78 => nota(C5, ov_t16);
				WHEN s79 => nota(G4, ov_t16);
				WHEN s80 => nota(EB4, ov_t16);
				
				WHEN s81 => nota(EB4, ov_t16);
				WHEN s82 => nota(G4, ov_t16);
				WHEN s83 => nota(BB4, ov_t16);
				WHEN s84 => nota(EB5, ov_t16);
				WHEN s85 => nota(G5, ov_t16);
				WHEN s86 => nota(BB5, ov_t16);
				WHEN s87 => nota(EB6, ov_t16);
				WHEN s88 => nota(G6, ov_t16);
				WHEN s89 => nota(BB7, ov_t16);
				WHEN s90 => nota(G6, ov_t16);
				WHEN s91 => nota(EB6, ov_t16);
				WHEN s92 => nota(BB5, ov_t16);
				WHEN s93 => nota(G5, ov_t16);
				WHEN s94 => nota(EB5, ov_t16);
				WHEN s95 => nota(BB4, ov_t16);
				WHEN s96 => nota(G4, ov_t16);
				
				WHEN s97 => nota(BB3, ov_t16);
				WHEN s98 => nota(D4, ov_t16);
				WHEN s99 => nota(F4, ov_t16);
				WHEN s100 => nota(BB4, ov_t16);
				WHEN s101 => nota(D5, ov_t16);
				WHEN s102 => nota(F5, ov_t16);
				WHEN s103 => nota(BB5, ov_t16);
				WHEN s104 => nota(D6, ov_t16);
				WHEN s105 => nota(F7, ov_t16);
				WHEN s106 => nota(D6, ov_t16);
				WHEN s107 => nota(BB5, ov_t16);
				WHEN s108 => nota(F5, ov_t16);
				WHEN s109 => nota(D5, ov_t16);
				WHEN s110 => nota(BB4, ov_t16);
				WHEN s111 => nota(F4, ov_t16);
				WHEN s112 => nota(D4, ov_t16);
				
				WHEN s113 => nota(G5, ov_t4);
				WHEN s114 => nota(EB5, ov_t4);
				WHEN s115 => nota(D5, ov_t4);
				WHEN s116 => nota(EB5, ov_t4);
				
				WHEN s117 => nota(C5, ov_t8);
				WHEN s118 => nota(G4, ov_t8);
				WHEN s119 => nota(C5, ov_t8);
				WHEN s120 => nota(D5, ov_t16);
				WHEN s121 => nota(EB5, ov_t8);
				WHEN s122 => nota(EB5, ov_t16);
				WHEN s123 => nota(D5, ov_t8);
				WHEN s124 => nota(C5, ov_t8);
				WHEN s125 => nota(BB4, ov_t8);
				
				WHEN s126 => nota(EB5, ov_t8);
				WHEN s127 => nota(BB4, ov_t8);
				WHEN s128 => nota(EB5, ov_t8);
				WHEN s129 => nota(G4, ov_t16);
				WHEN s130 => nota(BB4, ov_t2);
				WHEN s131 => nota(BB4, ov_t16);
				
				WHEN s132 => nota(F5, ov_t8);
				WHEN s133 => nota(C5, ov_t8);
				WHEN s134 => nota(F5, ov_t8);
				WHEN s135 => nota(G5, ov_t16);
				WHEN s136 => nota(AB5, ov_t8);
				WHEN s137 => nota(AB5, ov_t16);
				WHEN s138 => nota(G5, ov_t8);
				WHEN s139 => nota(F5, ov_t8);
				WHEN s140 => nota(EB5, ov_t8);
				
				WHEN s141 => nota(G5, ov_t8);
				WHEN s142 => nota(EB5, ov_t8);
				WHEN s143 => nota(D5, ov_t16);
				WHEN s144 => nota(EB5, ov_t8);
				WHEN s145 => nota(C5, ov_t2);
				WHEN s146 => nota(C5, ov_t16);
				
				WHEN s147 => nota(C5, ov_t8);
				WHEN s148 => nota(G4, ov_t8);
				WHEN s149 => nota(C5, ov_t8);
				WHEN s150 => nota(D5, ov_t16);
				WHEN s151 => nota(EB5, ov_t8);
				WHEN s152 => nota(EB5, ov_t16);
				WHEN s153 => nota(D5, ov_t8);
				WHEN s154 => nota(C5, ov_t8);
				WHEN s155 => nota(BB4, ov_t8);
				
				WHEN s156 => nota(EB5, ov_t8);
				WHEN s157 => nota(BB4, ov_t8);
				WHEN s158 => nota(EB5, ov_t8);
				WHEN s159 => nota(G4, ov_t16);
				WHEN s160 => nota(BB4, ov_t2);
				WHEN s161 => nota(BB4, ov_t16);
				
				WHEN s162 => nota(F5, ov_t8);
				WHEN s163 => nota(C5, ov_t8);
				WHEN s164 => nota(F5, ov_t8);
				WHEN s165 => nota(G5, ov_t16);
				WHEN s166 => nota(AB5, ov_t8);
				WHEN s167 => nota(AB5, ov_t16);
				WHEN s168 => nota(G5, ov_t8);
				WHEN s169 => nota(F5, ov_t8);
				WHEN s170 => nota(EB5, ov_t8);
				
				WHEN s171 => nota(G5, ov_t8);
				WHEN s172 => nota(EB5, ov_t8);
				WHEN s173 => nota(D5, ov_t16);
				WHEN s174 => nota(EB5, ov_t8);
				WHEN s175 => nota(C5, ov_t2);
				WHEN s176 => nota(C5, ov_t16);
				
				WHEN s177 => nota(AB4, ov_t4);
				WHEN s178 => nota(AB4, ov_t8);
				WHEN s179 => nota(EB5, ov_t4);
				WHEN s180 => nota(D5, ov_t8);
				WHEN s181 => nota(C5, ov_t8);
				WHEN s182 => nota(D5, ov_t8);
				
				WHEN s183 => nota(BB4, ov_t4);
				WHEN s184 => nota(BB4, ov_t8);
				WHEN s185 => nota(F5, ov_t4);
				WHEN s186 => nota(EB5, ov_t8);
				WHEN s187 => nota(D5, ov_t16);
				WHEN s188 => nota(EB5, ov_t16);
				WHEN s189 => nota(F5, ov_t8);
				
				WHEN s190 => nota(C5, ov_t4);
				WHEN s191 => nota(C5, ov_t8);
				WHEN s192 => nota(AB5, ov_t4);
				WHEN s193 => nota(G5, ov_t8);
				WHEN s194 => nota(F5, ov_t8);
				WHEN s195 => nota(EB5, ov_t8);
				
				WHEN s196 => nota(D5, ov_t8);
				WHEN s197 => nota(D5, ov_t8);
				WHEN s198 => nota(D5, ov_t8);
				WHEN s199 => nota(EB5, ov_t8);
				WHEN s200 => nota(F5, ov_t8);
				WHEN s201 => nota(EB5, ov_t8);
				WHEN s202 => nota(D5, ov_t8);
				WHEN s203 => nota(BB4, ov_t8);
				
				WHEN s204 => nota(C5, ov_t8);
				WHEN s205 => nota(G4, ov_t8);
				WHEN s206 => nota(C5, ov_t8);
				WHEN s207 => nota(D5, ov_t16);
				WHEN s208 => nota(EB5, ov_t8);
				WHEN s209 => nota(EB5, ov_t16);
				WHEN s210 => nota(D5, ov_t8);
				WHEN s211 => nota(C5, ov_t8);
				WHEN s212 => nota(BB4, ov_t8);
				
				WHEN s213 => nota(EB5, ov_t8);
				WHEN s214 => nota(BB4, ov_t8);
				WHEN s215 => nota(EB5, ov_t8);
				WHEN s216 => nota(G4, ov_t16);
				WHEN s217 => nota(BB4, ov_t2);
				WHEN s218 => nota(BB4, ov_t16);
				
				WHEN s219 => nota(F5, ov_t8);
				WHEN s220 => nota(C5, ov_t8);
				WHEN s221 => nota(F5, ov_t8);
				WHEN s222 => nota(G5, ov_t16);
				WHEN s223 => nota(AB5, ov_t8);
				WHEN s224 => nota(AB5, ov_t16);
				WHEN s225 => nota(G5, ov_t8);
				WHEN s226 => nota(F5, ov_t8);
				WHEN s227 => nota(EB5, ov_t8);
				
				WHEN s228 => nota(G5, ov_t8);
				WHEN s229 => nota(EB5, ov_t8);
				WHEN s230 => nota(D5, ov_t16);
				WHEN s231 => nota(EB5, ov_t8);
				WHEN s232 => nota(C5, ov_t2);
				WHEN s233 => nota(C5, ov_t16);
				
				WHEN s234 => nota(C5, ov_t8);
				WHEN s235 => nota(G4, ov_t8);
				WHEN s236 => nota(C5, ov_t8);
				WHEN s237 => nota(D5, ov_t16);
				WHEN s238 => nota(EB5, ov_t8);
				WHEN s239 => nota(EB5, ov_t16);
				WHEN s240 => nota(D5, ov_t8);
				WHEN s241 => nota(C5, ov_t8);
				WHEN s242 => nota(BB4, ov_t8);
				
				WHEN s243 => nota(EB5, ov_t8);
				WHEN s244 => nota(BB4, ov_t8);
				WHEN s245 => nota(EB5, ov_t8);
				WHEN s246 => nota(G4, ov_t16);
				WHEN s247 => nota(BB4, ov_t2);
				WHEN s248 => nota(BB4, ov_t16);
				
				WHEN s249 => nota(F5, ov_t8);
				WHEN s250 => nota(C5, ov_t8);
				WHEN s251 => nota(F5, ov_t8);
				WHEN s252 => nota(G5, ov_t16);
				WHEN s253 => nota(AB5, ov_t8);
				WHEN s254 => nota(AB5, ov_t16);
				WHEN s255 => nota(G5, ov_t8);
				WHEN s256 => nota(F5, ov_t8);
				WHEN s257 => nota(EB5, ov_t8);
				
				WHEN s258 => nota(G5, ov_t8);
				WHEN s259 => nota(EB5, ov_t8);
				WHEN s260 => nota(D5, ov_t16);
				WHEN s261 => nota(EB5, ov_t8);
				WHEN s262 => nota(C5, ov_t2);
				WHEN s263 => nota(C5, ov_t16);
				
				WHEN s264 => nota(AB4, ov_t2);
				WHEN s265 => nota(AB4, ov_t4);
				WHEN s266 => nota(EB5, ov_t4);
				
				WHEN s267 => nota(BB4, ov_t2);
				WHEN s268 => nota(BB4, ov_t4);
				WHEN s269 => nota(EB5, ov_t4);
				
				WHEN s270 => nota(AB4, ov_t2);
				WHEN s271 => nota(AB4, ov_t4);
				WHEN s272 => nota(EB5, ov_t4);
				
				WHEN s273 => nota(F5, ov_t16);
				WHEN s274 => nota(D5, ov_t16);
				WHEN s275 => nota(BB4, ov_t16);
				WHEN s276 => nota(F5, ov_t16);
				WHEN s277 => nota(D5, ov_t16);
				WHEN s278 => nota(BB4, ov_t16);
				WHEN s279 => nota(F5, ov_t16);
				WHEN s280 => nota(D5, ov_t16);
				WHEN s281 => nota(BB4, ov_t16);
				WHEN s282 => nota(F5, ov_t16);
				WHEN s283 => nota(D5, ov_t16);
				WHEN s284 => nota(BB4, ov_t16);
				WHEN s285 => nota(G5, ov_t8);
				WHEN s286 => nota(F5, ov_t8);
				
				WHEN s287 => nota(G5, ov_t16);
				WHEN s288 => nota(EB5, ov_t16);
				WHEN s289 => nota(C5, ov_t16);
				WHEN s290 => nota(G5, ov_t16);
				WHEN s291 => nota(EB5, ov_t16);
				WHEN s292 => nota(C5, ov_t16);
				WHEN s293 => nota(G5, ov_t16);
				WHEN s294 => nota(EB5, ov_t16);
				WHEN s295 => nota(C5, ov_t16);
				WHEN s296 => nota(G5, ov_t16);
				WHEN s297 => nota(EB5, ov_t16);
				WHEN s298 => nota(C5, ov_t16);
				WHEN s299 => nota(AB5, ov_t8);
				WHEN s300 => nota(G5, ov_t8);
				
				WHEN s301 => nota(G5, ov_t16);
				WHEN s302 => nota(EB5, ov_t16);
				WHEN s303 => nota(BB4, ov_t16);
				WHEN s304 => nota(G5, ov_t16);
				WHEN s305 => nota(EB5, ov_t16);
				WHEN s306 => nota(BB4, ov_t16);
				WHEN s307 => nota(G5, ov_t16);
				WHEN s308 => nota(EB5, ov_t16);
				WHEN s309 => nota(BB4, ov_t16);
				WHEN s310 => nota(G5, ov_t16);
				WHEN s311 => nota(EB5, ov_t16);
				WHEN s312 => nota(BB4, ov_t16);
				WHEN s313 => nota(AB5, ov_t8);
				WHEN s314 => nota(G5, ov_t8);
				
				WHEN s315 => nota(F5, ov_t16);
				WHEN s316 => nota(D5, ov_t16);
				WHEN s317 => nota(BB4, ov_t16);
				WHEN s318 => nota(F5, ov_t16);
				WHEN s319 => nota(D5, ov_t16);
				WHEN s320 => nota(BB4, ov_t16);
				WHEN s321 => nota(F5, ov_t16);
				WHEN s322 => nota(D5, ov_t16);
				WHEN s323 => nota(BB4, ov_t16);
				WHEN s324 => nota(F5, ov_t16);
				WHEN s325 => nota(D5, ov_t16);
				WHEN s326 => nota(BB4, ov_t16);
				WHEN s327 => nota(G5, ov_t8);
				WHEN s328 => nota(F5, ov_t8);
				
				WHEN s329 => nota(G5, ov_t4);
				WHEN s330 => nota(EB5, ov_t4);
				WHEN s331 => nota(D5, ov_t4);
				WHEN s332 => nota(EB5, ov_t4);
				
				WHEN s333 => nota(G5, ov_t16);
				WHEN s334 => nota(EB5, ov_t16);
				WHEN s335 => nota(C5, ov_t16);
				WHEN s336 => nota(G5, ov_t16);
				WHEN s337 => nota(EB5, ov_t16);
				WHEN s338 => nota(C5, ov_t16);
				WHEN s339 => nota(G5, ov_t16);
				WHEN s340 => nota(EB5, ov_t16);
				WHEN s341 => nota(C5, ov_t16);
				WHEN s342 => nota(G5, ov_t16);
				WHEN s343 => nota(EB5, ov_t16);
				WHEN s344 => nota(C5, ov_t16);
				WHEN s345 => nota(AB5, ov_t8);
				WHEN s346 => nota(G5, ov_t8);
			
				WHEN s347 => nota(F5, ov_t16);
				WHEN s348 => nota(D5, ov_t16);
				WHEN s349 => nota(BB4, ov_t16);
				WHEN s350 => nota(F5, ov_t16);
				WHEN s351 => nota(D5, ov_t16);
				WHEN s352 => nota(BB4, ov_t16);
				WHEN s353 => nota(F5, ov_t16);
				WHEN s354 => nota(D5, ov_t16);
				WHEN s355 => nota(BB4, ov_t16);
				WHEN s356 => nota(F5, ov_t16);
				WHEN s357 => nota(D5, ov_t16);
				WHEN s358 => nota(BB4, ov_t16);
				WHEN s359 => nota(G5, ov_t8);
				WHEN s360 => nota(F5, ov_t8);
				
				WHEN s361 => nota(F5, ov_t16);
				WHEN s362 => nota(D5, ov_t16);
				WHEN s363 => nota(BB4, ov_t16);
				WHEN s364 => nota(F5, ov_t16);
				WHEN s365 => nota(D5, ov_t16);
				WHEN s366 => nota(BB4, ov_t16);
				WHEN s367 => nota(F5, ov_t16);
				WHEN s368 => nota(D5, ov_t16);
				WHEN s369 => nota(BB4, ov_t16);
				WHEN s370 => nota(F5, ov_t16);
				WHEN s371 => nota(D5, ov_t16);
				WHEN s372 => nota(BB4, ov_t16);
				WHEN s373 => nota(G5, ov_t8);
				WHEN s374 => nota(F5, ov_t8);
				
				WHEN s375 => nota(G5, ov_t4);
				WHEN s376 => nota(EB5, ov_t4);
				WHEN s377 => nota(D5, ov_t4);
				WHEN s378 => nota(EB5, ov_t4);
		
				WHEN s379 => nota(C4, ov_t16);
				WHEN s380 => nota(EB4, ov_t16);
				WHEN s381 => nota(G4, ov_t16);
				WHEN s382 => nota(C5, ov_t16);
				WHEN s383 => nota(EB5, ov_t16);
				WHEN s384 => nota(G5, ov_t16);
				WHEN s385 => nota(C6, ov_t16);
				WHEN s386 => nota(EB6, ov_t16);
				WHEN s387 => nota(G7, ov_t16);
				WHEN s388 => nota(EB6, ov_t16);
				WHEN s389 => nota(C6, ov_t16);
				WHEN s390 => nota(G5, ov_t16);
				WHEN s391 => nota(EB5, ov_t16);
				WHEN s392 => nota(C5, ov_t16);
				WHEN s393 => nota(G4, ov_t16);
				WHEN s394 => nota(EB4, ov_t16);
				
				WHEN s395 => nota(EB4, ov_t16);
				WHEN s396 => nota(G4, ov_t16);
				WHEN s397 => nota(BB4, ov_t16);
				WHEN s398 => nota(EB5, ov_t16);
				WHEN s399 => nota(G5, ov_t16);
				WHEN s400 => nota(BB5, ov_t16);
				WHEN s401 => nota(EB6, ov_t16);
				WHEN s402 => nota(G6, ov_t16);
				WHEN s403 => nota(BB7, ov_t16);
				WHEN s404 => nota(G6, ov_t16);
				WHEN s405 => nota(EB6, ov_t16);
				WHEN s406 => nota(BB5, ov_t16);
				WHEN s407 => nota(G5, ov_t16);
				WHEN s408 => nota(EB5, ov_t16);
				WHEN s409 => nota(BB4, ov_t16);
				WHEN s410 => nota(G4, ov_t16);
				
				WHEN s411 => nota(BB3, ov_t16);
				WHEN s412 => nota(D4, ov_t16);
				WHEN s413 => nota(F4, ov_t16);
				WHEN s414 => nota(BB4, ov_t16);
				WHEN s415 => nota(D5, ov_t16);
				WHEN s416 => nota(F5, ov_t16);
				WHEN s417 => nota(BB5, ov_t16);
				WHEN s418 => nota(D6, ov_t16);
				WHEN s419 => nota(F7, ov_t16);
				WHEN s420 => nota(D6, ov_t16);
				WHEN s421 => nota(BB5, ov_t16);
				WHEN s422 => nota(F5, ov_t16);
				WHEN s423 => nota(D5, ov_t16);
				WHEN s424 => nota(BB4, ov_t16);
				WHEN s425 => nota(F4, ov_t16);
				WHEN s426 => nota(D4, ov_t16);
			
				WHEN s427 => nota(C4, ov_t16);
				WHEN s428 => nota(EB4, ov_t16);
				WHEN s429 => nota(G4, ov_t16);
				WHEN s430 => nota(C5, ov_t16);
				WHEN s431 => nota(EB5, ov_t16);
				WHEN s432 => nota(G5, ov_t16);
				WHEN s433 => nota(C6, ov_t16);
				WHEN s434 => nota(EB6, ov_t16);
				WHEN s435 => nota(G7, ov_t16);
				WHEN s436 => nota(EB6, ov_t16);
				WHEN s437 => nota(C6, ov_t16);
				WHEN s438 => nota(G5, ov_t16);
				WHEN s439 => nota(EB5, ov_t16);
				WHEN s440 => nota(C5, ov_t16);
				WHEN s441 => nota(G4, ov_t16);
				WHEN s442 => nota(EB4, ov_t16);
			
				WHEN s443 => nota(C5, ov_t4);
				WHEN s444 => nota(C5, ov_t8);
				WHEN s445 => nota(BB4, ov_t4);
				WHEN s446 => nota(BB4, ov_t8);
				WHEN s447 => nota(G4, ov_t4);
			
				WHEN s448 => nota(BB4, ov_t2);
				WHEN s449 => nota(C5, ov_t2);
				
				WHEN s450 => nota(D5, ov_t4);
				WHEN s451 => nota(D5, ov_t8);
				WHEN s452 => nota(C5, ov_t4);
				WHEN s453 => nota(C5, ov_t8);
				WHEN s454 => nota(BB4, ov_t4);
				
				WHEN s455 => nota(C5, ov_t1);
				
				WHEN s456 => nota(C5, ov_t4);
				WHEN s457 => nota(C5, ov_t8);
				WHEN s458 => nota(BB4, ov_t4);
				WHEN s459 => nota(BB4, ov_t8);
				WHEN s460 => nota(G4, ov_t4);
				
				WHEN s461 => nota(BB4, ov_t2);
				WHEN s462 => nota(G4, ov_t2);
				
				WHEN s463 => nota(BB4, ov_t4);
				WHEN s464 => nota(BB4, ov_t8);
				WHEN s465 => nota(F4, ov_t4);
				WHEN s466 => nota(F4, ov_t8);
				WHEN s467 => nota(EB4, ov_t4);
				
				WHEN s468 => nota(C4, ov_t1);
--Não é necessário WHEN OTHERS pois
--o controle é feito no processo L2
			END CASE;
		END IF;
	END PROCESS L3;
	
	--Atribuição contínua
	Clk_out <= Duracao AND Clk_in;
END bhv;