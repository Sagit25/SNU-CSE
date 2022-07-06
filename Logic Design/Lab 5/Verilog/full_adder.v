`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:14 04/28/2022 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder(
    input input_A,
    input input_B,
    input input_C,
    output output_S,
    output output_C
    );
	
		wire s1, c1;
	
		half_adder T1(.input_A(input_A), .input_B(input_B), .output_S(s1), .output_C(c1));
		half_adder T2(.input_A(input_C), .input_B(s1), .output_S(output_S), .output_C(c2));
		or T3(output_C, c1, c2);

endmodule
