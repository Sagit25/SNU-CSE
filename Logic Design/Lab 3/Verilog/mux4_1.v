`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:17 04/04/2022 
// Design Name: 
// Module Name:    mux4_1 
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
module mux4_1(
    input s1,
    input s2,
    input a,
    input b,
    input c,
    input d,
    output out
    );
	 
	 wire [3:0] w;
	 
	 and T1 (w[0], a, ~s1, ~s2);
	 and T2 (w[1], b, ~s1, s2);
	 and T3 (w[2], c, s1, ~s2);
	 and T4 (w[3], d, s1, s2);
	 
	 or T5 (out, w[0], w[1], w[2], w[3]);
	 
endmodule
