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
	temperatura,
	dig_temp,
	autor,
	musica,
	musica_atual,
   vga_r, vga_g, vga_b   
);
	input musica_atual;
	input [15:0] autor;
	input [15:0] musica;
	input [3:0] temperatura;
	input [4:1] dig_temp;
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
	
	reg [7:0] current_char;    // Register to hold the current character
	reg [3:0] char_index;      // Register to track the character index

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
			data <= dat_draw; 
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
	
		 integer j;

	
	//Lógica para gerar a saída dat_draw
	always @(posedge vga_clk)
	begin
		 localparam REF_X = 310;
		 localparam pos_m = 300;
		 localparam pos_a = 300;
		 
		 localparam temp_pos_x = 480;
		 localparam temp_pos_y = 400;
		 localparam temp_pos_offset = 20;
		 localparam pos_alunos = 170;
		 localparam pos_ed_x = 390;
		 localparam pos_autor_y = 300;
		 
		 
		 
	    draw_bg(WHITE);
		 
		 // Alunos
		 
			draw_A(pos_alunos,90, 2, RED);
			draw_L(pos_alunos+22,90, 2, RED);
			draw_U(pos_alunos+44,90, 2, RED);
			draw_N(pos_alunos+66,90, 2, RED);
			draw_O(pos_alunos+88,90, 2, RED);
			draw_S(pos_alunos+110,90, 2, RED);
			
		 // Bruno
		 
			draw_B(pos_alunos,120, 2, RED);
			draw_R(pos_alunos+22,120, 2, RED);
			draw_U(pos_alunos+44,120, 2, RED);
			draw_N(pos_alunos+66,120, 2, RED);
			draw_O(pos_alunos+88,120, 2, RED);
			
		// Gabriela
		
			draw_G(pos_alunos,150, 2, RED);
			draw_A(pos_alunos+22,150, 2, RED);
			draw_B(pos_alunos+44,150, 2, RED);
			draw_R(pos_alunos+66,150, 2, RED);
			draw_I(pos_alunos+88,150, 2, RED);
			draw_E(pos_alunos+110,150, 2, RED);
			draw_L(pos_alunos+132,150, 2, RED);
			draw_A(pos_alunos+154,150, 2, RED);
			
			// Henrique
		
			draw_H(pos_alunos,180, 2, RED);
			draw_E(pos_alunos+22,180, 2, RED);
			draw_N(pos_alunos+44,180, 2, RED);
			draw_R(pos_alunos+66,180, 2, RED);
			draw_I(pos_alunos+88,180, 2, RED);
			draw_Q(pos_alunos+110,180, 2, RED);
			draw_U(pos_alunos+132,180, 2, RED);
			draw_E(pos_alunos+154,180, 2, RED);
			
			// Pedro
		
			draw_P(pos_alunos,210, 2, RED);
			draw_E(pos_alunos+22,210, 2, RED);
			draw_D(pos_alunos+44,210, 2, RED);
			draw_R(pos_alunos+66,210, 2, RED);
			draw_O(pos_alunos+88,210, 2, RED);
			
		// Eletronica
		
			draw_E(pos_ed_x+0,90, 2, RED);
			draw_L(pos_ed_x+22,90, 2, RED);
			draw_E(pos_ed_x+44,90, 2, RED);
			draw_T(pos_ed_x+66,90, 2, RED);
			draw_R(pos_ed_x+88,90, 2, RED);
			draw_O(pos_ed_x+110,90, 2, RED);
			draw_N(pos_ed_x+132,90, 2, RED);
			draw_I(pos_ed_x+154,90, 2, RED);
			draw_C(pos_ed_x+176,90, 2, RED);
			draw_A(pos_ed_x+198,90, 2, RED);
			
			// Digital
		
			draw_D(pos_ed_x+22,120, 2, RED);
			draw_I(pos_ed_x+44,120, 2, RED);
			draw_G(pos_ed_x+66,120, 2, RED);
			draw_I(pos_ed_x+88,120, 2, RED);
			draw_T(pos_ed_x+110,120, 2, RED);
			draw_A(pos_ed_x+132,120, 2, RED);
			draw_L(pos_ed_x+154,120, 2, RED);
			
		 // Temperatura
		
			draw_T(pos_ed_x+0,pos_autor_y+60, 2, RED);
			draw_E(pos_ed_x+22,pos_autor_y+60, 2, RED);
			draw_M(pos_ed_x+44,pos_autor_y+60, 2, RED);
			draw_P(pos_ed_x+66,pos_autor_y+60, 2, RED);
			draw_E(pos_ed_x+88,pos_autor_y+60, 2, RED);
			draw_R(pos_ed_x+110,pos_autor_y+60, 2, RED);
			draw_A(pos_ed_x+132,pos_autor_y+60, 2, RED);
			draw_T(pos_ed_x+154,pos_autor_y+60, 2, RED);
			draw_U(pos_ed_x+176,pos_autor_y+60, 2, RED);
			draw_R(pos_ed_x+198,pos_autor_y+60, 2, RED);
			draw_A(pos_ed_x+220,pos_autor_y+60, 2, RED);
		 
		 if (musica_atual == 1'b0)	begin	
			draw_B(pos_alunos,pos_autor_y, 2, RED);
			draw_E(pos_alunos+22,pos_autor_y, 2, RED);
			draw_E(pos_alunos+44,pos_autor_y, 2, RED);
			draw_T(pos_alunos+66,pos_autor_y, 2, RED);
			draw_H(pos_alunos+88,pos_autor_y, 2, RED);
			draw_O(pos_alunos+110,pos_autor_y, 2, RED);
			draw_V(pos_alunos+132,pos_autor_y, 2, RED);
			draw_E(pos_alunos+154,pos_autor_y, 2, RED);
			draw_N(pos_alunos+176,pos_autor_y, 2, RED);
			
			draw_F(pos_alunos,pos_autor_y+30, 2, RED);
			draw_U(pos_alunos+22,pos_autor_y+30, 2, RED);
			draw_R(pos_alunos+44,pos_autor_y+30, 2, RED);

			draw_E(pos_alunos+88,pos_autor_y+30, 2, RED);
			draw_L(pos_alunos+110,pos_autor_y+30, 2, RED);
			draw_I(pos_alunos+132,pos_autor_y+30, 2, RED);
			draw_S(pos_alunos+154,pos_autor_y+30, 2, RED);
			draw_E(pos_alunos+176,pos_autor_y+30, 2, RED);
		 end
		 
		 if (musica_atual == 1'b1)	begin	
			draw_Y(pos_alunos,pos_autor_y, 2, RED);
			draw_I(pos_alunos+22,pos_autor_y, 2, RED);
			draw_P(pos_alunos+44,pos_autor_y, 2, RED);
			
			draw_H(pos_alunos+88,pos_autor_y, 2, RED);
			draw_A(pos_alunos+110,pos_autor_y, 2, RED);
			draw_R(pos_alunos+132,pos_autor_y, 2, RED);
			draw_B(pos_alunos+154,pos_autor_y, 2, RED);
			draw_U(pos_alunos+176,pos_autor_y, 2, RED);
			draw_R(pos_alunos+198,pos_autor_y, 2, RED);
			draw_G(pos_alunos+220,pos_autor_y, 2, RED);
			
			draw_O(pos_alunos,pos_autor_y+30, 2, RED);
			draw_V(pos_alunos+22,pos_autor_y+30, 2, RED);
			draw_E(pos_alunos+44,pos_autor_y+30, 2, RED);
			draw_R(pos_alunos+66,pos_autor_y+30, 2, RED);

			draw_T(pos_alunos+110,pos_autor_y+30, 2, RED);
			draw_H(pos_alunos+132,pos_autor_y+30, 2, RED);
			draw_E(pos_alunos+154,pos_autor_y+30, 2, RED);

			draw_R(pos_alunos+198,pos_autor_y+30, 2, RED);
			draw_A(pos_alunos+220,pos_autor_y+30, 2, RED);
			draw_I(pos_alunos+242,pos_autor_y+30, 2, RED);
			draw_N(pos_alunos+264,pos_autor_y+30, 2, RED);
			draw_B(pos_alunos+286,pos_autor_y+30, 2, RED);
			draw_O(pos_alunos+308,pos_autor_y+30, 2, RED);
			draw_W(pos_alunos+330,pos_autor_y+30, 2, RED);
		 end
			 
		 
		 case(dig_temp)
		 4'b0111: begin
				 case(temperatura) 			
					4'h0 : draw_0(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //0  
					4'h1 : draw_1(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //1  
					4'h2 : draw_2(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //2  
					4'h3 : draw_3(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //3  
					4'h4 : draw_4(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //4  
					4'h5 : draw_5(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //5  
					4'h6 : draw_6(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //6  
					4'h7 : draw_7(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //7  
					4'h8 : draw_8(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //8  
					4'h9 : draw_9(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK); //9  
					default : draw_3(temp_pos_x+temp_pos_offset*1, temp_pos_y, 2, BLACK);//0          
				endcase 
			end
			4'b1011: begin
				 case(temperatura) 			
					4'h0 : draw_0(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //0  
					4'h1 : draw_1(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //1  
					4'h2 : draw_2(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //2  
					4'h3 : draw_3(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //3  
					4'h4 : draw_4(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //4  
					4'h5 : draw_5(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //5  
					4'h6 : draw_6(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //6  
					4'h7 : draw_7(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //7  
					4'h8 : draw_8(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //8  
					4'h9 : draw_9(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK); //9   
					default : draw_3(temp_pos_x+temp_pos_offset*2, temp_pos_y, 2, BLACK);//0          
				endcase 
			end
			4'b1101: begin
				 case(temperatura) 			
					4'h0 : draw_0(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //0  
					4'h1 : draw_1(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //1  
					4'h2 : draw_2(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //2  
					4'h3 : draw_3(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //3  
					4'h4 : draw_4(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //4  
					4'h5 : draw_5(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //5  
					4'h6 : draw_6(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //6  
					4'h7 : draw_7(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //7  
					4'h8 : draw_8(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //8  
					4'h9 : draw_9(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK); //9  
					default : draw_3(temp_pos_x+temp_pos_offset*3, temp_pos_y, 2, BLACK);//0          
				endcase 
			end
			4'b1110: begin
					draw_dot(temp_pos_x+temp_pos_offset*3.8, temp_pos_y, 2, BLACK);
					draw_upper_o(temp_pos_x+temp_pos_offset*5.3, temp_pos_y, 2, BLACK);
					draw_C(temp_pos_x+temp_pos_offset*6.4, temp_pos_y, 2, BLACK);
				 case(temperatura) 			
					4'h0 : draw_0(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //0  
					4'h1 : draw_1(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //1  
					4'h2 : draw_2(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //2  
					4'h3 : draw_3(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //3  
					4'h4 : draw_4(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //4  
					4'h5 : draw_5(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //5  
					4'h6 : draw_6(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //6  
					4'h7 : draw_7(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //7  
					4'h8 : draw_8(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //8  
					4'h9 : draw_9(temp_pos_x+temp_pos_offset*4.8, temp_pos_y, 2, BLACK); //9    
					default : draw_3(temp_pos_x+temp_pos_offset*4, temp_pos_y, 2, BLACK);//0          
				endcase 
			end
		 endcase
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
	 
	task draw_A(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
        integer i;
			for(i=0; i<9; i=i+1) begin
				draw_sqr(POSX+(i*THICK)/2, (POSY+8*THICK)-i*THICK, THICK, COLOR);
			end
			
			for(i=0; i<9; i=i+1) begin
				draw_sqr(POSX+((i*THICK)/2)+((8*THICK)/2), POSY+i*THICK, THICK, COLOR);
			end
			
			for(i=0; i<8; i=i+1) begin
				draw_sqr(POSX+((i*THICK)/2)+3, POSY+6*THICK, THICK, COLOR);
			end
			
			
    end
endtask

task draw_B(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+8*THICK, THICK, COLOR);		
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+8*THICK, THICK, COLOR);		
			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+8*THICK, THICK, COLOR);		
				

				draw_sqr(POSX+4*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+3*THICK, THICK, COLOR);
			   draw_sqr(POSX+4*THICK, POSY+6*THICK, THICK, COLOR);
    end
endtask


task draw_C(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+0*THICK, THICK, COLOR);
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end

    end
endtask

task draw_D(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+8*THICK, THICK, COLOR);		
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+8*THICK, THICK, COLOR);		
			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+8*THICK, THICK, COLOR);		
				

				draw_sqr(POSX+4*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+3*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+5*THICK, THICK, COLOR);
			   draw_sqr(POSX+4*THICK, POSY+6*THICK, THICK, COLOR);
    end
