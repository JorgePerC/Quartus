`timescale 1ns / 1ps

module CtrlUnitFSM_TB;
	
	reg logic clk,                      // :)
   	reg logic rst,                      // :)
    reg logic interrupt,                // To enable interruptions -- int_req?

    reg logic [6:0] op_i,               // 7 bits input. OpCode     :)
    reg logic [2:0] func_i,

    reg logic logic inst_ack_i,

    reg logic data_ack_i,               // Data acknowledgement. 0 when it need to access data. 1 else
    wire logic data_cyc_o,              // 
    wire logic data_stb_o,              // ^ Both set to 1 if read    
    wire logic data_we_o, 
    
    wire logic port_we_o,

    reg logic port_ack_i,               // :)

    wire logic inst_ack_o,

    wire logic op2_o,                   // 1 bit output. Goes 2 Mux, determines if inmmed or register :)
    wire logic [3:0] ALUOP_o,           // 4 bit output. ALUOP_c :|. Operation selector
    wire logic ALUFR_c,                 // 1 bit output. ALUOP_c :|
    wire logic ALU_en_o,                // 1 bit output. ALUEN_o :|
    
    wire logic RegWrt_o,                // :)
    wire logic [1:0] RegMux_c_o,        // For ALU operations :)
    

    wire logic [3:0] PCoper_o,          // 4 bit output. Program counter operation *decode* LD :|
    wire logic PC_en_o,  :|

    // Branch
    wire logic ret_o,                   // pop_o ret_o
    wire logic jsb_o,                   // push_c
    
    wire logic DPMux_o,

    // Interrupt 
    wire logic reti_o,                  // 1 bit output. Return from interrupt.   :|
    wire logic int_o,                   // int_o. Interruption acknowledgement?   :|

    // IR instrucitons
    wire logic stb_o,                   //  :)
    wire logic cyc_o,                   //  :)

    CtrlUnitFSM CUFSM(
        .clk(clk),
        .rst(rst),
        .interrupt(interrupt),
        .op_i(op_i),
        .func_i(func_i),
        .data_ack_i(data_ack_i),
        .data_cyc_o(data_cyc_o),
        .data_stb_o(data_stb_o),
        .data_we_o(data_we_o),
        .port_we_o(port_we_o),
        .port_ack_i(port_ack_i)
        .inst_ack_i(inst_ack_i),
        .inst_data_i(inst_data_i),
        .port_ack_o(port_ack_o),
        .inst_ack_o(inst_ack_o),
        .op2_o(op2_o),
        .ALUOP_o(ALUOP_o),
        .ALU_en_o(ALU_en_o),
        .RegMux_c_o(RegMux_c_o),
        .RegWrt_o(RegWrt_o),
        .PCoper_o(PCoper_o),
        .PC_en_o(PC_en_o),
        .ALUFR_c(ALUFR_c),
        .ret_o(ret_o),
        .jsb_o(jsb_o),

        .DPMux_o(DPMux_o),

        .stb_o(stb_o),
        .cyc_o(cyc_o)
    )
