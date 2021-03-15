module IR (                         // Instruction Register
    input clk,
    input rst,                      // Set all to 0
    input logic ack_i,              // Enable to pass instruction
    input logic [17:0] inst_i,      // Actual coded instruction

    output logic [6:0] op_o,        // Bits 11-17. 7th most significant bits from instruction string. OpCode. FAKE!!! [2:0]
    output logic [2:0] func_o,      // Variable bits
    
    output logic [11:0] addr_o,     // Bits 0-11. Still unkown 
    output logic [7:0] disp_o,      // Bits 0-7. 
    output logic [7:0] offset_o,    // Bits 0-7. 
    
    output logic [2:0] rd_o,        // Bits 11-13. Direction for where the result will be saved
    output logic [2:0] rs_o,        // Bits 8-10. Direction for first opperand 
    output logic [2:0] rs2_o,       // Bits 5-7. Direction for first opperand 
    
    output logic [7:0] immed_o,    // Bits 0-7. Literal opperand value. 
    output logic [2:0] count_o
);

// Just to save entire instruction set
logic [17:0] stored_instruction;

always_ff @( posedge clk, posedge rst) begin
    if (rst)
        stored_instruction <= 0;
    else if (ack_i)
        stored_instruction <= inst_i;
	 //else
        // Do nada :)
end

// func_o can be found in different places, so logic is needed.
always_comb begin
	// No logic to get values, simply split inst_i
    rd_o = stored_instruction [13:11]; 
    rs_o = stored_instruction [10:8];
    rs2_o = stored_instruction [7:5];

    op_o = stored_instruction [17:11]; //FAKE!: stored_instruction [17:11]; [17:15]

    addr_o  = stored_instruction[11:0];
    disp_o  = stored_instruction[7:0];
    offset_o = stored_instruction[7:0];

    immed_o = stored_instruction [7:0];
    count_o = stored_instruction[7:5];
	
	//func_o = stored_instruction [2:0]; // FAKE!
    casez (op_o)
        7'b1110_???:
        begin
            func_o = stored_instruction [2:0];
            op_o = 3'b110; // Is this a vaiable solution?
        end
        7'b0???_???:
        begin
            func_o = stored_instruction [16:14];
            op_o = 3'b110;
        end
        7'b110?_???:
        begin
            func_o = stored_instruction [1:0];
            op_o = 3'b110;
        end
        7'b10??_???:
        begin
            func_o = stored_instruction [15:14];
            op_o = 3'b110;
        end
        7'b1111_10?:
        begin
            func_o = stored_instruction [11:10];
            op_o = 3'b110;
        end
        7'b1111_0??:
        begin
            func_o = stored_instruction [12];
            op_o = 3'b110;
        end
        7'b1111_110: 
		  begin
            func_o = stored_instruction [10:8];
            op_o = 3'b110;
		  end
        default: 
            func_o = 3'hx;
    endcase
end

endmodule 
