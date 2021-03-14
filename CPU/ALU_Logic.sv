module ALU_Logic 
# (parameter width = 8)
(
	input logic [width-1 : 0] a,
	input logic [width-1 : 0] b,
	input logic [1:0] s,
	
	output logic [width-1 : 0] out

);
/* Instruction set:
	4'b01_00: // BIWISE A AND B
	4'b01_01: // BIWISE A OR B
	4'b01_10: // BIWISE A XOR B
	4'b01_11: // BIWISE A AND ~B
*/
always_comb begin
	case (s)
		2'b00:
			out = a & b;
		2'b01:
			out = a | b;
		2'b10:
			out = a ^ b;
		2'b11:
			out = a & ~b;
		default:
			out = 'hx;
	endcase
end 

endmodule 

