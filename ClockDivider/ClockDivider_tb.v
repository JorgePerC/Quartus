module ClockDivider_tb;
    //Inputs
    reg clk;
    reg rst;

    // Output
    wire clk_div;

    ClockDivider uut (
        .clk(clk),
        .rst(rst),

        .clk_div(clk_div)
    );


    initial begin
        // Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#500;
		rst = 0;  
		
		#30;
		rst = 0; 
		
		#40;
		rst = 0;
    end

    initial begin
        forever #5 clk = ~clk;
    end

endmodule