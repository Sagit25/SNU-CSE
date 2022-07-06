// Verilog test fixture created from schematic C:\Users\sweet\SNU_Logic_Design_Board\half_adder.sch - Thu Apr 28 17:27:34 2022

`timescale 1ns / 1ps

module half_adder_half_adder_sch_tb();

// Inputs
   reg input_A;
   reg input_B;

// Output
   wire output_S;
   wire output_C;

// Bidirs

// Instantiate the UUT
   half_adder UUT (
		.input_A(input_A), 
		.input_B(input_B), 
		.output_S(output_S), 
		.output_C(output_C)
   );
// Initialize Inputs
       initial begin
		input_A = 0;
		input_B = 0;
		#100;
		input_A = 0;
		input_B = 1;
		#100;
		input_A = 1;
		input_B = 0;
		#100;
		input_A = 1;
		input_B = 1;
		 end
endmodule
