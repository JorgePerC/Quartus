module IR (
    input logic [17:0] inst_i,

    output logic [6:0] op_o, // Bits 11-17. 7th most significant bits from instruction string
    output logic [17:0] func_o, // Bits 0-2 ? 
    
    output logic [11:0] addr_o,   //Still unkown 
    output logic [7:0] disp_o,
    output logic [7:0] offset_o,
    
    output logic [2:0] rd_o,      // Bits 11-13. Direction for where the result will be saved
    output logic [2:0] rs_o,      // Bits 8-10. Direction for first opperand 
    output logic [2:0] rs2_o,     // Bits 5-7. Direction for first opperand 
    
    output logic [7 :0] immed_o,  // Bits 0-7. Literal operand value. 
    output logic [2:0] count_o
);


// No logic to get values, simply split inst_i
rd_o = inst_i [13:11] 
rs_o = inst_i [10:8]
rs2_o = inst_i [7:5]

immed_o = inst_i [7:0]

endmodule 
