
module PU ( // Processing unit 
	input clk_i,		// :)
	input clkEn_i,		// :)
	input rst_i,		// :)
	input RegWrt_i,	// :)

	input [3:0] ALUOp_i,		// :)

	input [17:0] inst_dat_i,	// :)
	input inst_ack_i,			// :)
	
	input [7:0] data_dat_i,		// :)
	input [7:0] port_dat_i,		// :)
	
	input [1:0] RegMux_i,		// :)
	
	input op2_i,				// :)
	output [2:0] op_o,			// :)	// From IR, how long should it be?!!! FAKE, it should be 7
	output [2:0] func_o,		// :)

	output carry_o,				// :)
	output zero_o,				// :)
	output [11:0] addr_o,		// :)
	output [7:0] rs_o,			// :)	!!!! It's all mixed :/
	output [7:0] disp_o,		// :)
	output [7:0] offset_o		// :)
);

// Cables declaration


// IR -> Register Bank
logic [2:0] rs_e;
logic [2:0] rs2_e;
logic [2:0] rd_e;

// IR -> ALU
logic [7:0] immed_e;
logic [2:0] count_e;


//----------------------------------
// Instruction Register instantation
IR instructionRegister (
.clk(clk_i),
.rst(rst_i),
.ack_i(inst_ack_i),
.inst_i(inst_dat_i),

.op_o(op_o),			//direct output
.func_o(func_o),		//direct output
.addr_o(addr_o),		//direct output
.disp_o(disp_o),		//direct output
.offset_o(offset_o), 	//direct output
.rs_o(rs_e),
.rs2_o(rs2_e),
.rd_o(rd_e),
.immed_o(immed_e),
.count_o(count_e)

);

// Cables declaration++
//logic rs_mr_e; -> rs_o
logic [7:0] rs2_mr_e;
logic [7:0] data_mux_e; // Assigned value later on

MemoryRegister MR (
.clk(clk_i),
.clk_en(clkEn_i),
.rst(rst_i),
.wrt_en(RegWrt_c_i),
.dat_i(data_mux_e),		// Comes from mux
.rs_i(rs_e),
.rs2_i(rs2_e),
.rd_i(rd_e),

.rs_o(rs_o),			//Direct output
.rs2_o(rs2_mr_e)
);


// Even more Cables declaration

logic c_out_reg; // Register exit
logic [7:0] res_alu;
logic [7:0] ALU_e;  	// Stored res

// 2 Entry mux, AKA. Mux2ALU
logic [7:0] op2_mux_e;
always_comb begin
	 op2_mux_e = (op2_i) ? rs2_mr_e : immed_e;

end
 
// 1 bit register
BitRegister bitR (
.clk(clk_i),
.clk_en(clkEn_i),
.rst(rst_i),
.c_i(carry_o),// VERIFICAR CON DIAGRAMA
.c_o(c_out_reg) 
);

ALU_CPU alu (
	.rs_i(rs_o),
	.op2_i(op2_mux_e),
	.count_i(count_e),
	.carry_i(c_out_reg),
	.ALU_op_i(ALUOp_c_i),

	.zero_o(zero_o),		//direct output
	.carry_o(carry_o),		//direct output
	.res_o(res_alu)

);

// Register
always_ff @(posedge clk_i) begin
	ALU_e <= res_alu;
end

// Mux4 
Mux4 mux2Register (
   	.a(ALU_e),
	.b(data_dat_i),
	.c(port_dat_i), 
	.d('x),
	.s(RegMux_c_i),

	.out(data_mux_e)
);



endmodule
