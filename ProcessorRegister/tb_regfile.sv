`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:22:49 09/06/2014
// Design Name:   regfileII
// Module Name:   C:/Verilog/regfile/tb_regfile.v
// Project Name:  regfile
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regfileII
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_regfile;

	// Inputs
	logic clk;
	logic [7:0] W_data;
	logic [2:0] W_addr;
	logic 		W_en;
	logic [2:0] R_addr;
	logic [2:0] R2_addr;

	// Outputs
	logic [7:0] R_data;
	logic [7:0] R2_data;

	// Instantiate the Unit Under Test (UUT)
	ProcessorRegister uut (
		.Clk_i(clk), 
		.ClkEn_e (1'b1),
		.Rst_i (1'b0),
		.RegWrt_c(W_en),
		.Dat_i(W_data), // ->?
		.Rs_i
		.Rs2_i
		.Rd_i(W_addr), 
		.Rs_o
		.Rs2_o
		
 
		.R_addr(R_addr), 
		.R_en(R_en), 
		.R_data(R_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		W_data = 0;
		W_addr = 0;
		W_en = 0;
		R_addr = 0;
		R_en = 0;

		// Wait 100 ns for global reset to finish
		#20;

		W_data = 8'hFF;
		W_addr = 0;
		W_en = 1;
		R_addr = 0;
		R_en = 0;

		#10;
		W_data = 8'hFE;
		W_addr = 1;
		
		#10;
		W_data = 8'hAA;
		W_addr = 2;
		
		#5;
		R_addr = 1;
		R_en = 1;
		
		#5;
		W_data = 8'h5A;
		W_addr = 15;
		
		#10;
		R_addr = 15;
		R_en = 0;
		
		#10;
		R_addr = 15;
		R_en = 1;
		
		#5;
		W_en = 0;
		
	
		
		// Add stimulus here

	end
      
	initial begin
	
		forever #5 clk = ~clk;
	end

endmodule

