module ALU (
	input [7:0] A,
	input [7:0] B,
	input [2:0] S, //Esta es de 3

	output reg [7:0] Out,// ALUA/ALUL 
	output reg C_Out,		// ALUA
	output reg Zero, 		// ALUA/ALUL
	output reg Overflow,	// ALUA
	output reg Negative	// ALUA/ALUL
);

wire [7:0] ALUL_out;
wire [7:0] ALUA_out; 

ALU_Logic ALUL (
	.A(A),
	.B(B),
	.S(S[1:0]), //Sólo los últimos dos bits del selector
	
	.OUT(ALUL_out)
);

ALU_Arithmetic ALUA (
	.A(A),
	.B(B),
	.S(S[1:0]),
	
	.OVERFLOW(Overflow),
	.C_OUT(C_Out),
	
	.OUT(ALUA_out)
	
);



always @(*)
	begin
		//El out depende del primer bit del S
		Out = (S[2] == 1'b0) ? ALUA_out :  ALUL_out;
	end	
	
	nor (Zero, Out); //Ecuación para saber si es cero 	
	

endmodule
