// #import MUX, Logical ALU, Arithmetic ALU::scope;
//'import' 

module ALU_CPU (
    input logic [7:0] rs_i,       // Input data a
    input logic [7:0] op2_i,      // Input data b
    input logic [2:0] count_i,    // Only used in shift operations
    input logic carry_i,          // Carry in 

    input logic [3:0] ALU_op_i,   // Instruction selector

    output logic zero_o,          // Flag is res_o = 0
    output logic carry_o,         // Flag if res has carry out
    output logic [7:0] res_o,     // Result from operation
);

logic ALUL_out;
logic ALUA_out;
logic ALUS_out;

// ALU_Arithmetic instantiation
ALU_Arithmetic ALUA (
	.a(rs_i),
	.b(op2_i),
	.s(ALU_op_i[1:0]),
	
	.Overflow(),
	.c_out(carry_o),
	.Negative(temp_Negative),
	.Out(ALUA_out)
	
);
// ALU_Logic instantiation
ALU_Logic ALUL (
	.a(rs_i),
	.b(op2_i),
	.s(ALU_op_i[1:0]), //Sólo los últimos dos bits del selector
	
	.out(ALUL_out)
);

// ALU_Shift instantiation

always_comb begin
    case (ALU_op_i)
        4'b00_00: // SUMA a+b 
        4'b00_01: // SUMA a+b+c
        4'b00_10: // RESTA a-b
        4'b00_11: // RESTA a-b-c

        4'b01_00: // BIWISE A AND B
        4'b01_01: // BIWISE A OR B
        4'b01_10: // BIWISE A XOR B
        4'b01_11: // BIWISE A AND ~B

        4'b10_00: // SHIFT A COUNT places "rd=rs << count | if count > 0 then: C = rs(8-count)"
        4'b10_01: // SHIFT A COUNT places "rd=rs >> count | if count > 0 then: C = rs(count-1)"
        4'b10_11: // SHIFT A COUNT places "rd=rs <<< count| if count> 0 then: C = rs(8-count)"
        4'b00_00: // SHIFT A COUNT places "rd=rs >>> count if count> 0 then: C = rs(count-1)"

        // Remaining 4 possible combinations don't matter. 
        default: 
            res_o = 8'bX
    endcase    
end




endmodule
