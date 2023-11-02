module Fur_Elise
(
	output Clk_out = 1'b0,
	output reg Disparo = 1'b0, 
	output reg [27:0] Temp_out,
	output reg [27:0] Freq_out,	
	input Clk_in, Duracao,
	input Stop_in,
	input Play_in
	//Para o exemplo é o key 4
	//input [1:0] Play_in   //Para o exemplo é o key 2
);

	
	//overflow para frequencias
	
	`define clk_FPGA 16000000 //16MHz
	
	`define C4 15296.36 //1046Hz (C4 ou Dó4)
	`define D4 13617.02 //1175Hz (D4 ou Ré4)
	`define E4 12139.60 //1318Hz (E4 ou Mi4)
	`define F4 11453.11 //1397Hz (F4 ou Fá4)
	`define G4 10012.52 //1598Hz (G4 ou Sol4)
	
	`define D_4 12861.73 //1244Hz (D#4 ou Ré#4)
	
	`define C3 30592.73 //523Hz (C3 ou Dó3)
	`define D3 27257.24 //587Hz (D3 ou Ré3)
	`define E3 24279.21 //659Hz (E3 ou Mi3)
	`define F3 22922.64 //698Hz (F3 ou Fá3)
	`define G3 20408.16 //784Hz (G3 ou Sol3)
	`define H3 18181.81 //880Hz (H3 ou Lá3)
	`define I3 16194.33 //988Hz (I3 ou Si3)
	
	`define D_3 25723.47 //622Hz (D#3 ou Ré#3)
	`define G_3 19253.91 //831Hz (G#3 ou Sol#3)
	`define H_3 17167.38 //932Hz (H#3 ou Lá#3)
	
	//overflow para tempos
	//`define ov_t1 200000000 //4000ms
	//`define ov_t2 100000000 //2000ms
	//`define ov_t3 50000000 //1000ms
	//`define ov_t4 25000000 //500ms
	//`define ov_t5 12500000 //250ms
	
	
	`define BPM 136 //batidas por minuto
	//`define BPS BPM/60 //batidas por segundo
	`define BPS 2.2667//(136/60) //batidas por segundo
	
//	`define ov_t4 (4 * clk_FPGA)/BPS //overflow 4 batidas
//	`define ov_t2 (2 * clk_FPGA)/BPS //overflow 2 batidas
//	`define ov_t1 clk_FPGA / BPS //overflow 1 batida
//	`define ov_t1_2 (clk_FPGA / 2)/BPS //overflow 1/2 batidas
//	`define ov_t1_4	(clk_FPGA / 4)/BPS //overflow 1/4 batidas
//	


	`define ov_t4 28235294.1176//((4 * 16000000)/(136/60)) //overflow 4 batidas
	`define ov_t2 14117647.0588//((2 * 16000000)/(136/60)) //overflow 2 batidas
	`define ov_t1 7058823.5294//(16000000 / (136/60)) //overflow 1 batida
	`define ov_t1_2 3529411.7647//((16000000 / 2)/(136/60)) //overflow 1/2 batidas
	`define ov_t1_4 1764705.8823//((16000000 / 4)/(136/60)) //overflow 1/4 batidas
	
	//FSM Declaração de estados 
	reg [5:0] estado, prox_estado;	
	localparam s0 = 6'b000000;   //define estado 0
	localparam s1 = 6'b000001;   //define estado 1
	localparam s2 = 6'b000010;   //define estado 2
	localparam s3 = 6'b000011;   //define estado 3
	localparam s4 = 6'b000100;   //define estado 4
	localparam s5 = 6'b000101;   //define estado 5
	localparam s6 = 6'b000110;   //define estado 6
	localparam s7 = 6'b000111;   //define estado 7
	localparam s8 = 6'b001000;   //define estado 8
	localparam s9 = 6'b001001;   //define estado 9
	localparam s10 = 6'b001010;   //define estado 10
	localparam s11 = 6'b001011;   //define estado 11
	localparam s12 = 6'b001100;   //define estado 12
	localparam s13 = 6'b001101;   //define estado 13
	localparam s14 = 6'b001110;   //define estado 14
	localparam s15 = 6'b001111;   //define estado 15
	localparam s16 = 6'b010000;   //define estado 16
	localparam s17 = 6'b010001;   //define estado 17
	localparam s18 = 6'b010010;   //define estado 18
	localparam s19 = 6'b010011;   //define estado 19
	localparam s20 = 6'b010100;   //define estado 20
	localparam s21 = 6'b010101;   //define estado 21
	localparam s22 = 6'b010110;   //define estado 22
	localparam s23 = 6'b010111;   //define estado 23
	localparam s24 = 6'b011000;   //define estado 24
	localparam s25 = 6'b011001;   //define estado 25
	localparam s26 = 6'b011010;   //define estado 26
	localparam s27 = 6'b011011;   //define estado 27
	localparam s28 = 6'b011100;   //define estado 28
	localparam s29 = 6'b011101;   //define estado 29
	localparam s30 = 6'b011110;   //define estado 30
	localparam s31 = 6'b011111;   //define estado 31
	localparam s32 = 6'b100000;   //define estado 32
	localparam s33 = 6'b100001;   //define estado 33
	localparam s34 = 6'b100010;   //define estado 34
	localparam s35 = 6'b100011;   //define estado 35
	localparam s36 = 6'b100100;   //define estado 36
	localparam s37 = 6'b100101;   //define estado 37
	localparam s38 = 6'b100110;   //define estado 38
	localparam s39 = 6'b100111;   //define estado 39
	localparam s40 = 6'b101000;   //define estado 40
	localparam s41 = 6'b101001;   //define estado 41
	
	
	//FSM Lógica para controle do estado atual
	always @ (posedge Clk_in)
	begin : L1
		estado <= prox_estado;
	end
	
	//FSM Lógica para controle do próximo estado
	always @ (posedge Clk_in)//Combinacional 
	begin : L2
		case (estado)
			s0: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s1;
					else prox_estado <= s0;
			end
			s1: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s2;
					else prox_estado <= s1;
			end
			s2: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s3;
					else prox_estado <= s2;
			end
			s3: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s4;
					else prox_estado <= s3;
			end
			s4: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s5;
					else prox_estado <= s4;
			end
			s5: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s6;
					else prox_estado <= s5;
			end
			s6: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s7;
					else prox_estado <= s6;
			end
			s7: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s8;
					else prox_estado <= s7;
			end
			s8: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s9;
					else prox_estado <= s8;
			end
			s9: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s10;
					else prox_estado <= s9;
			end
			s10: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s11;
					else prox_estado <= s10;
			end
			s11: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s12;
					else prox_estado <= s11;
			end
			s12: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s13;
					else prox_estado <= s12;
			end
			s13: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s14;
					else prox_estado <= s13;
			end
			s14: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s15;
					else prox_estado <= s14;
			end
			s15: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s16;
					else prox_estado <= s15;
			end
			s16: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s17;
					else prox_estado <= s16;
			end
			s17: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s18;
					else prox_estado <= s17;
			end
			s18: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s19;
					else prox_estado <= s18;
			end
			s19: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s20;
					else prox_estado <= s19;
			end
			s20: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s21;
					else prox_estado <= s20;
			end
			s21: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s22;
					else prox_estado <= s21;
			end
			s22: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s23;
					else prox_estado <= s22;
			end
			s23: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s24;
					else prox_estado <= s23;
			end
			s24: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s25;
					else prox_estado <= s24;
			end
			s25: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s26;
					else prox_estado <= s25;
			end
			s26: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s27;
					else prox_estado <= s26;
			end
			s27: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s28;
					else prox_estado <= s27;
			end
			s28: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s29;
					else prox_estado <= s28;
			end
			s29: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s30;
					else prox_estado <= s29;
			end
			s30: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s31;
					else prox_estado <= s30;
			end
			s31: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s32;
					else prox_estado <= s31;
			end
			s32: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s33;
					else prox_estado <= s32;
			end
			s33: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s34;
					else prox_estado <= s33;
			end
			s34: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s35;
					else prox_estado <= s34;
			end
			s35: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s36;
					else prox_estado <= s35;
			end
			s36: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s37;
					else prox_estado <= s36;
			end
			s37: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s38;
					else prox_estado <= s37;
			end
			s38: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s39;
					else prox_estado <= s38;
			end
			s39: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s40;
					else prox_estado <= s39;
			end
			s40: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s41;
					else prox_estado <= s40;
			end
			s41: begin
				if (Stop_in) prox_estado <= s0;
				else
					if ((!Duracao) & (Play_in)) prox_estado <= s0;
					else prox_estado <= s41;
			end
			default: prox_estado <= s0; //recupera de estado inválido
		endcase
	end	
	
	//FSM Lógica para controle das saídas
	always @ (estado)//Combinacional 
	begin : L3
		case (estado) //s0 apenas inicia a prox nota
			s0: nota(0,`ov_t2);  //freq atual, dur prox		
			s1: nota(`E4,`ov_t1_2);//freq atual, dur prox
			s2: nota(`D_4,`ov_t1_2);//freq atual, dur prox
			s3: nota(`E4,`ov_t1_2);//freq atual, dur prox
			s4: nota(`D_4,`ov_t1_2);//freq atual, dur prox
			s5: nota(`E4,`ov_t1_2);//freq atual, dur prox
			s6: nota(`I3,`ov_t1_2);//freq atual, dur prox
			s7: nota(`D4,`ov_t1_2);//freq atual, dur prox
			s8: nota(`C4,`ov_t1_2);//freq atual, dur prox
			s9: nota(`H3,`ov_t1);//freq atual, dur prox
			s10: nota(0,`ov_t1_2);//freq atual, dur prox
			s11: nota(`C3,`ov_t1_2);//freq atual, dur prox
			s12: nota(`E3,`ov_t1_2);//freq atual, dur prox
			s13: nota(`H3,`ov_t1_2);//freq atual, dur prox
			s14: nota(`I3,`ov_t1);//freq atual, dur prox
			s15: nota(0,`ov_t1_2);//freq atual, dur prox
			s16: nota(`E3,`ov_t1_2);//freq atual, dur prox
			s17: nota(`G_3,`ov_t1_2);//freq atual, dur prox
			s18: nota(`I3,`ov_t1_2);//freq atual, dur prox
			s19: nota(`C4,`ov_t1);//freq atual, dur prox
			s20: nota(0,`ov_t1_2);//freq atual, dur prox
			s21: nota(`E3,`ov_t1_2);//freq atual, dur prox
			s22: nota(`E4,`ov_t1_2);//freq atual, dur prox
			s23: nota(`D_4,`ov_t1_2);//freq atual, dur prox
			s24: nota(`E4,`ov_t1_2);//freq atual, dur prox
			s25: nota(`D_4,`ov_t1_2);
			s26: nota(`E4,`ov_t1_2);
			s27: nota(`I3,`ov_t1_2);
			s28: nota(`D4, `ov_t1_2);
			s29: nota(`C4, `ov_t1_2);
			s30: nota(`H3, `ov_t1);
			s31: nota(0, `ov_t1_2);
			s32: nota(`C3, `ov_t1_2);
			s33: nota(`E3, `ov_t1_2);
			s34: nota(`H3, `ov_t1_2);
			s35: nota(`I3, `ov_t1);
			s36: nota(0, `ov_t1_2);
			s37: nota(`E3, `ov_t1_2);
			s38: nota(`C4, `ov_t1_2);
			s39: nota(`I3, `ov_t1_2);
			s40: nota(`H3, `ov_t2);
			s41: nota(0, `ov_t1);
			
		endcase
	end
	
	//Atribuição contínua
	assign Clk_out = Duracao & Clk_in;	
	
	//Tarefa para atribuição de saídas nos estados
	task nota( input [27:0] ov_f, ov_t);
	begin
		Temp_out = ov_t; //define a duração	proxima nota			
		Freq_out = ov_f; //define a frequência nota atual
		Disparo = 1'b1;  //dispara o temp a próxima nota		
	end
	endtask
	
endmodule		
		