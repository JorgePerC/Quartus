module ALU_Arithmetic (
	input [7:0] A,
	input [7:0] B,
	input [1:0] S,
	output reg [7:0] OUT,
	output reg OVERFLOW,
	output reg C_OUT
);

reg C_In;
wire [7:0] SUMMAND;

assign complement_B = ~B; // No va +1 aquí, abajo 

// 00 -> Suma
// 01 -> Resta
// 00 -> +0 (+1)
// 00 -> +0 (+0)
Mux4 mux (
	.A(B),
	.B(complement_B),
	.C({8{1'b0}}), // Repeat 0 8 times. 
	.D({8{1'b0}}), // Can we leave blank?
	.S(S),
	
	.OUT(SUMMAND)
);



always @(*)
	begin

		C_In = S[0] ^ S[1];
	
		// Para tener el C_Out y Out y partirlos
		{C_OUT, OUT} = A + SUMMAND + C_In;
		
		OVERFLOW = (A[7]^B[7]) ? 0: (OUT[7]^A[7]); //Only if both are same will be overflow
	end


endmodule
