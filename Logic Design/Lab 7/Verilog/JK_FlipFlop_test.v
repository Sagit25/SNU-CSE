`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:21:54 05/02/2022
// Design Name:   JK_FlipFlop
// Module Name:   C:/Users/sweet/Counter/JK_FlipFlop_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: JK_FlipFlop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module JK_FlipFlop_test;

	// Inputs
	reg input_J;
	reg input_K;
	reg input_CLK;
	reg input_ENA;

	// Instantiate the Unit Under Test (UUT)
	JK_FlipFlop uut (
		.input_J(input_J), 
		.input_K(input_K), 
		.input_CLK(input_CLK), 
		.input_ENA(input_ENA), 
		.output_QH(output_QH), 
		.output_QL(output_QL)
	);

	initial begin
		// Initialize Inputs
		input_J = 0;input_K = 0;input_CLK=0;input_ENA=0;#45;
		input_ENA=1;#10;
		input_ENA=0;#45;
		
		input_J = 1;input_K = 0;input_CLK=0;#45;
		input_J = 1;input_K = 0;input_CLK=1;#10;
		input_J = 1;input_K = 0;input_CLK=0;#45;
		
		input_J = 1;input_K = 1;input_CLK=0;#45;
		input_J = 1;input_K = 1;input_CLK=1;#10;
		input_J = 1;input_K = 1;input_CLK=0;#45;
		
		input_J = 0;input_K = 0;input_CLK=0;#45;
		input_J = 0;input_K = 0;input_CLK=1;#10;
		input_J = 0;input_K = 0;input_CLK=0;#45;
		
		input_J = 1;input_K = 0;input_CLK=0;#45;
		input_J = 1;input_K = 0;input_CLK=1;#10;
		input_J = 1;input_K = 0;input_CLK=0;#45;
		
		input_J = 0;input_K = 1;input_CLK=0;#45;
		input_J = 0;input_K = 1;input_CLK=1;#10;
		input_J = 0;input_K = 1;input_CLK=0;#45;

	end
      
endmodule

