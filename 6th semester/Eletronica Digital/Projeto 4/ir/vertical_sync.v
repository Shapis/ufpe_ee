/*
Autor: Malki-çedheq Benjamim
Disciplina: Eletrônica Digital 1A
Descrição: Módulo para sincronização vertical da interface VGA
Referência: 
	https://web.mit.edu/6.111/www/labkit/vga.shtml
	http://tinyvga.com/vga-timing
	
Detalhamento:

	O módulo `vertical_sync` é responsável por gerar os sinais de sincronização vertical necessários para a interface VGA. Esses sinais controlam a posição vertical da varredura da tela e garantem que as linhas sejam exibidas em sequência correta. O módulo trabalha em conjunto com o módulo de sincronização horizontal (`horizontal_sync`) e o gerador de pixels (`pixel_generator`) para formar a base da interface VGA completa.

	1. **Entradas:**
		- `clock`: O sinal de clock do sistema.
		- `hcount_ov`: Sinal que indica o estouro do contador de varredura horizontal a partir do módulo `horizontal_sync`.
		
	2. **Saídas:**
		- `vsync`: Sinal de sincronização vertical que indica o início de um novo quadro (frame) na tela.
		- `vcount`: Contador de varredura vertical que representa a posição atual da varredura na coluna.
		- `dat_act_v`: Sinal de ativação de pixels vertical, que é usado para ativar os pixels apenas durante a varredura ativa da coluna.
		
	3. **Parâmetros e Constantes:**
		- Os parâmetros definem os valores de temporização da varredura vertical, como o tempo de duração do pulso de sincronização vertical, a largura do pórtico de trás e da frente, e a resolução vertical da tela.
		
	4. **Variáveis e Sinais Internos:**
		- `vcount`: Registrador para armazenar o valor atual da varredura vertical.
		- `vga_clk`: Sinal de clock interno para sincronização.
		
	5. **Lógica de Geração de Clock Interno:**
		- Gera um sinal de clock interno `vga_clk` com uma frequência de 25 MHz para sincronização.
		
	6. **Lógica de Contagem de Varredura Vertical:**
		- O contador de varredura vertical `vcount` é incrementado a cada ciclo de clock, representando a posição atual da varredura na coluna.
		- O sinal `hcount_ov` do módulo `horizontal_sync` é usado para indicar o estouro do contador horizontal e iniciar uma nova linha na tela.
		
	7. **Lógica de Sincronização Vertical:**
		- O sinal `vsync` é ativado no início de cada novo quadro (frame) e mantido alto durante o pulso de sincronização vertical.
		- O sinal `dat_act_v` é definido para ativar os pixels apenas durante a varredura ativa da coluna.
		
	8. **Definição da Resolução Vertical:**
		- Os parâmetros de temporização definem os limites da varredura vertical, como o início e o fim do quadro, os pórticos de trás e de frente, e assim por diante.

	O módulo `vertical_sync` desempenha um papel crucial na coordenação da varredura vertical da tela, assegurando que os sinais de sincronização sejam gerados no momento certo para que o monitor interprete corretamente as linhas que estão sendo exibidas. 
	Ele contribui para a formação da imagem geral na interface VGA.
*/
module vertical_sync(
   clock,
	hcount_ov,
   vsync,
	vcount,
	dat_act_v
);
	input  clock;     	//50MHz clock de entrada do sistema
	input hcount_ov;  	//flag de overflow do módulo de sincronização horizontal
	output vsync;     	//Sinal para sincronização vertical VGA
	output [9:0] vcount;	//externa o valor do contador de varredura vertical
	output dat_act_v;		//flag auxiliar para ativação de pixels

	wire  vcount_ov; 	//flag de estouro do contador vertical
	wire  vsync; 		//condução de saída de sincronização vertical
	wire  dat_act_v;  //condução para flag auxiliar para ativação de pixels

	reg [9:0] vcount; //Contador de varredura de coluna VGA
	reg   vga_clk; 	//clock do VGA

	//Tabela de parâmetros de temporização de varredura horizontal
	// VGA Signal 640 x 480 @ 60 Hz Industry standard timing
	// http://tinyvga.com/vga-timing/640x480@60Hz
	
	parameter vsync_pulse = 10'd2; 	
	parameter vback_porch = 10'd31; 	
	parameter vfront_porch= 10'd11; 
	parameter vresolution = 10'd480; 
	
	localparam vsync_end  = vsync_pulse;   // (1+1)/50MHz = 40.0ns (pulso vsync)
	localparam vdat_begin = vsync_end + vback_porch;  // resolução v = vdat_end - vdat_begin (vdat_begin = back_porch)
	localparam vdat_end   = vdat_begin + vresolution; // resolução v = 514(+1)-33(+1) = 480 pixels	
	localparam vline_end  = vdat_end + vfront_porch; // total pixels v (frame) = vline_end + 1 = vdat_end + front_porch

	//Geração de clock interno
	always @(posedge clock)
	begin
		vga_clk = ~vga_clk;
	end

	//************************VGA vsync*******************************
	//varredura de coluna -----------------------
	always @(posedge vga_clk)
	begin
		if (hcount_ov)
		begin
			if (vcount_ov)
			vcount <= 10'd0;
		else
			vcount <= vcount + 10'd1;
		end
	end
	assign  vcount_ov = (vcount == vline_end);
	//--------------------------------------------

	//************************VGA saídas*******************************
	// atribuição dos sinais as respectivas saídas
	assign dat_act_v = ((vcount >= vdat_begin) && (vcount < vdat_end));
	assign vsync = (vcount > vsync_end);
	//--------------------------------------------

	

endmodule
