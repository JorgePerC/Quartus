module ALU_Arithmetic (
	input [7:0] A,
	input [7:0] B,
	input [1:0] S,
	output [7:0] Out,
	output C_Out,
	output reg Negative,
	output reg Overflow
);

reg C_In;
wire [7:0] SUMMAND;

// 00 -> Suma
// 01 -> Resta
// 00 -> +0 (+1)
// 00 -> +0 (+0)

Mux4 mux (
	.A(B),
	.B(~B),
	.C({8{1'b0}}), // Repeat 0 8 times. 
	.D({8{1'b0}}), // Can we leave blank?
	.S(S),
	
	.Out(SUMMAND)
);

always @(*) begin
		// Para tener el C_Out y Out y partirlos
		C_In = S[0] ^ S[1];

end

	
Adder suma (
.A(A),
.B(SUMMAND),
.C_In(C_In), // Repeat 
.Out(Out),
.C_Out(C_Out)
);	


always @(*)
	
	begin
		Negative = Out[7]; //También hay que saber si hubo resta o no :)	
		Overflow = (SUMMAND[7]^A[7]) ? 0 : (Out[7]^A[7]) ;//( {C_Out, Out[7]} == 2'b01); //Only if both are same will be overflow
		
	end



endmodule

