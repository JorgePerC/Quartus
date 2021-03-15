module ProgramCounter (
    input logic clk, 
    input logic clk_en,
    input logic rst,
    input logic wrt_en,

    input logic [11:0] PC_i,
    output logic [11:0] PC_o
);

always_ff @( posedge clk, posedge clk_en, posedge rst, posedge wrt_en) begin
    if (rst)
        PC_o <= 'b0;
    else if (wrt_en)
        PC_o <= PC_i;
    
end
    
endmodule