endtask

task draw_E(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<8; i=i+1) begin
				draw_sqr(POSX+i*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
			

			
    end
endtask

task draw_F(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+4*THICK, THICK, COLOR);
		
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+4*THICK, THICK, COLOR);
	
			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+4*THICK, THICK, COLOR);
	
    end
endtask

task draw_G(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+8*THICK, THICK, COLOR);		
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);

				draw_sqr(POSX+2*THICK, POSY+8*THICK, THICK, COLOR);		
			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);

				draw_sqr(POSX+3*THICK, POSY+8*THICK, THICK, COLOR);
				
				draw_sqr(POSX+4*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+1*THICK, THICK, COLOR);
				
				draw_sqr(POSX+4*THICK, POSY+8*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+7*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+6*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+5*THICK, THICK, COLOR);
				

				draw_sqr(POSX+3*THICK, POSY+5*THICK, THICK, COLOR);
				
	
    end
endtask

task draw_H(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+5*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+4*THICK, THICK, COLOR);
		
		
				draw_sqr(POSX+2*THICK, POSY+4*THICK, THICK, COLOR);
	
			
				draw_sqr(POSX+3*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+4*THICK, THICK, COLOR);
	
    end
endtask

task draw_I(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+3*THICK, POSY+i*THICK, THICK, COLOR);
				end
	
    end
