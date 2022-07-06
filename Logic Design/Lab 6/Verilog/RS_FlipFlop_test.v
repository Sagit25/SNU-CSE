`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:43:52 05/02/2022
// Design Name:   RS_FlipFlop
// Module Name:   C:/Users/sweet/RS_FlipFlop/RS_FlipFlop_test.v
// Project Name:  RS_FlipFlop
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RS_FlipFlop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RS_FlipFlop_test;

	// Inputs
	reg input_R;
	reg input_S;
	reg input_ENA;

	// Outputs
	wire output_QH;
	wire output_QL;

	// Bidirs
	wire inout_CLK;

	// Instantiate the Unit Under Test (UUT)
	RS_FlipFlop uut (
		.input_R(input_R), 
		.input_S(input_S), 
		.input_ENA(input_ENA), 
		.inout_CLK(inout_CLK), 
		.output_QH(output_QH), 
		.output_QL(output_QL)
	);

	initial begin
		// Initialize Inputs
		input_R = 0;input_S = 0;input_ENA = 0;#100;
		input_R = 0;input_S = 0;input_ENA = 1;#25;
		input_R = 0;input_S = 0;input_ENA = 1;#200;
		input_R = 0;input_S = 1;input_ENA = 1;#200;
		input_R = 1;input_S = 0;input_ENA = 1;#200;
		
		
		input_R = 0;input_S = 0;input_ENA = 1;#40;
		input_R = 0;input_S = 1;input_ENA = 1;#10;
		input_R = 0;input_S = 0;input_ENA = 1;#150;
		
		input_R = 0;input_S = 1;input_ENA = 1;#10;
		input_R = 0;input_S = 0;input_ENA = 1;#190;
		
		input_R = 1;input_S = 1;input_ENA = 1;#200;
		input_R = 0;input_S = 0;input_ENA = 1;#200;

	end
      
endmodule

