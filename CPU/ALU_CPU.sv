// #import MUX, Logical ALU, Arithmetic ALU::scope;
//'import' 

module ALU_CPU (
    input logic [7:0] rs_i,       // Input data a                   :)
    input logic [7:0] op2_i,      // Input data b                   :)
    input logic [2:0] count_i,    // Only used in shift operations  :)
    input logic carry_i,          // Carry in                       :)      

    input logic [3:0] ALU_op_i,   // Instruction selector           :)

    output logic zero_o,          // Flag is res_o = 0              :)
    output logic carry_o,         // Flag if res has carry out      :)
    output logic [7:0] res_o      // Result from operation          :)
);

logic [7:0] ALUL_out;
logic [7:0] ALUA_out;
logic [7:0] ALUS_out;

logic ALUA_c_out;
logic ALUS_c_out;

// ALU_Arithmetic instantiation
ALU_Arithmetic ALUA (
	.a(rs_i),
	.b(op2_i),
	.s(ALU_op_i[1:0]),
    .c_in(carry_i),
	
	.c_out(ALUA_c_out),
	.out(ALUA_out)	
);

// ALU_Logic instantiation
ALU_Logic ALUL (
	.a(rs_i),
	.b(op2_i),
	.s(ALU_op_i[1:0]), //Sólo los últimos dos bits del selector
	
	.out(ALUL_out)
);
ALU_Shift  ALUS (
 .a(rs_i),          // Number to shift
 .cnt(count_i),     // Bits to shift
 .s(ALU_op_i[1:0]), // Selector

 .out(ALUS_out),    // res
 .c_out(ALUS_c_out) // carry out
);
// ALU_Shift instantiation

always_comb begin

carry_o = 1'b0; // "Default" value
    case (ALU_op_i[3:2]) // Primeros dos bits del selector
        
        2'b00:
		  begin 
            // Check instructions at ALUA
            res_o = ALUA_out;
            carry_o = ALUA_c_out;
        end
		  2'b01:
            // Check instructions at ALUL
            res_o = ALUL_out;
		  2'b10:
        begin
				// Check instructions at ALUS
            res_o = ALUS_out;
            carry_o = ALUS_c_out;
        // Remaining 4 possible combinations don't matter. 
        end
		  default: 
            res_o = 8'bX;
    endcase    

    // Assign zero a value
    zero_o = ~(|res_o);
end




endmodule
