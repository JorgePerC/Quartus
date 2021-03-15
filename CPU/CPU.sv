
//TODO: instantiate with parameter width
module CPU (
    input logic clk_i,
    input logic clk_en_i,
    input logic rst_i,

    input logic [17:0] inst_dat_i,  // instruction 
    input logic inst_ack_i,         // instruction ack

    input logic [7:0] data_dat_i,
    input logic [7:0] port_dat_i,

    output logic data_ack_o,
    output logic [7:0] data_dat_o,
    
    output logic inst_ack_o
);

//hola 
wire [6:0] op2_c;
wire [3:0] ALUOp_c;
wire ALUEFR_c;
wire ALUEn_c;

wire RegWrt_c;

wire [1:0] RegMux_c;

wire PCEn_c;
wire [1:0] PCoper_c;
wire pop_c;
wire push_c;

wire DPMux_c;

wire ret_c; // push_c
wire jsb_c; // pop_c

wire reti_c;
wire int_c;

wire inst_stb_c;
wire inst_cyc_c;

wire port_we_c;
wire data_we_c;
wire data_stb_c;
wire data_cyc_C;

wire int_ack; // salida del CtrlUnit | int_req; // no se, entrada al CtrlUnit



CtrlUnitFSM CU(
    .clk(clk_i),
    .rst(rst_i),
    .interrupt(int_ack), // falta

    .op_i(op_e),
    .func_i(func_e),

    .inst_ack_i(inst_ack),
    .data_ack_i(data_ack_o),
    .data_cyc_o(data_cyc_C),
    .data_stb_o(data_stb_c),
    .data_we_o(data_we_c),
    .port_we_o(port_we_c),

    .port_ack_i(), // Desconectado pq no lo ocupo
    .inst_ack_o(inst_ack_o),

    .op2_o(op2_c),
    .ALUOP_o(ALUOp_c),
    .ALU_en_o(ALUEn_c),
    .RegMux_o(RegMux_c),

    .RegWrt_o(RegWrt_c),
    .PCoper_o(PCoper_c),
    .PC_en_o(PCEn_c),
    .ALUFR_o(ALUEFR_c), 

    .ret_o(ret_c),  // push
    .jsb_o(jsb_c),       //pop

    .reti_o(reti_c),
    .int_o(int_c),

    .stb_o(inst_stb_c),
    .cyc_o(inst_cyc_c)
);

wire [7:0] disp_e; // IR
wire [11:0] addr_e; // IR
wire [11:0] PC_e; //stack, intelreg, ProgramCounter
wire [11:0] PC_new_e;

NewProgramCounter NewPC (

    .Coper_i(PCoper_c),
    .carry_i(ccC_e),
    .zero_i(ccZ_e),
    
    .int_i(pc_2_NewPc),
    .stk_i(stk_e),

    .branch_off(disp_e),
    .jump_addr(addr_e),
    .current_PC(PC_e),

    .PC_o(PC_new_e)
);

wire [7:0] ALU_e;


DataMemory DataMem(
    .clk_i(clk_i),
    .cyc_i(data_cyc_C),
    .stb_i(data_stb_c),
    .we_i(data_we_c),

    .addr_i(ALU_e),
    .data_i(),      // ??

    .ack_o(data_dat_o),
    .data_o(data_ack_o)
);

wire carry_e;
wire zero_e;
wire [2:0] op_e;
wire [2:0] func_e;

PU processingUnit (
    .clk_i(clk_i),
    .clkEn_i(clk_en_i),
    .rst_i(rst_i),
    .RegWrt_i(RegWrt_c),

    .ALUOp_i(ALUOp_c),

    .inst_dat_i(inst_dat_i),
    .inst_ack_i(inst_ack_i),

    .data_dat_i(data_dat_i), // Inut desde CPU
    .port_dat_i(port_dat_i),

    .RegMux_i(RegMux_c),

    .op2_i(op2_c),
    .op_o(op_e),
    .func_o(func_e),

    .carry_o(carry_e),
    .zero_o(zero_e),
    .addr_o(addr_e),
    .rs_o(),
    .disp_o(disp_e),
    .offset_o()
);


wire ccC_e; // FlagReg
wire ccZ_e; // FlagReg

FlagReg Flagreg(
    .clk(clk_i),
    .clk_en(clk_en_i),
    .rst(rst_i),
    
    .we(ALUFR_c),
    .iwe(reti_c),

    .intz_i(intz_e),
    .intc_i(intc_e),

    .c_i(carry_e),
    .z_i(zero_e),

    .c_o(ccC_e),
    .z_o(ccZ_e)
);


wire intc_e;
wire intz_e;

wire [11:0] pc_2_NewPc;

InstructionRegister InirReg (
    .clk(clk_i),
    .clk_en(clk_en_i),
    .rst(rst_i),
    .wrt_en(int_c),

    .c_i(ccC_e),
    .z_i(ccZ_e),
    .pc_i(PC_e),

    .intc_o(intc_e),
    .intz_o(intz_e),

    .pc_o(pc_2_NewPc)
);

wire [11:0] stk_e;

Stack stack (
    .DataIO(PC_e),
    .Push(ret_c),
    .Pop(jsb_c),
    .Reset(rst_i),
    
    .Stack(),   // Desconectado
    .Full(),    // Desconectado
    .Empty(),   // Desconectado
    .Err(),     // Desconectado
    .SP(),      // Desconectado
    
    .DataR(stk_e)
);


ProgramCounter pc (
    .clk(clk_i),
    .clk_en(clk_en_i),
    .rst(rst_i),
    .wrt_en(PCEN_c),
  
    .PC_i(PC_new_e),
    .PC_o(PC_e)  
);
endmodule