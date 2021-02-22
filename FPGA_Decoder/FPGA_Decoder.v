module FPGA_Decoder ( 
output [0: 3] Out,
input A, B,
enable
);
assign Out[0] =!((!A) && (!B) && (!enable)),
       Out[1] = !((!A) && (B) && (!enable)),
       Out[2] = !(A && (!B) && (!enable)),
       Out[3] = !((A && B && (!enable)));
endmodule
