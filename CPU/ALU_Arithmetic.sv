module ALU_Arithmetic
# (parameter width = 8)
(
	input logic [width-1 : 0] a,
	input logic [width-1 : 0] b,
	input logic [1:0] s,
	input logic c_in,

	output logic [width-1 : 0] out,
	output logic c_out
	// No neg, neither overflow
);


logic [width-1 : 0] summand;
logic temp_c_in; //Temporal Cin

// Nuevas instrucciones :)

// 4'b00_00: // SUMA a+b 
// 4'b00_01: // SUMA a+b+c
// 4'b00_10: // RESTA a-b
// 4'b00_11: // RESTA a-b-c

always_comb begin
	// Based on coding meaning
	summand = s[1] ? ~b : b;
	case (s)
		2'b00:
			temp_c_in = 1'b0;
		2'b01:
			temp_c_in = c_in;
		2'b10:
			temp_c_in = 1'b1;
		2'b11:
			temp_c_in = ~c_in;
		default: 
			temp_c_in = c_in;
	endcase

end
	
Adder suma (
.a(a),
.b(summand),
.c_in(temp_c_in), 
.out(out),
.c_out(c_out)
);	


endmodule

