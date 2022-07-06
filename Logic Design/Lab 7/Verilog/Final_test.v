`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:29:38 05/04/2022
// Design Name:   Final
// Module Name:   C:/Users/sweet/Counter/Final_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Final
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Final_test;

	// Inputs
	reg input_ENA;
	reg input_CLK;

	// Outputs
	wire [6:0] output_Y0;
	wire [6:0] output_Y1;

	// Instantiate the Unit Under Test (UUT)
	Final uut (
		.input_ENA(input_ENA), 
		.input_CLK(input_CLK), 
		.output_Y0(output_Y0), 
		.output_Y1(output_Y1)
	);

	initial begin
		// Initialize Inputs
		// Initialize Inputs
		input_CLK = 0;input_ENA = 0;#15;
		input_CLK = 0;input_ENA = 1;#15;
		input_CLK = 0;input_ENA = 0;#15;

		forever #1 input_CLK = ~input_CLK;

	end
      
endmodule

