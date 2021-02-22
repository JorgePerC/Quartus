
`timescale 1ns/1ps

module ALU_Arithmetic_testb;

	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] S;

	wire[7:0] OUT;
	wire OVERFLOW;

ALU_Arithmetic ALUA (
	.A(A),
	.B(B),
	.S(S),
	
	.OUT(OUT),
	.OVERFLOW(OVERFLOW)
);

initial begin

	A = 1;
	B = 5;
	S = 0;
	// No overflow, suma
#10; // Wait 10 ns 

	A = 5;
	B = 6;
	S = 0;
	// Sí overflow, suma
#10; // Wait 10 ns 

	A = 4;
	B = 1;
	S = 1;
	// No overflow, resta
#10; // Wait 10 ns 

	A = 1;
	B = 5;
	S = 1;
	// No overflow, resta
#10; // Wait 10 ns 

	A = 4;
	B = 4;
	S = 2;
	// No overflow, +1
#10; // Wait 10 ns 

	A = 7;
	B = 0;
	S = 2;
	// Overflow, +1
#10; // Wait 10 ns 

	A = 3;
	B = 1;
	S = 3;
	// No overflow, 0
#10; // Wait 10 ns 

	A = 5;
	B = 7;
	S = 3;
	// No overflow, 0
#10; // Wait 10 ns 

end
endmodule




	