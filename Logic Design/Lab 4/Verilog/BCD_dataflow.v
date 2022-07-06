`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:12 04/12/2022 
// Design Name: 
// Module Name:    BCD_dataflow 
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
module BCD_dataflow(
    output [6:0] Y,
    input I0,
    input I1,
    input I2,
    input I3
    );

		wire [3:0] sel;
		wire [6:0] out;
		
		assign sel = {I0, I1, I2, I3};
		assign Y = out;
		
		assign out =	(sel == 4'b0000) ? 7'b1111110 :
							(sel == 4'b0001) ? 7'b0110000 :
							(sel == 4'b0010) ? 7'b1101101 :
							(sel == 4'b0011) ? 7'b1111001 :
							(sel == 4'b0100) ? 7'b0110011 :
							(sel == 4'b0101) ? 7'b1011011 :
							(sel == 4'b0110) ? 7'b1011111 :
							(sel == 4'b0111) ? 7'b1110010 :
							(sel == 4'b1000) ? 7'b1111111 :
							(sel == 4'b1001) ? 7'b1111011 :
							7'b0000000;

endmodule
