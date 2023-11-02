module leds(clock, play_pause,stop,saida);
	input clock;
	//input [7:0] bot_pres;
	input play_pause;
	input stop;
	output [4:1] saida;
	//output reg [4:1] led;
	
	assign saida[1] = !stop;
	assign saida[2] = !play_pause;
	assign saida[3] = play_pause;
	assign saida[4] = !(!stop & !play_pause & play_pause);
	
endmodule
