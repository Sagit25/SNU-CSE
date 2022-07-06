`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:42:57 04/28/2022
// Design Name:   ripple_carry_adder
// Module Name:   C:/Users/sweet/SNU_Logic_Design_Board/ripple_carry_adder_test.v
// Project Name:  SNU_Logic_Design_Board
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ripple_carry_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ripple_carry_adder_test;

	// Inputs
	reg input_A1;
	reg input_B1;
	reg input_A0;
	reg input_B0;
	reg input_C0;

	// Outputs
	wire output_S0;
	wire output_S1;
	wire output_C2;

	// Instantiate the Unit Under Test (UUT)
	ripple_carry_adder uut (
		.input_A1(input_A1), 
		.input_B1(input_B1), 
		.input_A0(input_A0), 
		.input_B0(input_B0), 
		.input_C0(input_C0), 
		.output_S0(output_S0), 
		.output_S1(output_S1), 
		.output_C2(output_C2)
	);

	initial begin
		// Initialize Inputs
		input_A1 = 0;input_B1 = 0;input_A0 = 0;input_B0 = 0;input_C0 = 0;#100;
		
		input_A1 = 0;input_B1 = 0;input_A0 = 0;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 0;input_A0 = 0;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 0;input_B1 = 0;input_A0 = 1;input_B0 = 0;input_C0 = 0;#100;
		
		input_A1 = 0;input_B1 = 0;input_A0 = 0;input_B0 = 1;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 0;input_A0 = 1;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 0;input_A0 = 1;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 0;input_B0 = 0;input_C0 = 0;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 0;input_B0 = 0;input_C0 = 0;#100;
		
		input_A1 = 0;input_B1 = 0;input_A0 = 1;input_B0 = 1;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 0;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 0;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 1;input_B0 = 0;input_C0 = 0;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 0;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 0;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 1;input_B0 = 0;input_C0 = 0;#100;
		
		input_A1 = 1;input_B1 = 1;input_A0 = 0;input_B0 = 0;input_C0 = 0;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 1;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 1;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 0;input_B0 = 1;input_C0 = 1;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 1;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 1;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 0;input_B0 = 1;input_C0 = 1;#100;
		
		input_A1 = 1;input_B1 = 1;input_A0 = 0;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 1;input_B1 = 1;input_A0 = 0;input_B0 = 1;input_C0 = 0;#100;
		input_A1 = 1;input_B1 = 1;input_A0 = 1;input_B0 = 0;input_C0 = 0;#100;
		input_A1 = 1;input_B1 = 0;input_A0 = 1;input_B0 = 1;input_C0 = 1;#100;
		input_A1 = 0;input_B1 = 1;input_A0 = 1;input_B0 = 1;input_C0 = 1;#100;
		
		input_A1 = 1;input_B1 = 1;input_A0 = 0;input_B0 = 1;input_C0 = 1;#100;
		input_A1 = 1;input_B1 = 1;input_A0 = 1;input_B0 = 0;input_C0 = 1;#100;
		input_A1 = 1;input_B1 = 1;input_A0 = 1;input_B0 = 1;input_C0 = 0;#100;
		
		input_A1 = 1;input_B1 = 1;input_A0 = 1;input_B0 = 1;input_C0 = 1;#100;

	end
      
endmodule

