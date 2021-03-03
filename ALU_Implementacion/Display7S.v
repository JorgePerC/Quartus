module Display7S (

input [3:0] bi_Num,
output reg [7:0] segments

);

always @(*) begin
    case (bi_Num)
        4'b0000:
            segments = ~8'b0011_1111; // 0 
        4'b0001:
            segments = ~8'b0000_0110; // 1
        4'b0010:
            segments = ~8'b0101_1011; // 2
        4'b0011:
            segments = ~8'b0100_1111; // 3
        4'b0100:
            segments = ~8'b0110_0110; // 4
        4'b0101:
            segments = ~8'b0110_1101; // 5
        4'b0110:
            segments = ~8'b0111_1101; // 6
        4'b0111:
            segments = ~8'b0000_0111; // 7 
        4'b1000: 
            segments = ~8'b0111_1111; // 8 
        4'b1001: 
            segments = ~8'b0110_0111; // 9
        4'b1010: 
            segments = ~8'b0100_0000; // -
        4'b1011: 
            segments = ~8'b1000_0000; // .  
    endcase
end

endmodule
