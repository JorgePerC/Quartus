module Adder 
# (parameter width = 8)
(
    input logic [width-1 : 0] a,
    input logic [width-1 : 0] b,
    input logic c_in,
    output logic [width-1 : 0] out,
    output logic c_out
    );

// TODO: CHECK IF NEED MODIFICATIONS
always_comb begin  
    {c_out, out} = a + b + c_in;
end

endmodule
