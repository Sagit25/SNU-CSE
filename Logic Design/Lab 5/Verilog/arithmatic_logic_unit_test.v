`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:06:46 04/28/2022
// Design Name:   arithmatic_logic_unit
// Module Name:   C:/Users/sweet/arithmatic_logic_unit/arithmatic_logic_unit_test.v
// Project Name:  arithmatic_logic_unit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: arithmatic_logic_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module arithmatic_logic_unit_test;

	// Inputs
	reg A;
	reg B;
	reg S1;
	reg S0;

	// Outputs
	wire F1;
	wire F2;
	wire F3;
	wire F4;

	// Instantiate the Unit Under Test (UUT)
	arithmatic_logic_unit uut (
		.A(A), 
		.B(B), 
		.S1(S1), 
		.S0(S0), 
		.F1(F1), 
		.F2(F2), 
		.F3(F3), 
		.F4(F4)
	);

	initial begin
		// Initialize Inputs
		S1 = 0;S0 = 0;
		A = 0;B = 0;#100;
		A = 0;B = 1;#100;
		A = 1;B = 0;#100;
		A = 1;B = 1;#100;
		
		S1 = 0;S0 = 1;
		A = 0;B = 0;#100;
		A = 0;B = 1;#100;
		A = 1;B = 0;#100;
		A = 1;B = 1;#100;
		
		S1 = 1;S0 = 0;
		A = 0;B = 0;#100;
		A = 0;B = 1;#100;
		A = 1;B = 0;#100;
		A = 1;B = 1;#100;
		
		S1 = 1;S0 = 1;
		A = 0;B = 0;#100;
		A = 0;B = 1;#100;
		A = 1;B = 0;#100;
		A = 1;B = 1;#100;
		
	end
      
endmodule

