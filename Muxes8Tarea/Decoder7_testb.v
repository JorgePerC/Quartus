`timescale 1ns / 1ps

module Decoder7_test;

	reg A;
	reg B;
	reg C;

	wire [7:0] FINAL_OUT;

	Decoder7 uut (
		.A(A),
		.B(B),
		.C(C),
		.FINAL_OUT (FINAL_OUT)
	);

initial begin 
// 1
A = 0;
	B = 0;
	C = 1;

	#10;
// 2
A = 0;
	B = 1;
	C = 0;

	#10;
// 3
A = 0;
	B = 1;
	C = 1;

	#10;
// 4
A = 0;
	B = 0;
	C = 0;

	#10;
// 5
A = 1;
	B = 0;
	C = 0;

	#10;
// 6
A = 1;
	B = 0;
	C = 1;

	#10;
// 7
A = 1;
	B = 1;
	C = 0;

	#10;
// 8
A = 0;
	B = 1;
	C = 0;

	#10;
// 9
A = 1;
	B = 0;
	C = 0;

	#10;
// 10
A = 1;
	B = 1;
	C = 1;

	#10;

end
endmodule
