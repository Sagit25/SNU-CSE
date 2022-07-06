`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:56:45 05/02/2022
// Design Name:   Counter
// Module Name:   C:/Users/sweet/Counter/Counter_test.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Counter_test;

	// Inputs
	reg input_CLK;
	reg input_ENA;

	// Bidirs
	wire [3:0] output_Y;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	Counter uut (
		.input_CLK(input_CLK), 
		.input_ENA(input_ENA), 
		.output_Y(output_Y),
		.overflow(overflow)
	);

	initial begin
		// Initialize Inputs
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 0;input_ENA = 1;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;
		
		input_CLK = 0;input_ENA = 0;#45;
		input_CLK = 1;input_ENA = 0;#10;
		input_CLK = 0;input_ENA = 0;#45;

	end
      
endmodule

