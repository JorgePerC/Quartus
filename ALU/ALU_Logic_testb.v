
`timescale 1ns/1ps

module ALU_LOGIC_testb;
	reg [7:0] A;
	reg [7:0] B;
	reg [1:0] S;

	wire [7:0] OUT;

ALU_Logic ALUL(
	.A(A),
	.B(B),
	.S(S),

	.OUT(OUT)
);

//00 -> AND
//01 -> OR 
//10 -> XOR
//11 -> NOT

initial begin
	A = 10;
	B = 10;
	S = 0;

#10; // Wait 10 ns 

	A = 20;
	B = 10;
	S = 1;

#10; // Wait 10 ns 

	A = 3;
	B = 5;
	S = 2;

#10; // Wait 10 ns 
	
	A = 0;
	B = 0;
	S = 3;

#10; // Wait 10 ns 

end 
endmodule