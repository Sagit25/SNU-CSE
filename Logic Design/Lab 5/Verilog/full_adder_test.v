`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:31:36 04/28/2022
// Design Name:   full_adder
// Module Name:   C:/Users/sweet/SNU_Logic_Design_Board/full_adder_test.v
// Project Name:  SNU_Logic_Design_Board
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: full_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module full_adder_test;

	// Inputs
	reg input_A;
	reg input_B;
	reg input_C;

	// Outputs
	wire output_S;
	wire output_C;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.input_A(input_A), 
		.input_B(input_B), 
		.input_C(input_C), 
		.output_S(output_S), 
		.output_C(output_C)
	);

	initial begin
		// Initialize Inputs
		input_A = 0;input_B = 0;input_C = 0;#100;
		
		input_A = 0;input_B = 0;input_C = 1;#100;
		input_A = 0;input_B = 1;input_C = 0;#100;
		input_A = 1;input_B = 0;input_C = 0;#100;
		
		input_A = 0;input_B = 1;input_C = 1;#100;
		input_A = 1;input_B = 0;input_C = 1;#100;
		input_A = 1;input_B = 1;input_C = 0;#100;
		
		input_A = 1;input_B = 1;input_C = 1;#100;

	end
      
endmodule

