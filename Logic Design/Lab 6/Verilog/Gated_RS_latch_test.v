`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:05:33 04/25/2022
// Design Name:   Gated_RS_latch
// Module Name:   /csehome/sagit25/R-S_latch/Gated_RS_latch_test.v
// Project Name:  R-S_latch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Gated_RS_latch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Gated_RS_latch_test;

	// Inputs
	reg R;
	reg S;
	reg E;
	reg Q_L;

	// Outputs
	wire Q_H;

	// Instantiate the Unit Under Test (UUT)
	Gated_RS_latch uut (
		.R(R), 
		.S(S), 
		.E(E), 
		.Q_L(Q_L), 
		.Q_H(Q_H)
	);

	initial begin
		R = 0; S = 0; E = 1; Q_L = Q_H; #100;
		R = 0; S = 1; E = 1; Q_L = Q_H; #100;
		R = 1; S = 0; E = 1; Q_L = Q_H; #100;
		R = 0; S = 0; E = 0; Q_L = Q_H; #100;
		R = 0; S = 1; E = 0; Q_L = Q_H; #100;
		R = 1; S = 0; E = 0; Q_L = Q_H; #100;
	end
      
endmodule