endtask

task draw_J(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<3; i=i+1) begin
					draw_sqr(POSX, POSY+8*THICK-i*THICK, THICK, COLOR);
				end
	
    end
endtask

task draw_K(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i, POSY+4*THICK+(i*THICK/2), THICK, COLOR);
					draw_sqr(POSX+i, POSY+4*THICK-(i*THICK/2), THICK, COLOR);
				end

	
    end
endtask

task draw_L(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
    end
endtask
 
	 
	 //TASK: Lógica para desenhar a letra M
	  task draw_M(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				draw_sqr(POSX+1*THICK, POSY+1*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+3*THICK, THICK, COLOR);				
				draw_sqr(POSX+4*THICK, POSY+3*THICK, THICK, COLOR);
				draw_sqr(POSX+5*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+6*THICK, POSY+1*THICK, THICK, COLOR);
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+7*THICK, POSY+i*THICK, THICK, COLOR);
				end
        end
    endtask
	 
	  task draw_N(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<8; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+7*THICK, POSY+i*THICK, THICK, COLOR);
				end
        end
    endtask	 
	 
	  task draw_O(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
        end
    endtask

task draw_P(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+4*THICK, THICK, COLOR);
	
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+4*THICK, THICK, COLOR);

			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+4*THICK, THICK, COLOR);
	
				draw_sqr(POSX+4*THICK, POSY+1*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+3*THICK, THICK, COLOR);

			
    end
