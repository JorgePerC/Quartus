// #Import MUX, PROCESSOR REGISTER
// No need to import, since all the files were overwitten

module CPU (

);

// Cables declaration
logic 

// Mux2ALU
op2_c_e = (op2_c_i) ? ina : inb;

// Mux4 
Mux4 mux2Register (
    .a(ALU_e),
	.b(data_dat_i),
	.c(port_dat_i), 
	.d('x),
	.s(RegMux_c)

	.out(summand)
);

// 1 bit register


endmodule
