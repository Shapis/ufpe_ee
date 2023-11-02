module SEG_D_verilog (
	input clk,rst_n,
	input [15:0] data, //2bytes
	output reg [7:0] seg, //seg[7] -> dp 
	output reg [4:1] dig //seleciona display
);  
  
	reg [3:0] dataout_buf;  
	reg [1:0] disp_dat;  
	reg [16:0] delay_cnt;  
		
	//gera clk de 1kHz (sugestão: clk externo)
	always@(posedge clk,negedge rst_n) begin   
		if(!rst_n) delay_cnt <= 16'd0;  
		else if(delay_cnt == 16'd50000)  
		  delay_cnt <= 16'd0;  
		else delay_cnt<= delay_cnt + 1'b1;  
	end   
	
	/* INÍCIO: Controle do Display 7seg */
	//redefine o display ativo a cada 1ms (delay)
	always@(posedge clk,negedge rst_n) begin   
		if(!rst_n) disp_dat <= 2'd0;  
		else if (delay_cnt == 16'd50000)  
		 disp_dat <= disp_dat + 1'b1;  
		else disp_dat <= disp_dat;  
	end  	
	//seleciona o display a ser ativo	
	always@(disp_dat) begin   
		case(disp_dat)  
			2'b00: dig = 4'b1110; //habilita o display 4
			2'b01: dig = 4'b1101; //habilita o display 3
			2'b10: dig = 4'b1011; //habilita o display 2
			2'b11: dig = 4'b0111;	//habilita o display 1
			default dig = 4'b1111;//todos desabilitados
		endcase   	  
	end  
	// Decoder BCD7seg (sugestão: decoder externo)
	always@(dataout_buf, dig)	begin 
		case(dataout_buf) 			
			4'h0 : seg[6:0] = 7'b1000000; //0  
			4'h1 : seg[6:0] = 7'b1111001; //1  
			4'h2 : seg[6:0] = 7'b0100100; //2  
			4'h3 : seg[6:0] = 7'b0110000; //3  
			4'h4 : seg[6:0] = 7'b0011001; //4  
			4'h5 : seg[6:0] = 7'b0010010; //5  
			4'h6 : seg[6:0] = 7'b0000010; //6  
			4'h7 : seg[6:0] = 7'b1111000; //7  
			4'h8 : seg[6:0] = 7'b0000000; //8  
			4'h9 : seg[6:0] = 7'b0010000; //9   
			default : seg[6:0] = 7'b1000000;//0          
		endcase 	
		if (dig == 4'b1101) //Unidade da temperatura
			seg[7] = 1'b0; // dp ativo	para dig unidade
		else seg[7] = 1'b1; //dp inativo demais digs		 
	end
	/* FIM: Controle do Display 7seg */
	
	/* INICIO: MSB+LSB 9bits para 4BCD  */	
	always@(dig, data) begin
		case(dig)
			//dado display 4 (decimal da temperatura)			
			//data[7] decimal da temperatura (0 ->.0º, 1->.5º)
			4'b1110:  dataout_buf = data[7] ? 4'h5 : 4'h0;		  			
			//dado display 3 (unidade da temperatura)	
			4'b1101: begin //data[15:8] MSB+LSB da temperatura, data[15] sinal (0 -> +, 1-> -)
				if (data[15]) dataout_buf = 4'd0; //caso temp negativa valor exibido 0
				else
					if (data[14:8] >= 10 && data[14:8] < 20) dataout_buf = data[14:8] - 7'd10;
					else if	(data[14:8] >= 20 && data[14:8] < 30) dataout_buf = data[14:8] - 7'd20;
					else if	(data[14:8] >= 30 && data[15:8] < 40) dataout_buf = data[14:8] - 7'd30;
					else if	(data[14:8] >= 40 && data[15:8] < 50) dataout_buf = data[14:8] - 7'd40;
					else if	(data[14:8] >= 50 && data[15:8] < 60) dataout_buf = data[14:8] - 7'd50;
					else if	(data[14:8] >= 60 && data[15:8] < 70) dataout_buf = data[14:8] - 7'd60;
					else if	(data[14:8] >= 70 && data[15:8] < 80) dataout_buf = data[14:8] - 7'd70;
					else if	(data[14:8] >= 80 && data[15:8] < 90) dataout_buf = data[14:8] - 7'd80;
					else if	(data[14:8] >= 90 && data[15:8] < 100) dataout_buf = data[14:8] - 7'd90;
					else if	(data[14:8] >= 100 && data[15:8] < 110) dataout_buf = data[14:8] - 7'd100;
					else if	(data[14:8] >= 110 && data[15:8] < 120) dataout_buf = data[14:8] - 7'd110;
					else if	(data[14:8] >= 120) dataout_buf = data[14:8] - 7'd120;
					else dataout_buf = data[11:8]; //apenas unidade		
			end
			//dado display 2 (dezena da temperatura)
			4'b1011: begin //data[15:8] MSB+LSB da temperatura, data[15] sinal (0 -> +, 1-> -) 
				if (data[15]) dataout_buf = 4'd0; //caso temp negativa valor exibido 0
				else
					if (data[14:8] >= 10 && data[14:8] < 20) dataout_buf = 4'h1;
					else if	(data[14:8] >= 20 && data[14:8] < 30) dataout_buf = 4'h2;
					else if	(data[14:8] >= 30 && data[14:8] < 40) dataout_buf = 4'h3;
					else if	(data[14:8] >= 40 && data[14:8] < 50) dataout_buf = 4'h4;
					else if	(data[14:8] >= 50 && data[14:8] < 60) dataout_buf = 4'h5;
					else if	(data[14:8] >= 60 && data[14:8] < 70) dataout_buf = 4'h6;
					else if	(data[14:8] >= 70 && data[14:8] < 80) dataout_buf = 4'h7;
					else if	(data[14:8] >= 80 && data[14:8] < 90) dataout_buf = 4'h8;
					else if	(data[14:8] >= 90 && data[14:8] < 100) dataout_buf = 4'h9;
					else if	(data[14:8] >= 110 && data[14:8] < 120) dataout_buf = 4'h1;
					else if	(data[14:8] >= 120) dataout_buf <= 4'h2;
					else dataout_buf <= 4'b0;//dezena zero					
			end 
			//dado display 1	(centena da temperatura)			
			4'b0111: begin //data[15:8] MSB+LSB da temperatura, data[15] sinal (0 -> +, 1-> -) 
				if (data[15]) dataout_buf = 4'd0; //caso temp negativa valor exibido 0
				else dataout_buf = (data[14:8] >= 100) ? 4'h1 : 4'h0;	
			end	
			default : dataout_buf = 4'b0;   
		endcase   
	end 
	/* INICIO: MSB+LSB 9bits para 4BCD  */	
	
endmodule   
