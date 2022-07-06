`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:14:11 06/13/2022
// Design Name:   Final
// Module Name:   C:/Users/chowd/Downloads/Final/Final_Project/Final_test.v
// Project Name:  Final_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Final
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Final_test;

	// Inputs
	reg input_Clock;
	reg input_Sub_Clock;
	reg input_Reset;

	// Outputs
	wire [13:0] output_Display;
	wire [7:0] inst;
	wire [7:0] reg1;
	wire [7:0] reg2;
	wire [7:0] reg3;
	wire [7:0] reg4;

	// Instantiate the Unit Under Test (UUT)
	Final uut (
		.input_Clock(input_Clock), 
		.input_Sub_Clock(input_Sub_Clock),
		.input_Reset(input_Reset), 
		.output_Display(output_Display),
		.inst(inst),
		.reg1(reg1),
		.reg2(reg2),
		.reg3(reg3),
		.reg4(reg4)
	);

	initial begin
		// Initialize Inputs
		input_Sub_Clock = 0;
		input_Clock = 0; input_Reset = 0; #3;
		input_Reset = 1; #4;
		input_Reset = 0; #3;
	end
	
	always #10 begin
		input_Clock = ~input_Clock;
		#2;
		input_Sub_Clock = input_Clock;
	end
      
endmodule

