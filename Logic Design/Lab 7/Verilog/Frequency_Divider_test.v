`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:44:30 05/03/2022
// Design Name:   Frequency_Divider
// Module Name:   C:/Users/sweet/Counter/Frequency_Divider_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Frequency_Divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Frequency_Divider_test;

	// Inputs
	reg input_CLK;
	reg input_ENA;

	// Outputs
	wire output_CLK;

	// Instantiate the Unit Under Test (UUT)
	Frequency_Divider uut (
		.input_CLK(input_CLK), 
		.input_ENA(input_ENA), 
		.output_CLK(output_CLK)
	);

	initial begin
		// Initialize Inputs
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 0;input_ENA = 1;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		forever #10 input_CLK = ~input_CLK;
		
	end
      
endmodule

