module ALU_Imp (
    input [2:0] A, // Switch 0-2
    input [2:0] B, // Switch 3-5
    input [2:0] S, // Switch 6-8

    output Zero, 		    // Led0
	 output C_Out,		// Led1
	 output Overflow,	// Led2
	 output Negative,	// Led3
    output [7:0] outSalidas // Salida a 7 segmentos
);

wire [2:0] temp_Out;

ALU alu (
	.A(A),
	.B(B),
	.S(S),
	
	.Out(temp_Out),
	.Zero(Zero),
	.C_Out(C_Out),
	.Overflow(Overflow),
	.Negative(Negative)
);


Display7S Dis1(
    .bi_Num({1'b0,temp_Out}),
    .segments(outSalidas)
);



endmodule
