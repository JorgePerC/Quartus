module ALU (
	input [7:0] A,
	input [7:0] B,
	input [2:0] S, //Esta es de 3

	output reg [7:0] Out,// ALUA/ALUL 
	output Zero, 		// ALUA/ALUL
	output C_Out,		// ALUA
	output Overflow,	// ALUA
	output Negative		// ALUA 
);

wire [7:0] ALUL_out;
wire [7:0] ALUA_out; 

ALU_Logic ALUL (
	.A(A),
	.B(B),
	.S(S[1:0]), //Sólo los últimos dos bits del selector
	
	.Out(ALUL_out)
);

ALU_Arithmetic ALUA (
	.A(A),
	.B(B),
	.S(S[1:0]),
	
	.Overflow(Overflow),
	.C_Out(C_Out),
	.Negative(Negative),
	.Out(ALUA_out)
	
);



always @(*)
	begin
		//El out depende del primer bit del S
		Out = (S[2] == 1'b0) ? ALUA_out :  ALUL_out;
	end	

assign Zero = ~(|Out); //Ecuación para saber si es cero 		
	
	

endmodule
