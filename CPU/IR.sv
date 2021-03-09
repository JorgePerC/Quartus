module IR (                         // Instruction Register
    input clk,
    input rst,                      // Set all to 0
    input logic ack_i,              // Enable to pass instruction
    input logic [17:0] inst_i,      // Actual coded instruction

    output logic [6:0] op_o,        // Bits 11-17. 7th most significant bits from instruction string. OpCode
    output logic [17:0] func_o,     // Bits 0-2 ? 
    
    output logic [11:0] addr_o,     // Still unkown 
    output logic [7:0] disp_o,
    output logic [7:0] offset_o,
    
    output logic [2:0] rd_o,        // Bits 11-13. Direction for where the result will be saved
    output logic [2:0] rs_o,        // Bits 8-10. Direction for first opperand 
    output logic [2:0] rs2_o,       // Bits 5-7. Direction for first opperand 
    
    output logic [7 :0] immed_o,    // Bits 0-7. Literal opperand value. 
    output logic [2:0] count_o
);

// Just to save entire instruction set
logic [17:0] stored_instruction;

always_ff @( posedge clk, posedge rst)
    if (rst)
        stored_instruction <= 0;
    else if (ack_i)
        stored_instruction <= inst_i;
    else
        // Do nada :)
end

// No logic to get values, simply split inst_i
rd_o = stored_instruction [13:11] 
rs_o = stored_instruction [10:8]
rs2_o = stored_instruction [7:5]

immed_o = stored_instruction [7:0]

count_o =

endmodule 
