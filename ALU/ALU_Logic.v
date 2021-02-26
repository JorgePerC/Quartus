module ALU_Logic(
	input [7:0] A,
	input [7:0] B,
	input [1:0] S,
	
	output reg [7:0] Out

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
			Out = AND;
		2'b01:
			Out = OR;
		2'b10:
			Out = XOR;
		2'b11:
			Out = NOT;
		default:
			Out = 8'hx;
	endcase
end 

endmodule 
