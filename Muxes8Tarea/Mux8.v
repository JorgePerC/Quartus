module Mux8 (

	input [7:0] A,
	input [7:0] B,
	input [7:0] C,
	input [7:0] D,
	input [7:0] E,
	input [7:0] F,
	input [7:0] G,
	input [7:0] H,
	
	input [2:0] S,
	
	output [7:0] OUT
	//output reg [7:0] OUT

);

	
	// !!! - Recuerda quitar el reg a output -!!!
	assign OUT = (S == 3'b000) ? A:
					(S == 3'b001) ? B:
					(S == 3'b010) ? C:
					(S == 3'b011) ? D:
					(S == 3'b100) ? E:
					(S == 3'b101) ? F:
					(S == 3'b110) ? G:
					(S == 3'b111) ? H: 1'hx; //Es como un undefined?
		
	
	
	/*
	// !!! - Recuerda añadir el reg a output -!!!
	always @(*) begin
		case(S)
		3'b000:
			OUT = A;
		3'b001:
			OUT = B;
		3'b010:
			OUT = C;
		3'b011:
			OUT = D;
		3'b100:
			OUT = E;
		3'b101:
			OUT = F;
		3'b110:
			OUT = G;
		3'b111:
			OUT = H;
		default:
			OUT = 1'hx;
		endcase 
	end
	*/
	
endmodule

