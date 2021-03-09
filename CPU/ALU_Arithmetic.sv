module ALU_Arithmetic
# (parameter width = 8)
(
	input logic [width-1 : 0] a,
	input logic [width-1 : 0] b,
	input logic [1:0] s,
	input logic c_in,

	output logic [width-1 : 0] out,
	output logic c_out,
	output logic negative,
	output logic overflow
);

logic c_in;
logic [width-1 : 0] summand;

// TODO: Verificar con nuevas instrucciones :)
// 00 -> Suma
// 01 -> Resta
// 00 -> +0 (+1)
// 00 -> +0 (+0)

Mux4 mux (
	.a(b),
	.b(~b),
	.c({width{1'b0}}), // Repeat 0 8 times. 
	.d({width{1'b0}}), // Can we leave blank?
	.s(s),
	
	.out(summand)
);

always_comb begin
		// Para tener el c_out y out y partirlos
		c_in = s[0] ^ s[1];

end

	
Adder suma (
.a(a),
.a(summand),
.c_in(c_in), // Repeat 
.out(out),
.c_out(c_out)
);	

always_comb begin
	
    negative = out[width-1] ; //También hay que saber si hubo resta o no :)	
    overflow = (summand[width-1] ^ A[width-1]) ? 0 : (out[width-1] ^ A[width-1]) ; //Only if both are same will be overflow
		
end



endmodule

