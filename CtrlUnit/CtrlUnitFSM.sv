module CtrlUnitFSM (
    // For flip-flops
    input logic clk,        // :)
    input logic rst,        // :)
    input logic interrupt, // To enable interruptions -- int_req?

    // Inputs Diagram Leonel 
    input logic [6:0] op_i,     // 7 bits input. OpCode     :)
    input logic [2:0] func_i,   // 3 bits input. Func code  :)
    
    input logic inst_ack_i,       // :)

    // Data memmory instructions
    input logic data_ack_i,     // Data acknowledgement. 0 when it need to access data. 1 else :)
    output logic data_cyc_o,    //                          :)
    output logic data_stb_o,    // ^ Both set to 1 if read  :)  
    output logic data_we_o,     // 0 if read                :)
    // output data_dat_i        // address to access data. Passes it to data_dat_i as 1
    // Once information is written, data cyc, stb and we, are 0
    output logic port_we_o,     // :)

	input logic port_ack_i,     // :)

    output logic inst_ack_o,    // :)
    // ----------------------------------------------
    // ALU
    output logic op2_o,             // 1 bit output. Goes 2 Mux, determines if inmmed or register :)
    output logic [3:0] ALUOP_o,     // 4 bit output. ALUOP_c. Operation selector :)
    output logic ALU_en_o,          // 1 bit output. ALUEN_o :|
    output logic [1:0] RegMux_c_o,  // For ALU operations. Mux connected to dat_i in ALU :|


    output logic RegWrt_o,          // :)
    // Program counter
    output logic [3:0] PCoper_o,    // 4 bit output. Program counter operation *decode* LD :|
    output logic PC_en_o,           // :|
    output logic ALUFR_c,           // 1 bit output.  :|

    // Branch
    output logic ret_o,         // pop_o ret_o      :|
    // Jump
    output logic jsb_o,         // push_c           :)
    
    output logic DPMux_o,

    // Interrupt 
    output logic reti_o,        // 1 bit output. Return from interrupt.   :)
    output logic int_o,         // int_o. Interruption acknowledgement?   :)

    // IR instrucitons
    output logic stb_o,  //  :)
    output logic cyc_o  //  :)
);

// Flip-flops
logic [2:0] act_state;   //   :)
logic [2:0] nxt_state;   //   :)

//States. Diagrama de la página 709
parameter fetch_state = 3'b000;
    // Initital state upon reset
    // Read memory instruction bus
    // Check condition to change state
parameter decode_state = 3'b001;
    // Decodes instruction at the instruction register
    // Fetches register operands
    // Computes next PC (program counter) = branch, jump and return.
        // Completes execution if no wait Y stby 
    // Wait y stby it remains in dececode_state until an interrupt is pending 
parameter int_state = 3'b010;        // Interrupt 
    // Acknowledge a pending instruction
    // Asserts inc_ack for one cycle in this state. 

parameter execute_state = 3'b011;
    // ALU computes addres or arithmetical/logical result
    // If non-memory-I/O instructions, the state machine then transitions 
        // to write_back_state to update the register file.
    // Check timins*
    // All ALUA operations modify Z (zero) and C (Carry out, in add our sub)
     /*
    For memory-I/O instructions, a fast memory or I/O controller may be able to complete the 
    operation in the same cycle as that in which the address is calculated. If so, it asserts 
    its acknowledge signal in that cycle, and the state machine transitions to write_back_state 
    (for ldm and inp instructions, requiring a register to be updated), to int_state (for stm and out instructions if an interrupt is 
    pending), or back to fetch_state otherwise. A slower memory or I/O controller, on the other
    hand, requires one or more extra cycles, so it leaves its acknowledge signal negated. In
    that case, the state machine transitions to mem_state.
    */
parameter mem_state = 3'b100;
    // Waits for an ack_signal to be asserted
    // Transition it's sta similarly to execute
parameter write_back_state = 3'b101;
    // Updates register file from result from ALU, ldm or inp instruction

// Declaration 
logic branch;       // :)
logic jump;         // :)
logic misc;         // :)
logic mem;          // :)
logic alul_immed;   // :) logical/arithmetic alu is inmmed
logic alu_reg;      // :)
logic shift;        // :)

logic stm;          // :)
logic ldm;          // :)
logic inp;          // :)
logic out;          // :)

