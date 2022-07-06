`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:34:00 04/04/2022
// Design Name:   decoder3_8
// Module Name:   /csehome/sagit25/v74x139/decoder3_8_test.v
// Project Name:  v74x139
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: decoder3_8
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decoder3_8_test;

	// Inputs
	reg G1;
	reg A1;
	reg B1;

	// Outputs
	wire [3:0] Y1;
	wire [3:0] Y2;

	// Instantiate the Unit Under Test (UUT)
	decoder3_8 uut (
		.G1(G1), 
		.A1(A1), 
		.B1(B1), 
		.Y1(Y1), 
		.Y2(Y2)
	);

	initial begin
		// Initialize Inputs
		G1 = 0;
		A1 = 0;
		B1 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		G1 = 0; A1 = 1; B1 = 0; #100;
		G1 = 0; A1 = 0; B1 = 1; #100;
		G1 = 0; A1 = 1; B1 = 1; #100;
		G1 = 1; A1 = 0; B1 = 0; #100;
		G1 = 1; A1 = 1; B1 = 0; #100;
		G1 = 1; A1 = 0; B1 = 1; #100;
		G1 = 1; A1 = 1; B1 = 1; #100;
		

	end
      
endmodule

