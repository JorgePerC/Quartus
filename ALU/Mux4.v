module Mux4(

	input [7:0] A,
	input [7:0] B,
	input [7:0] C,
	input [7:0] D,
	input [1:0] S,
	
	output reg [7:0] OUT
);

	
	always @(*) begin
		case (S)
		2'h0 : 
			OUT = A;
		2'h1 : 
			OUT = B;
		2'h2 : 
			OUT = C;
		2'h3 : 
			OUT = D;
		
		default:
			OUT = 8'hxx;
		endcase
	end
	
	endmodule
