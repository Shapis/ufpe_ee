/*---------------------------------
Arquivo:   ir_verilog.v
Modulo:    ir_verilog(clk,rst_n,IR,led_cs,led_db)
Descrição: Controle de Remoto Infravemelho
Autor:     Malki-çedheq Benjamim
Data:      20/01/2022
Atualizado:30/08/2023


O módulo `ir_verilog` implementa um controle remoto infravermelho utilizando uma lógica digital para interpretar os sinais provenientes de um controle remoto IR 
e exibir o código da tecla pressionada em displays de 7 segmentos usando a codificação BCD.


1. **Entradas e Saídas:**
   - `clk`: Sinal de clock com frequência de 50MHz.
   - `rst_n`: Sinal de reset assíncrono ativo-baixo.
   - `IR`: Entrada de dados do receptor de infravermelho (IRDA).
   - `led_cs`: Saída para controlar displays de 7 segmentos (BCD).
   - `led_db`: Saída para exibir os segmentos individuais dos displays de 7 segmentos.

2. **Registradores:**
   - `led1`, `led2`, `led3`, `led4`: Registradores que representam os dígitos individuais dos displays de 7 segmentos.
   - `irda_data`: Registrador que armazena os dados do sinal IR.
   - `get_data`: Registrador que armazena os 32 bits do dado do sinal IR.
   - `data_cnt`: Contador para os bits do dado do sinal IR.
   - `estado_atual`, `prox_estado`: Registradores de estado para a máquina de estados.
   - `error_flag`: Flag que indica erro durante a recepção dos dados IR.

3. **Lógica de Recepção IR:**
   - O código implementa uma lógica de recepção para interpretar os dados do sinal IR.
   - Usa registradores de atraso e detecção de bordas para identificar os pulsos de sinais.
   - Divide o sinal em intervalos de tempo de 900us e 450us para distinguir entre bits lógicos '1' e '0'.
   - Armazena os bits recebidos e verifica se uma sequência de 32 bits foi recebida corretamente.
   - A FSM (Finite State Machine) controla o processo de recepção e identificação dos bits.

4. **Lógica de Exibição em Displays de 7 Segmentos:**
   - Mapeia os códigos recebidos do controle remoto IR para dígitos específicos em displays de 7 segmentos.
   - Exibe os dígitos nos displays usando os segmentos individuais controlados por `led_db`.

5. **Máquina de Estados (FSM):**
   - Implementa uma FSM para controlar o processo de recepção e decodificação dos sinais IR.
   - A FSM possui estados como IDLE_STATE, ATRASO_900us, ATRASO_450us e DATA_STATE.
   - Transita entre estados com base em bordas e contadores.

6. **Bordas e Contadores:**
   - São usados registradores de atraso e detecção de bordas para identificar as transições do sinal IR.
   - `irda_change`, `irda_negedge`, `irda_posedge`: Sinais que identificam as mudanças de borda no sinal IR.
   - `cnt1` e `cnt2`: Contadores para controlar os intervalos de tempo de 1750us e 450us.
   - Os contadores são reiniciados com base em transições de borda e intervalos de tempo.

Envolve o processamento de sinais de controle remoto IR e a exibição dos códigos decodificados em displays de 7 segmentos. 
A FSM desempenha um papel crucial na coordenação dessas operações, garantindo uma interpretação correta dos sinais e a exibição apropriada nos displays.


O protocolo NEC (National Electrical Code) é um protocolo de comunicação infravermelha amplamente utilizado para a transmissão de comandos de controle remoto em dispositivos eletrônicos, como TVs, DVDs, decodificadores e outros aparelhos. 
Este protocolo define um formato de quadro específico que permite a transmissão de informações como códigos de teclas pressionadas em um controle remoto.

1. **Formato do Quadro:**
   - Cada quadro começa com uma série de pulsos de marcação (high) seguidos por uma série de espaços (low).
   - O quadro é composto por 32 bits de dados, onde o MSB (bit mais significativo) é transmitido primeiro.
   - Os bits de dados são transmitidos usando um formato de codificação de pulso-largura (pulse width modulation - PWM), onde a duração dos pulsos indica se o bit é '0' ou '1'.

2. **Pulsos e Espaços:**
   - Um bit '0' é codificado com um pulso de marcação seguido por um espaço.
   - Um bit '1' é codificado com um pulso de marcação seguido por um espaço mais longo.

3. **Início e Fim do Quadro:**
   - Um quadro começa com um pulso de marcação longo (preamble) seguido por um espaço curto.
   - Após o quadro de 32 bits de dados, é transmitido um espaço longo para indicar o término do quadro.

4. **Repetição e Lógica Inversa:**
   - O protocolo NEC normalmente utiliza repetição para aumentar a confiabilidade da transmissão.
   - A repetição é realizada transmitindo o mesmo código duas vezes, seguido por um espaço curto.
   - Além disso, a lógica inversa (bitwise NOT) é aplicada aos bits de dados para melhorar a integridade dos dados transmitidos.

5. **Endereço e Comando:**
   - Os 32 bits do quadro NEC são divididos em dois campos: um campo de 16 bits para o endereço do dispositivo e um campo de 16 bits para o comando.
   - Isso permite que vários dispositivos compartilhem o mesmo protocolo, mas respondam apenas a comandos específicos destinados a eles.

6. **Tempo de Transmissão:**
   - O protocolo NEC opera com uma frequência de repetição de cerca de 38 kHz.
   - O tempo total de transmissão de um quadro é de aproximadamente 110 ms, incluindo a repetição.

O protocolo NEC é um método de comunicação infravermelha usado em controles remotos para transmitir códigos de teclas pressionadas e comandos de dispositivos eletrônicos. 
Ele define um formato de quadro específico, incluindo pulsos e espaços para representar bits '0' e '1'. 
A repetição e a lógica inversa são usadas para aumentar a confiabilidade da transmissão.
----------------------------------*/
module ir_verilog(clk,rst_n,IR,led_cs,led_db);

  input   clk; //clock de 50MHz
  input   rst_n; //reset ativo baixo
  input   IR; //entrada de dados irda
  output reg [3:0] led_cs; //4 displays BCD7SEG
  output reg [7:0] led_db; //7 segmentos e ponto de cada display BCD7SEG
 
  reg [7:0] led1,led2,led3,led4; //representa cada display com 7 segmentos
  reg [15:0] irda_data;    // armazena o dado do irda, e então envia para os 7 segmentos
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
  
  //reg[15:0] cnt_scan;//ɨ��Ƶ�ʼ�����
   
  always @ (posedge clk) //sincroniza os registradores do irda
    if(!rst_n) //reset assincrono dos registradores do irda
      begin
        irda_reg0 <= 1'b0; //limpa o registrador irda_reg0
        irda_reg1 <= 1'b0; //limpa o registrador irda_reg1
        irda_reg2 <= 1'b0; //limpa o registrador irda_reg2
      end
    else
      begin
        led_estado_atual<= 4'b0000; //atualiza os registradores do irda na borda de subida do clk
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

  
  //Lógica para o controle dos displays BCD7SEG ----------------------------
  always @ (posedge clk)
    if (!rst_n)
      irda_data <= 16'd0;
    else if ((data_cnt ==6'd32) & irda_reg1)
  begin
    led1 <= get_data[7:0];  //Complemento dos dados
    led2 <= get_data[15:8]; //Código dos dados
    led3 <= get_data[23:16];//Código de usuário
    led4 <= get_data[31:24];
  end
 
  //Exibe nos display de BCD7SEG a tecla pressionado no controle remoto IR
  always@(led2) 
  begin
    case(led2)
    //código no controle IR : decodificação BCD7SEG
      8'b01101000: led_db = 8'b1100_0000;  //exibe 0 no display
      8'b00110000: led_db = 8'b1111_1001;  //exibe 0 no display
      8'b00011000: led_db = 8'b1010_0100;  //exibe 0 no display
      8'b01111010: led_db = 8'b1011_0000;  //exibe 0 no display
      8'b00010000: led_db = 8'b1001_1001;  //exibe 0 no display
      8'b00111000: led_db = 8'b1001_0010;  //exibe 0 no display
      8'b01011010: led_db = 8'b1000_0010;  //exibe 0 no display
      8'b01000010: led_db = 8'b1111_1000;  //exibe 0 no display
      8'b01001010: led_db = 8'b1000_0000;  //exibe 0 no display
      8'b01010010: led_db = 8'b1001_0000;  //exibe 0 no display   
      default:     led_db = 8'b1000_1110;  //exibe F no display
    endcase
  end

endmodule 


