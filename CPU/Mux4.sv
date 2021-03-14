module Mux4 
# (parameter width = 8)
(
    input logic [width-1: 0] a,
    input logic [width-1: 0] b,
    input logic [width-1: 0] c,
    input logic [width-1: 0] d,
    input logic [1: 0] s,

    output logic [width-1: 0] out

);

always_comb begin
    case(s)
        2'b00:
            out = a;
        2'b01:
            out = b;
        2'b10:
            out = c;
        2'b11:
            out = d;
        default:
            out = 'bx;
    endcase
end

endmodule
