`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:09 04/04/2022 
// Design Name: 
// Module Name:    decoder3_8 
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
module decoder3_8(
    input G1,
    input A1,
    input B1,
    output [3:0] Y1,
	 output [3:0] Y2
    );
	 
	 v74x139h_b T1 (.G_L(~G1), .A(A1), .B(B1), .Y_L(Y1));
	 v74x139h_b T2 (.G_L(G1), .A(A1), .B(B1), .Y_L(Y2));
	 
endmodule