endtask

task draw_Q(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+6*THICK, POSY+9*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+7*THICK, THICK, COLOR);
			
    end
endtask		 

task draw_R(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i, POSY+4*THICK+(i*THICK/2), THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+4*THICK, THICK, COLOR);
	
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+4*THICK, THICK, COLOR);
	
			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+4*THICK, THICK, COLOR);
				
				draw_sqr(POSX+4*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+1*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+2*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+3*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+4*THICK, THICK, COLOR);

    end
endtask

task draw_S(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+(4*THICK)+i*THICK, THICK, COLOR);
				end				
    end
endtask

task draw_T(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+3*THICK, POSY+i*THICK, THICK, COLOR);
				end			
    end
endtask

 task draw_U(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
		
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
        end
    endtask

 task draw_V(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*THICK/2, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+4*THICK+(i*THICK)/2, POSY+(8*THICK)-i*THICK, THICK, COLOR);
				end
				
        end
    endtask

 task draw_W(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+4*(THICK), POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+8*(THICK), POSY+i*THICK, THICK, COLOR);
				end

				
        end
    endtask

task draw_X(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+(8*THICK)-i*THICK, THICK, COLOR);
				end
				
        end
    endtask
	
task draw_Y(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
					integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK)/2, POSY+i*THICK/2, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK)/2+(4*THICK), POSY+(4*THICK)-i*THICK/2, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+(4*THICK), POSY+(4*THICK)+i*THICK/2, THICK, COLOR);
				end
        end
    endtask			

	 task draw_Z(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
					integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+8*THICK, THICK, COLOR);
				end
				
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+(i*THICK), POSY-(i*THICK)+(8*THICK), THICK, COLOR);
				end
        end
    endtask
	
	 task draw_1(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
					integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+4*(THICK), POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<5; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+4*THICK-i*THICK, THICK, COLOR);
				end
        end
    endtask	
	
	 task draw_2(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX, POSY+(4*THICK)+i*THICK, THICK, COLOR);
				end				
    end
