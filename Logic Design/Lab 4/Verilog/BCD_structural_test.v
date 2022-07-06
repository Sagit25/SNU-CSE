`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:28:53 04/11/2022
// Design Name:   BCD_structural
// Module Name:   C:/Users/sweet/week4/BCD_structural_test.v
// Project Name:  week4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BCD_structural
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BCD_structural_test;
	//Inputs
	reg I0, I1, I2, I3;
	
	//Outputs
	wire A, B, C, D, E, F, G;
	
	// Instantiate the Unit Under Test (UUT)
	BCD_structural uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.E(E), 
		.F(F), 
		.G(G), 
		.I0(I0), 
		.I1(I1), 
		.I2(I2), 
		.I3(I3)
	);

	initial begin
		// Initialize Inputs
		I0 = 0;	I1 = 0;	I2 = 0;	I3 = 0; #100; //0000
		I0 = 0;	I1 = 0;	I2 = 0;	I3 = 1; #100; //0001
		I0 = 0;	I1 = 0;	I2 = 1;	I3 = 0; #100; //0010
		I0 = 0;	I1 = 0;	I2 = 1;	I3 = 1; #100; //0011
		I0 = 0;	I1 = 1;	I2 = 0;	I3 = 0; #100; //0100
		I0 = 0;	I1 = 1;	I2 = 0;	I3 = 1; #100; //0101
		I0 = 0;	I1 = 1;	I2 = 1;	I3 = 0; #100; //0110
		I0 = 0;	I1 = 1;	I2 = 1;	I3 = 1; #100; //0111
		I0 = 1;	I1 = 0;	I2 = 0;	I3 = 0; #100; //1000
		I0 = 1;	I1 = 0;	I2 = 0;	I3 = 1; #100; //1001		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

