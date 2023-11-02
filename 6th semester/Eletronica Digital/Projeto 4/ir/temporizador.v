module temporizador 
(
	output Q = 1'b0,
	input Clk,
	input Disparo,
	input [27:0] Overflow
);
	reg [27:0] cnt = 0;
	
	always @(posedge Clk)	 
	begin
		if ((Disparo) && (cnt == 0)) 
			cnt <= Overflow;
		else if ((!Disparo) && (cnt == 0)) cnt <= 0;
		else cnt <= cnt - 1'b1;
	end
	
	assign Q = (cnt != 0) ? 1'b1 : 1'b0;

endmodule
