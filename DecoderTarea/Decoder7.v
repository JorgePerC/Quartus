module Decoder7(
	input A,
	input B,
	input C,
	
	//output reg [7:0]FINAL_OUT
	output [7:0]FINAL_OUT
);



assign FINAL_OUT[7] = (A & B & C);
// and (FINAL_OUT[0], A, B, C);
// Hay alguna manera de hacerlo con
// 3 fors?

assign FINAL_OUT[6] = (A & B & ~C);
assign FINAL_OUT[5] = (A & ~B & C);
assign FINAL_OUT[4] = (A & ~B & ~C);
assign FINAL_OUT[3] = (~A & B & C);
assign FINAL_OUT[2] = (~A & B & ~C);
assign FINAL_OUT[1] = (~A & ~B & C);
assign FINAL_OUT[0] = (~A & ~B & ~C);

 


/*
//https://www.chipverify.com/verilog/verilog-concatenation
wire [2:0] CONCAT;
assign CONCAT = {A, B, C};


always @(*)
begin
	case (CONCAT)
	3'h0 :  FINAL_OUT = 8'b0000_0001;
	3'h1 :  FINAL_OUT = 8'b0000_0010;
	3'h2 :  FINAL_OUT = 8'b0000_0100;
	3'h3 :  FINAL_OUT = 8'b0000_1000;
	3'h4 :  FINAL_OUT = 8'b0001_0000;
	3'h5 :  FINAL_OUT = 8'b0010_0000;
	3'h6 :  FINAL_OUT = 8'b0100_0000;
	3'h7 :  FINAL_OUT = 8'b1000_0000;	
	
	default: FINAL_OUT = 1'hx;
	endcase
end
*/

endmodule 
