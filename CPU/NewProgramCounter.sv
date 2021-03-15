module NewProgramCounter (

    input logic [1:0] Coper_i,            // Decode branch and branch taken, jump, misc ret, misc reti  :)
    input logic carry_i,            // No need to use in this implementation, since we simplified COper :|*
    input logic zero_i,             //                                                                  :|*

    input logic int_i,              // Interruption  :|
    input logic stk_i,              // Stack         :|

    input logic [7:0] branch_off,   // Branch offset, how many places to jump   :) Offset_i
    input logic [11:0] jump_addr,   // Direct address to jump to                :) addr_i
    input logic [11:0] current_PC,  // Actual direction of PC                   :) 

    output logic [11:0] PC_o     // Goes to memory instruction   :)
);

logic branch_taken; // Can be deleted 
logic [11:0] nxt_PC;

//always_ff @( posedge clk ) begin : blockName
    
//end


// We should add a flip flop

// Mux4 TODO: Use Mux4 module :(
// We are not using a stack, so stack related changes (return from subroutine & stack) valen madre :)
always_comb begin
    case(Coper_i)
        2'b00: // Sequential instruction
            nxt_PC = current_PC + 1;
        2'b01:  // Jump to direct addr
            nxt_PC = jump_addr;
            // jump to subroutine
        2'b10: // Return from a subroutine, enables subroutines
            nxt_PC = current_PC + 1; // This not totally correct, just to avoid errors. :)
        2'b11:  // Branch. The 4 branch instructions are basically the same, so they were simplified in 1 
            nxt_PC = current_PC + branch_off;
        default:
            nxt_PC = 'hx;
    endcase    
end

// always_ff @( posedge clk ) begin
    
// end

always_comb begin 
    PC_o = nxt_PC;
end

endmodule
