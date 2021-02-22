module Mux2(
	input [7:0] A,
	input [7:0] B, 
	input S,
	
	output reg [7:0] OUT
);

always @(*)
	begin 
		case (S)
		
		1'b0: 
			OUT = B;
		
		1'b1: 
			OUT = A;
		
		default:
			OUT = 8'Bxxxxxxxx;
		endcase
		
	end

endmodule
