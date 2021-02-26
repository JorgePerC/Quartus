module Adder (
    input [7:0] A,
    input [7:0] B,
    input C_In,
    output reg [7:0] Out,
    output reg C_Out
    );

always @(*) begin
    {C_Out, Out} = A + B + C_In;
end


endmodule
