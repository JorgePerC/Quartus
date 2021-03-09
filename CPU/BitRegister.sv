module BitRegister (
    input clk,
    input clk_en,
    input logic rst,
    input logic c_1,      // Stored bit

    output logic c_o
);

always_ff @(posedge clk, posedge clk_en)
    if (rst)
        c_o <= 0;
    else
        c_o <= c_1
end

endmodule
