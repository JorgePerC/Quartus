module ALU_Logic 
# (parameter width = 8)
(
	input logic [width-1 : 0] a,
	input logic [width-1 : 0] b,
	input logic [1:0] s,
	
	output logic [width-1 : 0] out

);
// TODO: CHECK WITH NEW INSTRUCTION SET
always_comb begin
	case (s)
		2'b00:
			out = a & b;;
		2'b01:
			out = a | b;
		2'b10:
			out = a ^ b;
		2'b11:
			out = ~a;
		default:
			out = width'hx;
	endcase
end 

endmodule 

