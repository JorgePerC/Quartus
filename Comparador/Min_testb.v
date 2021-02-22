`timescale 1ns / 1ps


module Min_testb;

	reg [7:0] A;
	reg [7:0] B;
	wire [7:0] OUT_TB;

	Min uut (
		.A(A),
		.B(B),
		.OUT(OUT_TB)
	);


initial begin 

// 1
	A = 245;
	B = 255;

	#10;
// 2
	A = 938;
	B = 100;

	#10;
// 3
	A = 10;
	B = 2;

	#10;
// 4
	A = 270;
	B = 69;

	#10;
// 5
	A = 0;
	B = 0;
end 
endmodule
