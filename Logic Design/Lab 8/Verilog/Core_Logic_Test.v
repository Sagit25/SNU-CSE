`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:32:44 05/16/2022
// Design Name:   Core_Logic
// Module Name:   /csehome/sagit25/Vending_Machine/Core_Logic_Test.v
// Project Name:  Vending_Machine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Core_Logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Core_Logic_Test;

	// Inputs
	reg Ni;
	reg Di;
	reg reset;
	reg clk;

	// Outputs
	wire open;

	// Bidirs
	wire [1:0] Q;

	// Instantiate the Unit Under Test (UUT)
	Core_Logic uut (
		.Ni(Ni), 
		.Di(Di), 
		.Q(Q), 
		.open(open), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
	
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		
		Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		// Ni = 0; Di = 1; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Di = 0; #40; // dime
		
		// Ni = 0; Di = 0; reset = 0; clk = 0; #40; reset = 1; #20; reset = 0; #40; // reset
		
		// Ni = 1; Di = 0; reset = 0; clk = 0; #40; clk = 1; #20; clk = 0; Ni = 0; #40; // nickel
			
	end
      
endmodule

