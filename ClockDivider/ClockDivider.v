module ClockDivider (
	input clk,
	input rst,
	output reg clk_div
);

localparam constantNumber = 3;

reg [31:0] count;

// Contador de 0 -> 50000000
always @ (posedge(clk) or posedge(rst))
begin
	// If reset, empieza en cero
	if (rst == 1'b1)
		count <= 32'b0;
	//Si llegamos al constant numer, reinicia
	else if (count == constantNumber -1)
		count <= 32'b0;
	else
		count <= count + 1;
end

always @ (posedge(clk) or posedge(rst))
begin
	//if rest empieza en cero
	if (rst == 1'b1)
		clk_div <= 1'b1;
	// cambia cuando llegamos al constant number
	else if (count == constantNumber -1)
		clk_div <= ~clk_div;
	else
		clk_div <= clk_div;


end


endmodule
