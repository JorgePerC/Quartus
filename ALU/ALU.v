module ALU (
	input [7:0] A,
	input [7:0] B,
	input [2:0] S, //Esta es de 3

	output reg [7:0] Out,// ALUA/ALUL 
	output Zero, 		// ALUA/ALUL
	output reg C_Out,		// ALUA
	output reg Overflow,	// ALUA
	output reg Negative		// ALUA / ALUL 
);

wire [7:0] ALUL_out;
wire [7:0] ALUA_out; 
wire temp_Overflow;
wire temp_Negative;
wire temp_C_Out;

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
	
	.Overflow(temp_Overflow),
	.C_Out(temp_C_Out),
	.Negative(temp_Negative),
	.Out(ALUA_out)
	
);



always @(*)
	begin
		//El out depende del primer bit del S
		Out = (S[2] == 1'b0) ? ALUA_out :  ALUL_out;
		// Sólo aplica con las ariméticas
		Overflow = (S[2] == 1'b0) ? temp_Overflow : 0;
		C_Out = (S[2] == 1'b0) ? temp_C_Out : 0;
		Negative =  Out [7] == 1;//(S[2] == 1'b0) ? temp_Negative : 0;
	end	
assign Zero = ~(|Out); //Ecuación para saber si es cero 		

endmodule
