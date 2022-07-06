`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:46:10 05/02/2022
// Design Name:   Full_Counter
// Module Name:   C:/Users/sweet/Counter/Full_Counter_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Full_Counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Full_Counter_test;

	// Inputs
	reg input_CLK;
	reg input_ENA;

	// Bidirs
	wire [3:0] output_Y1;
	wire [3:0] output_Y0;

	// Instantiate the Unit Under Test (UUT)
	Full_Counter uut (
		.input_CLK(input_CLK), 
		.input_ENA(input_ENA), 
		.output_Y1(output_Y1), 
		.output_Y0(output_Y0)
	);

	initial begin
		// Initialize Inputs
		input_CLK = 0;input_ENA = 0;#5;
		input_CLK = 0;input_ENA = 1;#5;
		input_CLK = 0;input_ENA = 0;#5;

		forever #10 input_CLK = ~input_CLK;

	end
      
endmodule

