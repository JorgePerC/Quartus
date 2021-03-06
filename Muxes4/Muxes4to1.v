module Muxes4to1(
	// El nombre es case sensitive 
	
	//Entradas a mi circuito (No son variables)
	input [7:0] A,
	input [7:0] B,
	input [7:0] C,
	input [7:0] D,
	input [1:0] S,
	
	//Las variables que se ocupen en 
	//always, se les pone un reg
	output reg [7:0] OUT
);

	/*
	wire T0;
	wire T1;
	
	assign T0 = ~( (S[1] & C) | (~S[1] & A) );
	assign T1 = ~( (S[1] & D) | (~S[1] & B) );
	assign OUT = ~( (T0 | S[0]) & (T1 | ~S[0]) ); 
	*/
	
	//Una alternativa a lo que hicimos arriba es:
	
	/*
	assign OUT = (S == 2'b00) ? A:
					(S == 2'b01) ? B :
					(S == 2'b10) ? C :
					(S == 2'b11) ? D : 1'hx;
	*/
	
	//Otra alternatica es:
	
	/*
	always @(*) begin
	
	//Otra cosa que podemos hacer para evitar
	// el Latch, es ponerle un valor inicial 
	// a la variable
	OUT = A;
	
		if ( S == 0)
			OUT = A;
				else if ( S == 1)
					OUT = B;
					else if ( S == 2)
						OUT = C;
							else if ( S == 3)
								OUT = D;
								// Los Latch no son de fiar
								// Es necesario cubrir todas
								// las posibilidades de un if
								else
									OUT = 1'hx;
	
	end
	*/
	
	//La última manera de representar un MUX
	//También es la más eficiente
	
	always @(*) begin
		case (S)
		2'b00 : 
			OUT = A;
		2'h1 : //Cambiamos entre bases al comparar
			OUT = B;
		2'd2 : 
			OUT = C;
		2'b11 : 
			OUT = D;
		
		default:
			OUT = 8'hxx;
		endcase
	end
	
	endmodule
	//Es necesario un enter después de esto para que se 
	// ponga en color azul 