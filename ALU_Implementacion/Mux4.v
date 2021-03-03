module Mux4(

	input [3:0] A,
	input [3:0] B,
	input [3:0] C,
	input [3:0] D,
	input [1:0] S,
	
	output reg [3:0] Out
);

	
	always @(*) begin
		case (S)
		2'h0 : 
			Out = A;
		2'h1 : 
			Out = B;
		2'h2 : 
			Out = C;
		2'h3 : 
			Out = D;
		
		default:
			Out = 3'hxx;
		endcase
	end
	
	endmodule
