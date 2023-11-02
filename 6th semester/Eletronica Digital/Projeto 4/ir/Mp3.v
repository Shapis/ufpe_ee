module Mp3(
	output buzzer,
	output reg [15:0] autor,
	output reg [15:0] musicas,
	
	output reg play_pause,
	output reg stop,
	
	//output reg luz,
	
	input clock,
	input [7:0] bot
);
	
	localparam s0 = 1'b0;
	localparam s1 = 1'b1;
	reg estado_atual, prox_estado;
	
	wire t1;
	reg t2,t4;
	reg [27:0] t3,t5;
	
	//reg musica1t2, musica1t4, musica2t2, musica2t4;
	//reg [27:0] musica1t3, musica1t5;
	wire musica1t2, musica1t4, musica2t2, musica2t4;
	wire [27:0] musica1t3, musica1t5, musica2t3, musica2t5;
	//wire musica1play, musica1stop, musia2play, musica2stop;
	reg musica1play, musica1stop, musica2play, musica2stop;
	
	//reg bot1, bot2;
	
	wire freq_nota;
	//reg freq_nota;
	
	reg silencio;
	reg skip;
	
	reg resto;
	
	//reg toggle2, toggle4;
	
//	`define musica1_1 = "    Fur Elise   "
//	`define musica1_2 = "    Beethoven   "
//	`define musica2_1 = "Over The Rainbow"
//	`define musica2_2 = "   Yip Harburg  "

	assign musica1_1 = "    Fur Elise   ";
	assign musica1_2 = "    Beethoven   ";
	assign musica2_1 = "Over The Rainbow";
	assign musica2_2 = "   Yip Harburg  ";
	
	temporizador 	temp( .Q(t1),
								.Clk(clock),
								.Disparo(t2),
								.Overflow(t3)
						);
						
	divisor_clock 	div_clk( .Clk_out(freq_nota),
									.Clk_in(clock),
									.Overflow(t5)
						);
						
	always @(posedge clock)
	begin
		case(bot)
			8'b00: silencio <= !silencio;//1'b1;
			8'b01: begin
						if (!stop) play_pause <= !play_pause;
						else play_pause <= play_pause;
					 end	
			8'b10: begin
						if (stop) skip <= 1'b1;
						else skip <= 1'b0;
					 end
			8'b11: begin
						stop <= !stop;//1'b1;
						play_pause <= 1'b0;
					 end
			default begin
						silencio <= silencio;
						play_pause <= play_pause;
						stop <= stop;
						skip <= 1'b0;
					  end
		endcase
	end
	
//	PROCESS (b2)
//		BEGIN
//		IF (toggle4 = '1') THEN
//			toggle2 <= '0';
//		ELSIF FALLING_EDGE(b2) THEN
//			IF (toggle2 = '0') THEN
//				toggle2 <= '1';
//			ELSE
//				toggle2 <= '0';
//			END IF;
//		END IF;
//	END PROCESS;
//	
//	play_pause <= toggle2;
//	
//	PROCESS (b4)
//		BEGIN
//		IF FALLING_EDGE(b4) THEN
//			IF (toggle4 = '0') THEN
//				toggle4 <= '1';
//			ELSE
//				toggle4 <= '0';
//			END IF;
//		END IF;
//	END PROCESS;
//	stop <= toggle4;




	//Deveria usar um toggle feito a gente fez em vhdl?
//	always @(posedge play_pause)
//	begin
//		if (toggle4) toggle2 <= 1'b0;
//		else if (play_pause)//Fica um pouco estranho sem o nededge
//			if (!toggle2) toggle2 <= 1'b1;
//			else toggle2 <= 1'b0;
//	end
//	assign play_pause = toggle2;//Porque play_pause e stop tem que ser wires?
//	
//	always @(posedge stop)
//	begin
//		if (!toggle4) toggle4 <= 1'b1;
//		else toggle4 <= 1'b0;
//	end
//	assign stop = toggle4;

	
	
	
	
	
	
	
	assign buzzer = freq_nota & (!silencio);
//	always @(posedge clock)
//	begin
//		if (!silencio) buzzer <= freq_nota;
//		else buzzer <= 1'b0;
//	end
	
	
	Fur_Elise 	control( .Clk_out(musica1t4),
							   .Disparo(musica1t2),
								.Temp_out(musica1t3),
								.Freq_out(musica1t5),
								.Clk_in(clock),
								.Duracao(t1),
								.Stop_in(musica1stop),
								.Play_in(musica1play)
						);
						
	Over_The_Rainbow 	contro( .Clk_out(musica2t4),
								 .Disparo(musica2t2),
								 .Temp_out(musica2t3),
								 .Freq_out(musica2t5),
								 .Clk_in(clock),
								 .Duracao(t1),
								 .Stop_in(musica2stop),
								 .Play_in(musica2play)
						);
						
					
	//FSM Lógica para controle do estado atual
	always @ (posedge skip)
	begin : L1
		if (stop) estado_atual <= prox_estado; 
		else estado_atual <= estado_atual;
	end
	
	//FSM Lógica para controle do próximo estado
	always @ (posedge clock)//Combinacional 
	begin : L2
		case (estado_atual)
			s0: prox_estado <= s1;//próximo estado	
			s1: prox_estado <= s0;//próximo estado
			default: prox_estado <= s0; //recupera de estado inválido
		endcase
	end	
	
	//FSM Lógica para controle das saídas
	always @ (estado_atual)//Combinacional 
	begin : L3
		case (estado_atual) 
			s0: begin
				musica1play <= play_pause;
				musica1stop <= stop;
				t2 <= musica1t2;
				t3 <= musica1t3;
				t5 <= musica1t5;
				musicas <= musica1_1;
				autor <= musica1_2;
				//luz <= 1'b1;
			end
			s1: begin
				musica2play <= play_pause;
				musica2stop <= stop;
				t2 <= musica2t2;
				t3 <= musica2t3;
				t5 <= musica2t5;
				musicas <= musica2_1;
				autor <= musica2_2;
				//luz <= 1'b0;
			end
		endcase
	end

endmodule

