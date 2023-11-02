#Assignments para Cyclone IV EP4CE6E22C8
#------------------GLOBAL--------------------#
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

set_location_assignment	PIN_23	-to	clock
set_location_assignment	PIN_25	-to	rst_n


#---------------KEY/CKEY----------------------#
set_location_assignment	PIN_88	-to	key[1]
set_location_assignment	PIN_89	-to	key[2]
set_location_assignment	PIN_90 	-to	key[3]
set_location_assignment	PIN_91	-to	key[4]

#----------------BUZZER-----------------------#
set_location_assignment	PIN_110	-to	buzzer

#--------------------LED----------------------#
set_location_assignment	PIN_87	-to	led[1]
set_location_assignment	PIN_86	-to	led[2]
set_location_assignment	PIN_85	-to	led[3]
set_location_assignment	PIN_84	-to	led[4]

#--------------------DIG----------------------#
set_location_assignment	PIN_133	-to	dig[1]
set_location_assignment	PIN_135	-to	dig[2]
set_location_assignment	PIN_136	-to dig[3]
set_location_assignment	PIN_137	-to	dig[4]

set_location_assignment	PIN_128 -to	seg[0]
set_location_assignment	PIN_121	-to seg[1]
set_location_assignment	PIN_125	-to	seg[2]
set_location_assignment	PIN_129	-to	seg[3]
set_location_assignment	PIN_132	-to	seg[4]
set_location_assignment	PIN_126	-to seg[5]
set_location_assignment	PIN_124	-to seg[6]
set_location_assignment	PIN_127	-to seg[7]

#--------------------LCD----------------------#
set_location_assignment	PIN_141	-to	lcd_rs
set_location_assignment	PIN_138	-to	lcd_rw
set_location_assignment	PIN_143	-to lcd_en

set_location_assignment	PIN_142	-to	lcd_d[0]
set_location_assignment	PIN_1	-to	lcd_d[1]
set_location_assignment	PIN_144	-to	lcd_d[2]
set_location_assignment	PIN_3	-to	lcd_d[3]
set_location_assignment	PIN_2	-to lcd_d[4]
set_location_assignment	PIN_10	-to lcd_d[5]
set_location_assignment	PIN_7	-to lcd_d[6]
set_location_assignment	PIN_11	-to lcd_d[7]

#--------------------UART--------------------#
set_location_assignment	PIN_115	-to	rxd
set_location_assignment	PIN_114	-to	txd

#--------------------PS2----------------------#
set_location_assignment	PIN_119	-to	ps_clk
set_location_assignment	PIN_120	-to	ps_data

#--------------------IR----------------------#
set_location_assignment	PIN_100	-to	ir

#--------------------I2C----------------------#
set_location_assignment	PIN_112	-to	scl
set_location_assignment	PIN_113	-to	sda
set_location_assignment	PIN_99	-to	i2c_scl
set_location_assignment	PIN_98	-to	i2c_sda

#--------------------VGA----------------------#
set_location_assignment	PIN_101	-to	hsync
set_location_assignment	PIN_103	-to	vsync
set_location_assignment	PIN_104	-to	vga_b
set_location_assignment	PIN_105	-to	vga_g
set_location_assignment	PIN_106	-to	vga_r

#------------------SDRAM---------------------#
set_location_assignment	PIN_28	-to	S_DQ[0]
set_location_assignment	PIN_30	-to	S_DQ[1]
set_location_assignment	PIN_31	-to	S_DQ[2]
set_location_assignment	PIN_32	-to	S_DQ[3]
set_location_assignment	PIN_33	-to	S_DQ[4]
set_location_assignment	PIN_34	-to	S_DQ[5]
set_location_assignment	PIN_38	-to	S_DQ[6]
set_location_assignment	PIN_39	-to	S_DQ[7]
set_location_assignment	PIN_54	-to	S_DQ[8]
set_location_assignment	PIN_53	-to	S_DQ[9]
set_location_assignment	PIN_52	-to	S_DQ[10]
set_location_assignment	PIN_51	-to	S_DQ[11]
set_location_assignment	PIN_50	-to	S_DQ[12]
set_location_assignment	PIN_49	-to	S_DQ[13]
set_location_assignment	PIN_46	-to	S_DQ[14]
set_location_assignment	PIN_44	-to	S_DQ[15]

set_location_assignment	PIN_76	-to	S_A[0]
set_location_assignment	PIN_77	-to	S_A[1]
set_location_assignment	PIN_80	-to	S_A[2]
set_location_assignment	PIN_83	-to	S_A[3]
set_location_assignment	PIN_68	-to	S_A[4]
set_location_assignment	PIN_67	-to	S_A[5]
set_location_assignment	PIN_66	-to	S_A[6]
set_location_assignment	PIN_65	-to	S_A[7]
set_location_assignment	PIN_64	-to	S_A[8]
set_location_assignment	PIN_60	-to	S_A[9]
set_location_assignment	PIN_75	-to	S_A[10]
set_location_assignment	PIN_59	-to	S_A[11]

set_location_assignment	PIN_73	-to	S_BS[0]
set_location_assignment	PIN_74	-to	S_BS[1]
set_location_assignment	PIN_42	-to	S_DQM[0]
set_location_assignment	PIN_55	-to	S_DQM[1]

set_location_assignment	PIN_58	-to	S_CKE
set_location_assignment	PIN_43	-to	S_CLK
set_location_assignment	PIN_72	-to	S_CS
set_location_assignment	PIN_71	-to	S_RAS
set_location_assignment	PIN_70	-to	S_CAS
set_location_assignment	PIN_69	-to	S_WE

#------------------END-----------------------#





