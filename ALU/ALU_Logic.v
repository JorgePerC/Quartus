module ALU_Logic(
	input [7:0] A,
	input [7:0] B,
	input [1:0] S,
	
	output reg [7:0] OUT

);

wire [7:0] AND;
wire [7:0] OR;
wire [7:0] XOR;
wire [7:0] NOT;

assign AND = A & B;
assign OR = A | B;
assign XOR = A ^ B;
assign NOT = ~A;

always @(*) begin
	case (S)
		2'b00:
			OUT = AND;
		2'b01:
			OUT = OR;
		2'b10:
			OUT = XOR;
		2'b11:
			OUT = NOT;
		default:
			OUT = 8'hx;
	endcase
end 

endmodule 
