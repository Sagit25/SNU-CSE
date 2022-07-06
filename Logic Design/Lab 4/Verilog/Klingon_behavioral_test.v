`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:02:12 04/12/2022
// Design Name:   Klingon_behavioral
// Module Name:   C:/Users/sweet/week4/Klingon_behavioral_test.v
// Project Name:  week4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Klingon_behavioral
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Klingon_behavioral_test;

	// Inputs
	reg I0;
	reg I1;
	reg I2;
	reg I3;

	// Outputs
	wire [6:0] Y;

	// Instantiate the Unit Under Test (UUT)
	Klingon_behavioral uut (
		.Y(Y), 
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

