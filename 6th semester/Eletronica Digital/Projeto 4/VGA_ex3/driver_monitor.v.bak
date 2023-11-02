module driver_monitor(input clock, input temperature, input autor, input musica, output vga_r, output vga_g, output vga_b, output hsync, output vsync);

wire wire_hcount;
wire wire_vcount;
wire wire_hcount_ov;
wire wire_dat_act_h;
wire wire_dat_act_v;


horizontal_sync hsync_inst(
	.clock(clock),
   .hsync(hsync),
	.hcount(wire_hcount),
	.hcount_ov(wire_hcount_ov),	
	.dat_act_h(wire_dat_act_h)
);


vertical_sync vsync_inst(
   .clock(clock),
	.hcount_ov(wire_hcount_ov),
   .vsync(vsync),
	.vcount(wire_vcount),
	.dat_act_v(wire_dat_act_v)
);

pixel_generator pixel_generator_inst(
   .clock(clock),   
	.dat_act_h(wire_dat_act_h),
	.dat_act_v(wire_dat_act_v),
	.hcount(wire_hcount),
   .vcount(wire_vcount),
   .vga_r(vga_r), 
	.vga_g(vga_g), 
	.vga_b(vga_b)   
);
	 
endmodule