`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:50 04/25/2022 
// Design Name: 
// Module Name:    Gated_RS_latch 
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
module Gated_RS_latch(
    input R,
    input S,
    input E,
    input Q_L,
    output Q_H
    );
	 
	 wire R1, S1;
	 
	 and T1(R1, R, E);
	 and T2(S1, S, E);
	 
	 RS_latch T3 (R1, S1, Q_L, Q_H);
	 
endmodule
