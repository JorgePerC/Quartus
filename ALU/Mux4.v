module Mux4(

	input [7:0] A,
	input [7:0] B,
	input [7:0] C,
	input [7:0] D,
	input [1:0] S,
	
	output reg [7:0] Out
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
			Out = 8'hxx;
		endcase
	end
	
	endmodule
