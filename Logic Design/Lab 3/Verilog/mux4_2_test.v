`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:45:44 04/04/2022
// Design Name:   mux4_1
// Module Name:   /csehome/sagit25/MUX4to1/mux4_1_test.v
// Project Name:  MUX4to1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux4_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux_4__test;

	// Inputs
	reg s1;
	reg s2;
	reg a;
	reg b;
	reg c;
	reg d;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	mux4_2 uut (
		.s1(s1), 
		.s2(s2), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		/*
		s1 = 0;
		s2 = 0;
		a = 0;
		b = 0;
		c = 0;
		d = 0;

		// Wait 100 ns for global reset to finish
		#100;*/
        
		// Add stimulus here
		s1 = 0; s2 = 0; a = 0; b = 0; c = 0; d = 0; #100;
		s1 = 0; s2 = 0; a = 1; b = 0; c = 0; d = 0; #100;
		
		s1 = 0; s2 = 1; a = 0; b = 0; c = 0; d = 0; #100;
		s1 = 0; s2 = 1; a = 0; b = 1; c = 0; d = 0; #100;
		
		s1 = 1; s2 = 0; a = 0; b = 0; c = 0; d = 0; #100;
		s1 = 1; s2 = 0; a = 0; b = 0; c = 1; d = 0; #100;
		
		s1 = 1; s2 = 1; a = 0; b = 0; c = 0; d = 0; #100;
		s1 = 1; s2 = 1; a = 0; b = 0; c = 0; d = 1; #100;

	end
      
endmodule

