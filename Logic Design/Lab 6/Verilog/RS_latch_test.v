`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:40:00 04/25/2022
// Design Name:   RS_latch
// Module Name:   /csehome/sagit25/R-S_latch/RS_latch_test.v
// Project Name:  R-S_latch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RS_latch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RS_latch_test;

	// Inputs
	reg R;
	reg S;
	reg Q_L;

	// Outputs
	wire Q_H;

	// Instantiate the Unit Under Test (UUT)
	RS_latch uut (
		.R(R), 
		.S(S), 
		.Q_L(Q_L),
		.Q_H(Q_H)
	);

	initial begin
		R = 0; S = 0; Q_L = Q_H; #100;
		R = 1; S = 0; Q_L = Q_H; #100;
		R = 0; S = 1; Q_L = Q_H; #100;	
	end
      
endmodule

