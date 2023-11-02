/*
Autor: Malki-çedheq Benjamim
Disciplina: Eletrônica Digital 1A
Descrição: Módulo para sincronização horizontal da interface VGA
Referência: 
	https://web.mit.edu/6.111/www/labkit/vga.shtml
	http://tinyvga.com/vga-timing
	
Detalhamento:

	O módulo `horizontal_sync` é responsável por gerar os sinais de sincronização horizontal necessários para a interface VGA. Esses sinais controlam a posição horizontal da varredura da tela e permitem que o monitor sincronize a exibição de dados corretamente. O módulo trabalha em conjunto com o módulo de sincronização vertical (`vertical_sync`) e o gerador de pixels (`pixel_generator`) para formar a base da interface VGA completa.

	1. **Entradas:**
		- `clock`: O sinal de clock do sistema.
		
	2. **Saídas:**
		- `hsync`: Sinal de sincronização horizontal que indica o início de uma nova linha na tela.
		- `hcount`: Contador de varredura horizontal que representa a posição atual da varredura na linha.
		- `hcount_ov`: Sinal que indica o estouro do contador de varredura horizontal, ou seja, quando uma nova linha começa.
		- `dat_act_h`: Sinal de ativação de pixels horizontal, que é usado para ativar os pixels apenas durante a varredura ativa da linha.
		
	3. **Parâmetros e Constantes:**
		- Os parâmetros definem os valores de temporização da varredura horizontal, como o tempo de duração do pulso de sincronização horizontal, a largura do pórtico de trás e da frente e a resolução horizontal da tela.
		
	4. **Variáveis e Sinais Internos:**
		- `hcount`: Registrador para armazenar o valor atual da varredura horizontal.
		- `vga_clk`: Sinal de clock interno para sincronização.
		
	5. **Lógica de Geração de Clock Interno:**
		- Gera um sinal de clock interno `vga_clk` com uma frequência de 25 MHz para sincronização.
		
	6. **Lógica de Contagem de Varredura Horizontal:**
		- O contador de varredura horizontal `hcount` é incrementado a cada ciclo de clock, representando a posição atual da varredura na linha.
		- Quando o contador atinge o valor que representa o final da linha, o sinal `hcount_ov` é ativado para indicar o início de uma nova linha.
		
	7. **Lógica de Sincronização Horizontal:**
		- O sinal `hsync` é ativado no início de cada nova linha e mantido alto durante o pulso de sincronização horizontal.
		- O sinal `dat_act_h` é definido para ativar os pixels apenas durante a varredura ativa da linha.
		
	8. **Definição da Resolução Horizontal:**
		- Os parâmetros de temporização definem os limites da varredura horizontal, como o início e o fim da linha ativa, os pórticos de trás e de frente, e assim por diante.

	O módulo `horizontal_sync` desempenha um papel fundamental na coordenação da varredura horizontal da tela, garantindo que os sinais de sincronização sejam gerados no momento certo para que o monitor interprete corretamente os dados que estão sendo exibidos. 
	Ele contribui para a formação da imagem geral na interface VGA.
*/
module horizontal_sync(
   clock,
   hsync,
	hcount,
	hcount_ov,	
	dat_act_h
	
	
);
	input  clock;     	//50MHz clock de entrada do sistema
	output hsync;     	//Sinal para sincronização horizontal VGA
	output [9:0] hcount;	//externa o valor do contador de varredura horizontal
	output hcount_ov;
	output dat_act_h;		//flag auxiliar para ativação de pixels
		
	wire  hcount_ov; 	//flag de estouro do contador horizontal
	wire  hsync; 		//condução de saída de horizontal vertical
	wire  dat_act_h;  //condução para flag auxiliar para ativação de pixels
	
	reg [9:0] hcount; //Contador de varredura de linha VGA
	reg vga_clk; 	   //clock do VGA

	//Tabela de parâmetros de temporização de varredura horizontal
	// VGA Signal 640 x 480 @ 60 Hz Industry standard timing
	// http://tinyvga.com/vga-timing/640x480@60Hz
	
	parameter hsync_pulse = 10'd96;
	parameter hback_porch = 10'd48;
	parameter hfront_porch= 10'd16;
	parameter hresolution = 10'd640;
	
	localparam hsync_end  = hsync_pulse;  //(95+1)/50MHz = 19.2us (pulso hsync)
	localparam hdat_begin = hsync_end + hback_porch; // resolução h = hdat_end - hdat_begin (hdat_begin = hsync_end + back_porch)
	localparam hdat_end   = hdat_begin + hresolution; // resolução h = 784-143 = 640 pixels
	localparam hpixel_end = hdat_end + hfront_porch; // total pixels h (line) = hpixel_end + 1 = hdat_end + front_porch
	
	//Geração de clock interno
	always @(posedge clock)
	begin
		vga_clk = ~vga_clk;
	end
	
	//************************VGA hsync*******************************
	//varredura horizontal de pixels    
	always @(posedge vga_clk)
	begin
		if (hcount_ov)
			hcount <= 10'd0;
		else
			hcount <= hcount + 10'd1;
		end
	assign hcount_ov = (hcount == hpixel_end);
	//--------------------------------------------

	//************************VGA saídas*******************************
	// atribuição dos sinais as respectivas saídas
	assign dat_act_h = ((hcount >= hdat_begin) && (hcount < hdat_end));
	assign hsync = (hcount > hsync_end);

	//--------------------------------------------
	

endmodule
