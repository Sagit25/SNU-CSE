`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:33:03 04/04/2022
// Design Name:   v74x139h_a
// Module Name:   /csehome/sagit25/v74x139/v74x139_test.v
// Project Name:  v74x139
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: v74x139h_a
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module v74x139_test;

	// Inputs
	reg G_L;
	reg A;
	reg B;

	// Outputs
	wire [3:0] Y_L;

	// Instantiate the Unit Under Test (UUT)
	v74x139h_a uut (
		.G_L(G_L), 
		.A(A), 
		.B(B), 
		.Y_L(Y_L)
	);

	initial begin
		// Initialize Inputs
		G_L = 0;
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
				G_L = 0; A = 1; B = 0; #100;
		G_L = 0; A = 0; B = 1; #100;

		G_L = 0; A = 1; B = 1; #100;
		
	end
      
endmodule

