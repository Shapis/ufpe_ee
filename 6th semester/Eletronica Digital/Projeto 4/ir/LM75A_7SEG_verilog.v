module LM75A_7SEG_verilog(
	input clock, rst_n, 	
	output scl, 	
	inout sda,
	output[4:1] dig,  
	output[7:0] seg
);
	wire[15:0] data;
	I2C_READ_verilog I2C_READ(
		.clk(clock),
		.rst_n(rst_n),
		.scl(scl),
		.sda(sda),
		.data(data) 
	);
	SEG_D_verilog  SEG_D(
		.clk(clock),
		.rst_n(rst_n),
		.dig(dig),
		.seg(seg),
		.data(data)
	);
endmodule
