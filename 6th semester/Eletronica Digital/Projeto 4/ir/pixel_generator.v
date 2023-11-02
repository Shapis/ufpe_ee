/*
Autor: Malki-çedheq Benjamim
Disciplina: Eletrônica Digital 1A
Descrição: Modulo para geração de pixel para interface VGA
Referência: 
	https://web.mit.edu/6.111/www/labkit/vga.shtml
	http://tinyvga.com/vga-timing/640x480@60Hz

Detalhamento:

	O módulo `pixel_generator` é uma parte crucial da interface VGA, responsável por gerar os sinais de cor que serão enviados para o monitor ou tela. Ele cria diferentes padrões de cores e imagens na tela, baseados em contadores de varredura vertical e horizontal, bem como nas chaves de entrada `key`.
	
	1. **Entradas:**
		- `clock`: O sinal de clock do sistema.
		- `dat_act_h`: Sinal de ativação de pixels horizontal (vem do módulo de sincronização horizontal).
		- `dat_act_v`: Sinal de ativação de pixels vertical (vem do módulo de sincronização vertical).
		- `hcount`: Contador de varredura horizontal (número da coluna atual).
		- `vcount`: Contador de varredura vertical (número da linha atual).
		- `key`: Chaves de entrada que definem o padrão de cores a ser exibido.
		
	2. **Saídas:**
		- `vga_r`, `vga_g`, `vga_b`: Sinais de cores vermelha, verde e azul, respectivamente, que serão enviados para o monitor.
		
	3. **Variáveis e Sinais Internos:**
		- `disp_RGB`: Sinal interno para armazenar os valores das cores a serem enviados para o monitor.
		- `data`: Registrador para armazenar os dados das cores a serem exibidas.
		- `h_dat` e `v_dat`: Registradores para controlar as cores das barras horizontais e verticais.
		- `dat_cruz` e `dat_char`: Registradores para controlar cores específicas em posições específicas da tela.
		- `vga_clk`: Sinal de clock interno para sincronização.
		
	4. **Constantes de Cores:**
		- Definem as constantes para as diferentes cores, como preto, vermelho, verde, etc.
		
	5. **Lógica de Geração de Clock Interno:**
		- Gera um sinal de clock interno `vga_clk` com uma frequência de 25 MHz para sincronização.
		
	6. **Lógica de Saída VGA:**
		- Os sinais `dat_act_h` e `dat_act_v` são usados para ativar os pixels apenas quando a varredura horizontal e vertical estiver ocorrendo.
		- O sinal `disp_RGB` é preenchido com os valores de cor apropriados com base nos padrões e posições.
		- Os sinais de cores `vga_r`, `vga_g` e `vga_b` são definidos de acordo com os valores presentes em `disp_RGB`.
		
	7. **Lógica de Geração de Cores:**
		- Diferentes lógicas são implementadas para gerar cores em diferentes partes da tela com base nos contadores de varredura horizontal e vertical.
		- Padrões de cores incluem barras de cores horizontais e verticais, um tabuleiro colorido e cruzes.

O módulo `pixel_generator` é fundamental para criar as imagens e cores na tela VGA, e suas saídas são as cores que serão exibidas no monitor. A combinação dessas saídas cria diferentes padrões visuais e imagens na tela.
*/
module pixel_generator(
   clock,   
	dat_act_h,
	dat_act_v,
	hcount,
   vcount,
	key,
   vga_r, vga_g, vga_b   
);
	input clock;     	//50MHz clock de entrada do sistema
	input dat_act_h;		//flag auxiliar para ativação de pixels (horizontal)
	input dat_act_v;		//flag auxiliar para ativação de pixels (vertical)
	input [9:0] hcount;	//valor do contador de varredura horizontal
	input [9:0] vcount;	//valor do contador de varredura vertical
	input  [2:1] key;  	//conexão com chaves/botes da placa
	output vga_r, vga_g, vga_b;    //Saída de dados VGA

	wire [2:0] disp_RGB; //net para condução dos dados VGA a saída RGB

	reg [2:0] data;      //registrador para dados VGA
	reg [2:0] h_dat;     //registrador para posição horizontal
	reg [2:0] v_dat;     //registrador para posição vertical
	reg [2:0] dat_draw;  //registrador para ...

	wire  dat_act;			//condução para ativação dos pixels
	reg   vga_clk; 	   //clock do VGA

	// CONSTANTES: Cores
	localparam BLACK 	= 3'h0; 	// Preto
	localparam RED   	= 3'h1; 	// Vermelho
	localparam GREEN 	= 3'h2; 	// Verde
	localparam YELLOW	= 3'h3; 	// Amarelo
	localparam BLUE	= 3'h4; 	// Azul
	localparam MAGENTA= 3'h5;  //Magenta
	localparam CYAN  	= 3'h6;  //Ciano
	localparam WHITE 	= 3'h7; 	// Branco
	
	// CONSTANTES: Central da tela
	localparam CENTER_X = 455;
	localparam CENTER_Y = 283;
	
	// CONSTANTES: Dimensão de caracteres
	localparam CHAR_WIDTH = 2;
	localparam CHAR_HEIGHT = 3;

   //******************Geração de clock interno***********************
	always @(posedge clock)
	begin
		vga_clk = ~vga_clk;
	end
	//--------------------------------------------

	//************************VGA saídas*******************************
	// atribuição dos sinais às respectivas saídas
	assign dat_act = dat_act_h && dat_act_v;
	assign disp_RGB = (dat_act) ?  data : 3'h00;     
	assign vga_r = disp_RGB[0];
	assign vga_g = disp_RGB[1];
	assign vga_b = disp_RGB[2];
	//--------------------------------------------
	
	//************************VGA EXIBIÇÃO*******************************

	// Lógica para escolha do que será exibido na tela
	always @(posedge vga_clk)
	L1 : begin
		case(key[2:1])
			2'd0: data <= h_dat;      // exibe barra de cores horizontal
			2'd1: data <= v_dat;      // exibe barra de cores vertical
			2'd2: data <= (v_dat ^ h_dat); //exibe tabuleiro colorido
			2'd3: data <= dat_draw;
			default: data <= WHITE; //limpa tela
		endcase
	end

	///Lógica para gerar a saída barras de cores horizontais
	always @(posedge vga_clk)  
	L2: begin

		if(hcount < 223)
			v_dat <= WHITE;   	//Branco 
		else if(hcount < 303)
			v_dat <= CYAN;   		//Ciano
		else if(hcount < 383)
			v_dat <= MAGENTA;   	//Magenta
		else if(hcount < 463)
			v_dat <= BLUE;   		//Azul
		else if(hcount < 543)
			v_dat <= YELLOW;   	//Amarelo
		else if(hcount < 623)
			v_dat <= GREEN;   	//Verde
		else if(hcount < 703)
			v_dat <= RED;   		//Vermelho
		else 
			v_dat <= BLACK;   	//Preto
	end

	//Lógica para gerar a saída barras de cores verticais
	always @(posedge vga_clk)
	L3: begin
		if(vcount < 94)
			h_dat <= WHITE;   	//Branco
		else if(vcount < 154)
			h_dat <= CYAN;   		//Ciano
		else if(vcount < 214) 
			h_dat <= MAGENTA;   	//Magenta
		else if(vcount < 274)
			h_dat <= BLUE;   		//Azul
		else if(vcount < 334)
			h_dat <= YELLOW;   	//Amarelo
		else if(vcount < 394)
			h_dat <= GREEN;   	//Verde
		else if(vcount < 454)
			h_dat <= RED;   		//Vermelho
		else 	
			h_dat <= BLACK;   	//Preto
	end
	
	//Lógica para gerar a saída dat_draw
	always @(posedge vga_clk)
	begin
		 localparam REF_X = 310;
		 localparam pos_m = 300;
		 
	    draw_bg(WHITE);
		 
		 draw_cross(REF_X, CENTER_Y, 300, 5, RED);
		 draw_cross(CENTER_X, CENTER_Y, 10, 2, BLACK);
		 
		 draw_elipse(CENTER_X+2, CENTER_Y, 60, 2, MAGENTA);
		 		 
		 draw_sqr(REF_X+80-5, CENTER_Y+40+5, 20, BLACK); //sombra
		 draw_sqr(REF_X+80, CENTER_Y+40, 20, BLUE);
		 
		 draw_sqr(REF_X+80-5, CENTER_Y-95-5, 20, BLACK); //sombra
		 draw_sqr(REF_X+80, CENTER_Y-95, 20, CYAN);
		 
		 draw_sqr(REF_X+180+5, CENTER_Y+40+5, 20, BLACK); //sombra
		 draw_sqr(REF_X+180, CENTER_Y+40, 20, YELLOW);
		 
		 draw_sqr(REF_X+180+5, CENTER_Y-95-5, 20, BLACK);//sombra
		 draw_sqr(REF_X+180, CENTER_Y-95, 20, GREEN);
		 
		 draw_elipse(CENTER_X+2, CENTER_Y, 100, 2, MAGENTA);
		 		
		 //draw_M(pos_m+2, pos_m+2, 2, BLACK);//sombra
		 draw_A(pos_m, pos_m, 2, RED);
		
	end
	
	//TASK: Lógica para desenhar background
	task draw_bg(input [3:1] COLOR);
    begin
        if (vcount >= 0 && vcount < 480 && hcount >= 0 && hcount < 640) 
				dat_draw <= COLOR;  
    end
	endtask	
	
	
	//TASK: Lógica para desenhar um quadrado (preenchido)
	task draw_sqr (input [10:1] POSX, POSY, WIDTH, input [3:1] COLOR);
    begin
		if (vcount >= POSY && vcount < POSY+WIDTH*CHAR_HEIGHT && hcount >= POSX && hcount < POSX+WIDTH*CHAR_WIDTH) 
				dat_draw <= COLOR;            
    end
	endtask
	
	//TASK: Lógica para desenhar uma cruz
	task draw_cross (input [10:1] POSX, POSY, WIDHT, THICK, input [3:1] COLOR);
   begin
		if (vcount >= POSY && vcount < POSY + THICK &&
				hcount >= POSX && hcount < POSX + WIDHT) 
				dat_draw <= COLOR;
		else if (vcount >= POSY - WIDHT/2 && vcount < POSY + WIDHT/2 &&
					hcount >= POSX + WIDHT/2 - THICK/2 && hcount < POSX + WIDHT/2 + THICK/2) 
				dat_draw <= COLOR;
   end
	endtask
	
	//TASK: Lógica para desenhar uma elipse
    task draw_elipse (input [10:1] CENTER_X, CENTER_Y, RADIUS, THICK,input [3:1] COLOR);
	  begin
			integer dx, dy, distance;
			dx = hcount - CENTER_X;
			dy = vcount - CENTER_Y;
			distance = dx * dx + dy * dy;
			
			if (dat_act && distance >= (RADIUS - THICK/2)**2 && distance <= (RADIUS + THICK/2)**2)
				 dat_draw <= COLOR;
	  end
    endtask
	 
	 //TASK: Lógica para desenhar a letra A
	  task draw_A(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX+i*THICK/2, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX+7-i*THICK/2, POSY+i*THICK, THICK, COLOR);
				end
        end
    endtask
	 
	 //TASK: Lógica para desenhar a letra M
	  task draw_M(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				draw_sqr(POSX+1*THICK, POSY+1*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+3*THICK, THICK, COLOR);				
				draw_sqr(POSX+4*THICK, POSY+3*THICK, THICK, COLOR);
				draw_sqr(POSX+5*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+6*THICK, POSY+1*THICK, THICK, COLOR);
				
				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX+7*THICK, POSY+i*THICK, THICK, COLOR);
				end
        end
    endtask
	 
	
endmodule
