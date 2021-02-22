`timescale 1ns / 1ps

module Muxes4to1_testb;
	//Inputs DEBEN COINCIDIR CON EL QUARTUS FILE
	// TB variables to connect to DUT Inputs
	// STIMULUS Variables
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] C;
	reg [7:0] D;
	reg [1:0] S;


	wire [7:0] OUT;

// Instantiate the Unit Under TEST (UUT)
// Check file name
Muxes4to1 uut(
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.S(S),
	.OUT(OUT)
);

initial begin
	// Iniciar inputs
	A = 0;
	B = 0;
	C = 0;
	D = 0;
	S = 0;

	//Poner casos de prueba aquí 
	// Wait 100 ns for global reset to finish
	#100;
        
	// Add stimulus here
		
	A = 3;
	B = 54;
	C = 255;
	D = 100;
		
	#100;
	
	A = 3;
	B = 54;
	C = 255;
	D = 100;
	S = 1;
	
	#100;

	A = 3;
	B = 54;
	C = 255;
	D = 100;
	S = 2;

	#100;

	A = 3;
	B = 54;
	C = 255;
	D = 100;
	S = 3;

	#100;
		
	end
      
endmodule
