module ProcessorRegister (
    
    input logic clk,                // Sincronize FF
    input logic clk_en,             // Clock enable
    input logic rst,                // Set all to 0
    input logic wrt_en,             // Write enable
    
    input logic [7:0] dat_i,        // Data to save 

    input logic [3:0] rs_i,         // Memory address to read data
    input logic [3:0] rs2_i,        // Memory address 2 to read data
    input logic [3:0] rd_i,         // Memory address to write data

    output logic [7:0] rs_o,        // Data from address rs_i
    output logic [7:0] rs2_o        // Data from address rs2_i

);

//Memory bank
logic [7:0] Mem [7:0]; // 8 registers x 8 bits
logic rs_o_stored;
logic rs2_o_stored;


integer i; //Variable for loop

// Write in memory bank
always_ff @((posedge clk and posedge clk_en) or posedge rst) begin 
    if (rst)   
        // Iterate over registers and set all of them to 0
        for (i = 0; i < 8; i++) begin
            Mem[i] <= 0;            
        end
    else if (wrt_en)
        Mem[rd_i] <= dat_i;  // Save data on memory address
end

// Read from memory bank
// Save into rs_o_stored register

always_ff @(posedge clk) begin 
    rs_o_stored <= Mem [rs_i]; // Output data is data stored at address
    
    rs2_o_stored <= Mem [rs2_i];
end


always_comb begin
    // If valid addres, give back data, else 'z
    rs_o = rs_i ? rs_o_stored : 'z;
    rs2_o = rs2_i ? rs2_o_stored : 'z;
    
end

endmodule

