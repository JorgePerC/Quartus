`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:17:08 04/10/2015
// Design Name:   counter
// Module Name:   C:/Verilog/counter/counter_tb.v
// Project Name:  counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	// Inputs
	reg clk;
	reg rst;
	reg en;
	reg ld;
	reg [7:0] din;

	// Outputs
	wire [7:0] count;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.clk(clk), 
		.rst(rst), 
		.en(en),
		.ld(ld),
		.din(din),
		.count(count)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		en = 1;
		ld = 0; 
		din =0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;  // turning off the reset
		
		#30;
		en = 0;
		
		#40;
		en = 1;
        
		// Add stimulus here

	end
	
	initial begin
		forever #5 clk = ~clk; 
	end
      
endmodule

