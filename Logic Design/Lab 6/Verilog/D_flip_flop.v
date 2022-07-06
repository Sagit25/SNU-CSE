`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:49 04/25/2022 
// Design Name: 
// Module Name:    D_flip_flop 
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
module D_flip_flop(
    input D,
	input ENA,
    inout CLK,
    output Q
    );
	 
	 wire Q_H, Q_L, Q1_L, CLK_H;
	 
	 Simple_Oscillator T1 (ENA, CLK);
	 Gated_RS_latch T2 (~D, D, CLK, Q_L, Q_H);
	 assign Q_L= Q_H;
	 Gated_RS_latch T3 (~Q_H, Q_H, ~CLK, Q1_L, Q);
	 assign Q1_L=Q;
	 
endmodule
