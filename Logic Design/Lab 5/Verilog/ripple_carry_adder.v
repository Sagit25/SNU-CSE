`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:12 04/28/2022 
// Design Name: 
// Module Name:    ripple_carry_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ripple_carry_adder(
    input input_A1,
    input input_B1,
    input input_A0,
    input input_B0,
    input input_C0,
    output output_S0,
    output output_S1,
    output output_C2
    );
		
		wire c1;
	 
	 full_adder T3(.input_A(input_A0), .input_B(input_B0), .input_C(input_C0), .output_S(output_S0), .output_C(c1));
	 full_adder T4(.input_A(input_A1), .input_B(input_B1), .input_C(c1), .output_S(output_S1), .output_C(output_C2));

endmodule
