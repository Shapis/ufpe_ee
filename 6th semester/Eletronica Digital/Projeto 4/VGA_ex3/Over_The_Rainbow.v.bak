module Over_The_Rainbow
(
	output Clk_out = 1'b0,
	output reg Disparo = 1'b0, 
	output reg [27:0] Temp_out,
	output reg [27:0] Freq_out,	
	input Clk_in, Duracao,
	input Stop_in,
	input Play_in
//	input [1:0] Stop_in,  //Para o exemplo é o key 4
//	input [1:0] Play_in   //Para o exemplo é o key 2
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
	
	
	`define BPM 100 //batidas por minuto
	//`define BPS BPM/60 //batidas por segundo
	`define BPS 1.6667//(100/60) //batidas por segundo
	
//	`define ov_t4 (4 * clk_FPGA)/BPS //overflow 4 batidas
//	`define ov_t2 (2 * clk_FPGA)/BPS //overflow 2 batidas
//	`define ov_t1 clk_FPGA / BPS //overflow 1 batida
//	`define ov_t1_2 (clk_FPGA / 2)/BPS //overflow 1/2 batidas
//	`define ov_t1_4	(clk_FPGA / 4)/BPS //overflow 1/4 batidas
//	
	`define ov_t4 38400000//((4 * 16000000)/(100/60)) //overflow 4 batidas
	`define ov_t2 19200000//((2 * 16000000)/(100/60)) //overflow 2 batidas
	`define ov_t1 9600000//(16000000 / (100/60)) //overflow 1 batida
	`define ov_t1_2 4800000//((16000000 / 2)/(100/60)) //overflow 1/2 batidas
	`define ov_t1_4 2400000//((16000000 / 4)/(100/60)) //overflow 1/4 batidas


//Com o clock de 50MHz, a música fica muito rápida. Com um clock de 100MHz a música fica um pouco mais longa 
//que a do professor, mas é bem próxima.
//	`define ov_t4 240000000//((4 * 100000000)/(100/60)) //overflow 4 batidas
//	`define ov_t2 120000000//((2 * 100000000)/(100/60)) //overflow 2 batidas
//	`define ov_t1 60000000//(100000000 / (100/60)) //overflow 1 batida
//	`define ov_t1_2 30000000//((100000000 / 2)/(100/60)) //overflow 1/2 batidas
//	`define ov_t1_4 15000000//((100000000 / 4)/(100/60)) //overflow 1/4 batidas
	
	//FSM Declaração de estados 
	reg [4:0] estado, prox_estado;	
	localparam s0 = 5'b00000;   //define estado 0
	localparam s1 = 5'b00001;   //define estado 1
	localparam s2 = 5'b00010;   //define estado 2
	localparam s3 = 5'b00011;   //define estado 3
	localparam s4 = 5'b00100;   //define estado 4
	localparam s5 = 5'b00101;   //define estado 5
	localparam s6 = 5'b00110;   //define estado 6
	localparam s7 = 5'b00111;   //define estado 7
	localparam s8 = 5'b01000;   //define estado 8
	localparam s9 = 5'b01001;   //define estado 9
	localparam s10 = 5'b01010;   //define estado 10
	localparam s11 = 5'b01011;   //define estado 11
	localparam s12 = 5'b01100;   //define estado 12
	localparam s13 = 5'b01101;   //define estado 13
	localparam s14 = 5'b01110;   //define estado 14
	localparam s15 = 5'b01111;   //define estado 15
	localparam s16 = 5'b10000;   //define estado 16
	localparam s17 = 5'b10001;   //define estado 17
	localparam s18 = 5'b10010;   //define estado 18
	localparam s19 = 5'b10011;   //define estado 19
	localparam s20 = 5'b10100;   //define estado 20
	localparam s21 = 5'b10101;   //define estado 21
	localparam s22 = 5'b10110;   //define estado 22
	localparam s23 = 5'b10111;   //define estado 23
	localparam s24 = 5'b11000;   //define estado 24
	
	
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
					if ((!Duracao) & (Play_in)) prox_estado <= s0;
					else prox_estado <= s24;
			end
			default: prox_estado <= s0; //recupera de estado inválido
		endcase
	end	
	
	//FSM Lógica para controle das saídas
	always @ (estado)//Combinacional 
	begin : L3
		case (estado) //s0 apenas inicia a prox nota
			s0: nota(0, `ov_t2); //s0 apenas inicia a prox nota
			s1: nota(`F3, `ov_t2);
			s2: nota(`F4, `ov_t2);
			s3: nota(`E4, `ov_t1);
			s4: nota(`C4,  `ov_t1_2);
			s5: nota(`D4, `ov_t1_2);
			s6: nota(`E4, `ov_t1);
			s7: nota(`F4, `ov_t1);
			s8: nota(`F3, `ov_t2);
			s9: nota(`D4, `ov_t2);
			s10: nota(`C4, `ov_t4);
			s11: nota(`D3, `ov_t2);
			s12: nota(`H_3, `ov_t2);
			s13: nota(`H3, `ov_t1);
			s14: nota(`F3, `ov_t1_2);
			s15: nota(`G3, `ov_t1_2);
			s16: nota(`H3, `ov_t1);
			s17: nota(`H_3, `ov_t1);
			s18: nota(`G3, `ov_t1);
			s19: nota(`E3, `ov_t1_2);
			s20: nota(`F3, `ov_t1_2);
			s21: nota(`G3, `ov_t1);
			s22: nota(`H3, `ov_t1);
			s23: nota(`F3, `ov_t4);
			s24: nota(0, `ov_t4);
			
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
		