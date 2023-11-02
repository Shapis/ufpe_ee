module leds(clock, play_pause,stop,saida);
	input clock;
	//input [7:0] bot_pres;
	input play_pause;
	input stop;
	output reg [4:1] saida = 4'b1101;
	//output reg [4:1] led;
	
//	reg play;
//	reg stop;
//	integer estado = 0;
	
	
	
//	always@(posedge clock)
//	begin
//		if (stop) saida = 4'b1110;
//		else if (!play_pause) saida = 4'b1101;
//		else if (play_pause) saida = 4'b1011;
//		//else if ((stop) & (play_pause) & (!play_pause)) saida = 4'b0111;
//		else saida = 4'b1111;
//	end
	
	
//	always@(posedge clock)
//	begin
//		case(bot_pres)
//			8'b01: begin
//						play <= !play;
//				end
//			8'b11: begin
//						play <= 1'b0;
//						stop <= !stop;
//					 end
//			default: begin
//							saida[1] <= !stop;
//							saida[2] <= play;
//							saida[3] <= !saida[2];
//						end
//		endcase
//	end

	always @(posedge clock)
	begin
		if (play_pause) saida[2] <= !play_pause;
		else if (!play_pause) saida[3] <= !saida[2];
		else if (stop) saida[1] <= !stop;
		else saida[4] <= !((!play_pause)&(play_pause)&(!stop));
	end


	
	

//	assign led[1] = !stop;
//	assign led[2] = !play_pause;
//	assign led[3] = play_pause;
//	assign led[4] = !(!stop & !play_pause & play_pause);
	
	
endmodule
