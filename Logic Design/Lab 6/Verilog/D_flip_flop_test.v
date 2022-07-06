`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:34:43 04/25/2022
// Design Name:   D_flip_flop
// Module Name:   /csehome/sagit25/R-S_latch/D_flip_flop_test.v
// Project Name:  R-S_latch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: D_flip_flop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module D_flip_flop_test;

	// Inputs
	reg D;
	reg ENA;

	// Outputs
	wire Q;
	
	// Bidirs
	wire CLK;

	// Instantiate the Unit Under Test (UUT)
	D_flip_flop uut (
		.D(D), 
		.ENA(ENA), 
		.CLK(CLK), 
		.Q(Q)
	);

	initial begin
		D=0 ; ENA = 0; #10;

		D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				D = 0; ENA = 1; #13;
		D = 1; ENA = 1; #13;
				 
		D = 1; ENA = 1; #13;
		
	end

endmodule

