`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:58 04/04/2022 
// Design Name: 
// Module Name:    v74x139h_b 
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
module v74x139h_b(
    input G_L,
    input A,
    input B,
    output [3:0] Y_L
    );
	
	wire [1:0] sel;
	wire [3:0] out;
	
	assign sel = {B, A};
	assign Y_L = ~out;
	
	assign out = (sel == 2'b00 && G_L == 1'b0) ? 4'b0001 :
					 (sel == 2'b01 && G_L == 1'b0) ? 4'b0010 :
					 (sel == 2'b10 && G_L == 1'b0) ? 4'b0100 :
					 (sel == 2'b11 && G_L == 1'b0) ? 4'b1000 :
					 4'b0000;

endmodule
