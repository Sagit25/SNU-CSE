`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:33:05 04/25/2022
// Design Name:   Simple_Oscillator
// Module Name:   /csehome/sagit25/R-S_latch/Simple_Oscillator_test.v
// Project Name:  R-S_latch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Simple_Oscillator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Simple_Oscillator_test;

	// Inputs
	reg ENA;

	// Bidirs
	wire CLK;

	// Instantiate the Unit Under Test (UUT)
	Simple_Oscillator uut (
		.ENA(ENA),
		.CLK(CLK)
	);

	initial begin
		ENA = 0; #100;
		ENA = 1;
	end
      
endmodule

