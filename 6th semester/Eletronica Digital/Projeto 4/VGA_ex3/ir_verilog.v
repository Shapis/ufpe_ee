/*---------------------------------
Arquivo:   ir_verilog.v
Modulo:    ir_verilog(clk,rst_n,IR,led_cs,led_db)
Descrição: Controle de Remoto Infravemelho
Autor:     Malki-çedheq Benjamim
Data:      20/01/2022
----------------------------------*/
module ir_verilog(clk,rst_n,IR,bot);

  input   clk; //clock de 50MHz
  input   rst_n; //reset ativo baixo
  input   IR; //entrada de dados irda
  //output reg [3:0] led_cs; //4 displays BCD7SEG
  //output reg [7:0] led_db; //7 segmentos e ponto de cada display BCD7SEG
  output reg [7:0] bot;//seleciona que botão está sendo apertado
  
  //output reg mute; //Armazena 1 bit
  //output reg play_pause;
  //output reg skip;
  //output reg stop;

  
 
 
  reg [7:0] c_endereco, endereco, comando, c_comando; //armazena cada byte dos 32bits (complemento do comando , comando, complento do endereço, endereço)
  reg [31:0] get_data;     // armazena os 32 bits do dado do irda
  reg [5:0]  data_cnt;     // contador para os 32 bits do dado do irda
  reg [2:0]  estado_atual, prox_estado; //registradores de estado da FSM
  reg error_flag;          // flag de erro durante os 32 bits de dados do irda

  //----------------------------------------------------------------------------
  reg irda_reg0;       //valor instável
  reg irda_reg1;       //recebe irda_reg0, para estabilização
  reg irda_reg2;       //recebe irda_reg1, auxilia a determinar a borda do irda
  wire irda_negedge; //determina a borda de descida do irda
  wire irda_posedge; //determina a borda de subida do irda
  wire irda_change;    //determina a transição de borda do irda
    
  always @ (posedge clk) //sincroniza os registradores do irda
    if(!rst_n) //reset assincrono dos registradores do irda
      begin
        irda_reg0 <= 1'b0; //limpa o registrador irda_reg0
        irda_reg1 <= 1'b0; //limpa o registrador irda_reg1
        irda_reg2 <= 1'b0; //limpa o registrador irda_reg2
      end
    else
      begin
        //led_cs<= 4'b0000; //atualiza os registradores do irda na borda de subida do clk
        irda_reg0 <= IR; //recebe o valor lido irda
        irda_reg1 <= irda_reg0; //atualiza com valor estável
        irda_reg2 <= irda_reg1; // atualiza garantindo valor estável de IR
      end
     
  assign irda_change = irda_negedge | irda_posedge; //atribui 1 numa transição de borda de irda
  assign irda_negedge = irda_reg2 & (~irda_reg1);   //atribui 1 na borda de descida de irda
  assign irda_posedge = (~irda_reg2) & irda_reg1;   //atribui 1 na borda de descida de irda

  reg [10:0] cnt1;      //Divisor de frequência por 1750
  reg [8:0]  cnt2;      //conta o número de pontos após o cnt1
  wire verifica_900us;  // verifica a duração de 9ms = 900us
  wire verifica_450us;  // verifica a duração de 4.5ms = 450us
  
  //Lógico '1' – uma rajada de pulso de 562,5µs seguida por um espaço de 1,6875ms, com um tempo total de transmissão de 2,25ms
  wire high;            // verifica  data="1"
  //Lógico '0' – uma rajada de pulso de 562,5µs seguida por um espaço de 562,5µs, com um tempo total de transmissão de 1,125ms
  wire low;             // verifica  data="0"

 
  //----------------------------------------------------------------------------
  always @ (posedge clk)
    if (!rst_n) //reset assíncrono
      cnt1 <= 11'd0; //reinicia o contador 1
    else if (irda_change) //na transição de borda de irda
      cnt1 <= 11'd0; //reinicia o contador 1
    else if (cnt1 == 11'd1750) //caso contador estoure
      cnt1 <= 11'd0; //reinicia o contador 1
    else
      cnt1 <= cnt1 + 1'b1; // incrementa o contador 1
  //----------------------------------------------------------------------------

  //---------------------------------------------------------------------------- 
  always @ (posedge clk)
    if (!rst_n) //reset assíncrono
      cnt2 <= 9'd0; //reinicia o contador 2
    else if (irda_change) //na transição de borda de irda
      cnt2 <= 9'd0; //reinicia o contador 2
    else if (cnt1 == 11'd1750) //1750 pulso nível baixo e 1750 pulsos nível alto
      cnt2 <= cnt2 +1'b1; //incrementa o contador 2
   //----------------------------------------------------------------------------
	
	//Os dois contadores servem para criar um clock de 38 kHz que é o que conta nos 
	
	
	
	
  //Garante a estabilidade avaliando intervalo de contagem inves do valor exato
  assign verifica_900us = ((217 < cnt2) & (cnt2 < 297));// valor exato esperado 256 
  assign verifica_450us = ((88 < cnt2) & (cnt2 < 168)); // valor exato esperado 128  
  assign high = ((38 < cnt2) & (cnt2 < 58));            // valor exato esperado 48
  assign low  = ((6 < cnt2) & (cnt2 < 26));             // valor exato esperado 16

  //----------------------------------------------------------------------------
  // Declaração da FSM
  localparam IDLE_STATE   = 3'b000, //estado inicial
            ATRASO_900us  = 3'b001, //atraso de 900us
            ATRASO_450us  = 3'b010, //atrado de 450us
            DATA_STATE    = 3'b100; //estado de transferência de dados
 
  //FSM Lógica para controle do estado atual (sequencial)
  always @ (posedge clk)
    if (!rst_n) //reset assíncrono
      estado_atual <= IDLE_STATE; //reinicia a FSM
    else
      estado_atual <= prox_estado; //atualiza o estado atual
  
  //FSM Lógica para controle do estado atual (combinacional)
  always @ ( * )
    case (estado_atual)
      IDLE_STATE://quando no estado inicial
        if (~irda_reg1)
          prox_estado = ATRASO_900us; //passa ao estado seguinte
        else 
          prox_estado = IDLE_STATE; //reinicia a FSM
   
      ATRASO_900us: //quando no estado de atraso de 900us
        if (irda_posedge)
          begin
            if (verifica_900us)
              prox_estado = ATRASO_450us; //passa ao estado seguinte
            else
              prox_estado = IDLE_STATE; //reinicia a FSM
          end
        else  //previne inferência de latches
          prox_estado = ATRASO_900us; //permanece no estado atual
   
      ATRASO_450us: //quando no estado de atraso de 450us
        if (irda_negedge)
          begin
            if (verifica_450us)
              prox_estado = DATA_STATE; //passa ao estado seguinte
            else
              prox_estado = IDLE_STATE; //reinicia a FSM
          end
        else //previne inferência de latches
          prox_estado = ATRASO_450us; //permanece no estado atual
			 
   //Quando ele confirma que o pulso de 9 ms e o pulso de 4.5 ms passaram, ai de fato assegura-se que depois vem os dados. 
	
	
      DATA_STATE: //quando no estado de transferência de dados
        if ((data_cnt == 6'd32) & irda_reg2 & irda_reg1) //verifica se recebeu os 32 bits
          prox_estado = IDLE_STATE; //passa ao estado seguinte
        else if (error_flag) //caso apresente erro nos dados de irda
          prox_estado = IDLE_STATE;  //reinicia a FSM
        else
          prox_estado = DATA_STATE; //permanece no estado atual
      default:
        prox_estado = IDLE_STATE; //recupera de estado inválido, reiniciando a FSM
    endcase

  //FSM Lógica para controle das saídas
  always @ (posedge clk)
    if (!rst_n) //reset assíncrono
		begin
		  data_cnt <= 6'd0; //reinicia o contador de bits de dados irda
		  get_data <= 32'd0; //limpa os registradores para os 32 bits de dados irda
		  error_flag <= 1'b0; //limpa a flag de erro de dados irda
		end
	 else if (estado_atual == IDLE_STATE) //quando no estado inicial
      begin
        data_cnt <= 6'd0; //reinicia o contador de bits de dados irda
        get_data <= 32'd0; //limpa os registradores para os 32 bits de dados irda
        error_flag <= 1'b0; //limpa a flag de erro de dados irda
      end
    else if (estado_atual == DATA_STATE) //quando no estado de transmissão de dados
      begin
        if (irda_posedge)  //verifica se é borda de subida
          begin
            if (!low)  //caso não seja nível lógico baixo (nível lógico 0, 560us)
              error_flag <= 1'b1; //define flag de erro
          end
        else if (irda_negedge)  //verifica se é borda de descida
          begin
            if (low) //caso seja nível lógico baixo (nível lógico 0, 560us)
              get_data[0] <= 1'b0;
            else if (high) //caso seja nível lógico alto (nível lógico 1, 1680us)
              get_data[0] <= 1'b1;
            else
              error_flag <= 1'b1; //caso contrário, define flag de erro
             
            get_data[31:1] <= get_data[30:0]; //atualiza o registrador de dados, deslocando 1 bit
            data_cnt <= data_cnt + 1'b1; //incrementa o contador de dados
          end
      end

  
  //Separa cada byte do protocolo de 32bits ----------------------------
  always @ (posedge clk)
    if (!rst_n) //reset assíncrono
		begin
		 c_comando <= 8'b0;  
		 comando  <= 8'b0;
		 endereco <= 8'b0;
		 c_endereco <= 8'b0;
		end
    else if ((data_cnt ==6'd32) & irda_reg1)
		begin
		 c_comando <= get_data[7:0];  //complemento do comando
		 comando <= get_data[15:8]; //comando
		 endereco <= get_data[23:16];//endereco
		 c_endereco <= get_data[31:24];//complemento do endereco
	   end
	  else comando <= 0;
 
  //Exibe nos display de BCD7SEG a tecla pressionado no controle remoto IR
  //always@(comando) 
  //begin
    //case(comando)
    //código no controle IR : decodificação BCD7SEG
      //8'h68: led_db = 8'b1_100_0000;  //exibe 0 no display (botao 0)
      //8'h30: led_db = 8'b1_111_1001;  //exibe 1 no display (botao 1)
      //8'h18: led_db = 8'b1_010_0100;  //exibe 2 no display (botao 2)
      //8'h7A: led_db = 8'b1_011_0000;  //exibe 3 no display (botao 3)
      //8'h10: led_db = 8'b1_001_1001;  //exibe 4 no display (botao 4)
      //8'h38: led_db = 8'b1_001_0010;  //exibe 5 no display (botao 5)
      //8'h5A: led_db = 8'b1_000_0010;  //exibe 6 no display (botao 6)
      //8'h42: led_db = 8'b1_111_1000;  //exibe 7 no display (botao 7)
      //8'h4A: led_db = 8'b1_000_0000;  //exibe 8 no display (botao 8)
      //8'h52: led_db = 8'b1_001_0000;  //exibe 9 no display (botao 9)
		//8'h22: led_db = 8'b1_010_0000;  //exibe A no display (botao PREV) 		
		//8'h02: led_db = 8'b1_000_0011;  //exibe B no display (botao NEXT)
		//8'hC2: led_db = 8'b1_100_0110;  //exibe C no display (botao PLAY)
		//8'hE0: led_db = 8'b1_010_0001;  //exibe D no display (botao VOL-)
		//8'hA8: led_db = 8'b1_000_0110;  //exibe E no display (botao VOL+)
      //default: led_db = 8'b1_000_1110;  //exibe F no display
    //endcase
  //end
	
	
	always@(comando)
	begin
		case(comando)
			8'h68: bot = 8'b00;  //escolhe botao 0(mute)
			8'h30: bot = 8'b01;  //escolhe botao 1(play/pause)
			8'h18: bot = 8'b10;  //escolhe botao 2(skip)
			8'h7A: bot = 8'b11;  //escolhe botao 3(stop)
			default: bot = 8'b11111111;
		endcase
	end
	//talvez seja interessante colocar um conversor de 8 bits para 2 bits aqui
	
	
	
	//always@(bot)
	//begin
		//case(bot)
			//8'b00: led_db = 8'b1_100_0000;  //exibe 0 no display se o botao 0 for escolhido
			//8'b01: led_db = 8'b1_111_1001;  //exibe 1 no display se o botao 1 for escolhido
			//8'b10: led_db = 8'b1_010_0100;  //exibe 2 no display se o botao 2 for escolhido
			//8'b11: led_db = 8'b1_011_0000;  //exibe 3 no display se o botao 3 for escolhido
			//default: led_db = 8'b1_111_1111;//exibe F para mostrar que não está recebendo comandos
		//endcase
	//end
	
	
//	always@(bot)
//	begin
//		case(bot)
//			8'b00: mute = 1'b1;  //escolhe botao 0(mute)
//			8'b01: play_pause = 1'b1;  //escolhe botao 1(play)
//			8'b10: skip = 1'b1;  //escolhe botao 2(skip)
//			8'b11: stop = 1'b1;  //escolhe botao 3(stop)
//			default: vazio = 1'b0; //precisa?
//		endcase
//	end
	
	
	
	
	
	
	
endmodule 