endtask		
	 
task draw_3(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+5*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				draw_sqr(POSX+1*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+1*THICK, POSY+8*THICK, THICK, COLOR);		
		
				draw_sqr(POSX+2*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+2*THICK, POSY+8*THICK, THICK, COLOR);		
			
				draw_sqr(POSX+3*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+3*THICK, POSY+8*THICK, THICK, COLOR);

				draw_sqr(POSX+4*THICK, POSY+0*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+4*THICK, THICK, COLOR);
				draw_sqr(POSX+4*THICK, POSY+8*THICK, THICK, COLOR);				
    end
endtask

task draw_4(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+5*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*THICK/2, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK/2, THICK, COLOR);
				end	
    end
endtask

task draw_5(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+(4*THICK)+i*THICK, THICK, COLOR);
				end	
    end
endtask

task draw_6(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<4; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+(4*THICK)+i*THICK, THICK, COLOR);
				end	
    end
endtask

task draw_7(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK-(i*THICK), THICK, COLOR);
				end
				
    end
endtask

task draw_8(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+(8*THICK)-i*THICK, THICK, COLOR);
				end	
    end
endtask

task draw_9(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
    begin
      	integer i;		
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
			
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+4*THICK, THICK, COLOR);
				end
				
				for(i=0; i<7; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				
				for(i=0; i<5; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+(8*THICK)-i*THICK, THICK, COLOR);
				end	
    end
endtask

	  task draw_0(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX, POSY+i*THICK, THICK, COLOR);
				end

				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+6*THICK, POSY+i*THICK, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY, THICK, COLOR);
				end
				
				for(i=0; i<6; i=i+1) begin
					draw_sqr(POSX+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
        end
    endtask

task draw_upper_o(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<2; i=i+1) begin
					draw_sqr(POSX+6*THICK+i*THICK, POSY, THICK, COLOR);
				end
				for(i=0; i<2; i=i+1) begin
					draw_sqr(POSX+6*THICK+i*THICK, POSY+1*THICK, THICK, COLOR);
				end

        end
    endtask	

task draw_dot(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
				integer i;
				for(i=0; i<2; i=i+1) begin
					draw_sqr(POSX+3*THICK+i*THICK, POSY+8*THICK, THICK, COLOR);
				end
				

        end
    endtask		 	 
	 
task draw_maior_que(input [10:1] POSX, POSY, THICK, input [3:1] COLOR);
        begin
					integer i;
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+i*THICK/2, THICK, COLOR);
				end
				
				for(i=0; i<9; i=i+1) begin
					draw_sqr(POSX+i*(THICK), POSY+(8*THICK)-i*THICK/2, THICK, COLOR);
				end
				
        end
    endtask		 
	
endmodule