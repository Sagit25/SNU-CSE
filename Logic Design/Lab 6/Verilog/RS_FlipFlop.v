`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:40:27 05/02/2022 
// Design Name: 
// Module Name:    RS_FlipFlop 
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
module RS_FlipFlop(
    input input_R,
    input input_S,
    input input_ENA,
    inout inout_CLK,
    output output_QH,
    output output_QL
    );
		
		wire 	r1, s1, qh, ql, r2, s2, clk;
		
		Simple_Oscillator T1(.input_ENA(input_ENA), .inout_CLK(inout_CLK));
		and T2(r1, input_R, inout_CLK);
		and T3(s1, input_S, inout_CLK);
		not T4(clk, inout_CLK);
		RS_Latch T5(.input_R(r1), .input_S(s1), .output_QH(q2), .output_QL(q1));
		and T6(r2, q1, clk);
		and T7(s2, q2, clk);
		RS_Latch T8(.input_R(r2), .input_S(s2), .output_QH(output_QH), .output_QL(output_QL));

endmodule