logic stby;         // :)
logic wait_;        // :)

	 
always_comb begin
    // Input FSM Diagram from book
    branch = (op_i[6:1] == 6'b111_110);
    jump = (op_i[6:2] == 5'b11_110); 
    misc = (op_i == 7'b1_111_110); 
    mem = (op_i[6:5] == 2'b10);
    alul_immed = (op_i[6] == 1'b0);
    alu_reg = (op_i[6:3] == 4'b1_110);
    shift = (op_i[6:4] == 3'b110);

    // Memory functions 
    stm = (func_i[1:0] == 2'b01);         // store memory 
    ldm = (func_i[1:0] == 2'b00);         // Load memory -> read in memory
    inp = (func_i[1:0] == 2'b10);         // input
    out = (func_i[1:0] == 2'b11);
    
    // Misc funcions
    stby = (func_i == 3'b101);          // Standby
    wait_ = (func_i == 3'b100);         // Wait
end

// FSM State interaction
always_comb begin
    case(act_state)
        fetch_state: 
            nxt_state = (inst_ack_i) ? decode_state : fetch_state; 
        
        decode_state:
            if ((branch & interrupt) | (jump & interrupt) | (misc & interrupt))
                nxt_state = int_state;
            else if (misc & (wait_ | stby) & ~interrupt)
                nxt_state = decode_state;
            else if ((branch & ~interrupt) | (jump & ~interrupt) | (misc & ( wait_ | stby) & ~interrupt))
                nxt_state = fetch_state;
            else begin
                // alu_immed, alu_reg shift, mem
                nxt_state = execute_state;
            end
        int_state:
            nxt_state = fetch_state;    
        execute_state:
        if ( (mem & stm & data_ack_i & interrupt) | (mem & out & port_ack_i & interrupt) ) 
            nxt_state = int_state;
        else if ((mem & stm & data_ack_i & ~interrupt) | (mem & out & port_ack_i & ~interrupt))
            nxt_state = fetch_state;
        else if ((mem & (ldm | stm) & ~data_ack_i) |(mem & (inp | out) & ~port_ack_i))
            nxt_state = mem_state;
        else begin 
            // mem & ldm & data_ack_i
            // mem & inp & port_ack_i
            // ~mem
            nxt_state = write_back_state;
        end
        mem_state:
        if (((ldm | stm) & ~ data_ack_i) | ((inp | out) & ~port_ack_i) ) 
            nxt_state = mem_state;    
        else begin 
            // ldm & data_ack_i
            // ino & port_ack_i
            nxt_state = write_back_state;
        end
        write_back_state:
            if (interrupt)
                nxt_state = int_state;
            else
                nxt_state = fetch_state;
        default:
            nxt_state = 3'bx;
    endcase
    
end

// Save state
always_ff @( posedge clk ) begin
    if (rst)
        act_state <= fetch_state;
    else
        act_state <=  nxt_state;
end

always_comb begin 
    inst_ack_o = (act_state == int_state) ? 1 : 0;
    RegWrt_o = (act_state == write_back_state);
    
    //ALU
    op2_o = (alul_immed);
    ALU_en_o = (alu_reg | shift);
    ALUOP_o = (act_state == execute_state) ? alu_reg : 'h0;
    //RegMux_c_o = ();
    ALUFR_c = ( (act_state == write_back_state) | (act_state == execute_state));
    
    // Program counter
    //PC_en_o = (branch | jump );
    //DPMux_o =

    // Memory
    data_cyc_o = ((act_state == mem_state) & ( stm | ldm));     // 
    data_stb_o = ((act_state == mem_state) & ( stm | ldm));     // ^ Only to read memory
    data_we_o = ((act_state == mem_state) & stm);       // 1 if store memory 
    port_we_o = ((act_state == mem_state) & out);       // Save input data

    // Interruption
    reti_o  = (misc & (func_i == 3'b001));
    int_o = (misc & (func_i == 3'b010));

    // Branch 
    ret_o = (misc & (func_i == 3'b000));
    // Jump
    jsb_o = (jump & func_i[2] == 1); // 1 or 0?

    // IR instrucitons
    stb_o = (act_state == fetch_state);
    cyc_o = (act_state == fetch_state);
end

always_comb begin 
    if (jump)
        PCoper_o = 4'b100;
    else if (branch)
        PCoper_o = 4'b0100;
    else if (misc & (func_i == 3'b000))
        PCoper_o = 4'b1010;
	 else
		PCoper_o = 4'b0000;
end


endmodule 

