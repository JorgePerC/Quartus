module ALU_Shift 
# (parameter width = 8, parameter cnt_width = 3)
(
input logic [width-1 : 0] a,        // Number to shift
input logic [cnt_width-1 : 0] cnt,  // Bits to shift
input logic [1 : 0] s,                      // Selector

output logic [width-1 : 0] out,     // res
output logic co                     // ??
);

always_comb begin 		
    case (s)		// This implements a 4 to 1 Mux 
        2'b00: 
            {co,s} =  {1'b0, a} << cnt;  // Shiftleft by Cnt times; last bit shifted past 8 bit boundary captured as Carry
        2'b01: 
            {s,co} =  {a, 1'b0} >> cnt;  // Shiftright by Cnt times; last bit shifted past 8 bit boundary captured as Carry
        2'b10: 
            begin
                s  = (a << cnt) | (a >> ( (width) - cnt));   // Rotate left by Cnt times by combining opposite parallel Shl Shr
                co = s[0];
            end
        2'b11: 
            begin 
                s  = (a >> cnt) | (a << ( (width) - cnt));  // Rotate right by Cnt times by combining opposite parallel Shl Shr
                co = s[width-1];
            end
        default: {co, s} =  {1'b0, a} << cnt;
    endcase
end

/* ORIGINAL:
	always_comb begin 		
		case ({y,z})		// This implements a 4 to 1 Mux 
			2'b00: {Co,S} =  {1'b0,A} << Cnt;  // Shiftleft by Cnt times; last bit shifted past 8 bit boundary captured as Carry
			2'b01: {S,Co} =  {A,1'b0} >> Cnt;  // Shiftright by Cnt times; last bit shifted past 8 bit boundary captured as Carry
			2'b10: begin
						   S  = (A << Cnt) | (A >> (8 - Cnt));   // Rotate left by Cnt times by combining opposite parallel Shl Shr
							Co = S[0];
					 end
			2'b11: begin 
							S  = (A >> Cnt) | (A << (8 - Cnt));  // Rotate right by Cnt times by combining opposite parallel Shl Shr
							Co = S[7];
					 end
			default: {Co,S} =  {1'b0,A} << Cnt;
		endcase
	end
*/

/* TODO: don't use prof's implementation
Mux4 mux (
	.a(b),
	.b(~b),
	.c({width{1'b0}}), // Repeat 0 8 times. 
	.d({width{1'b0}}), // Can we leave blank?
	.d({y,z}),
	
	.out(out)
);
*/
endmodule
