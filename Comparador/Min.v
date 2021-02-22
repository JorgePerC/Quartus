module Min(
	input [7:0] A,
	input [7:0] B,
	
	output [7:0] OUT

);



// Salida del comparador
wire S ;
wire [7:0] TemporalOUT;

Comparador comp(
	.A(A),
	.B(B),
	.AgtB(),
	// Las dejamos sin conectar
	.AeqB(),
	.AltB(S)
	
);

//Si a > b -> AgtB = 1
//Si a < b -> AltB = 1
//Si a = b -> AeqB = 1


Mux2 mux (
	.A(A),
	.B(B),
	.S(S),
	.OUT(OUT)
);


endmodule
