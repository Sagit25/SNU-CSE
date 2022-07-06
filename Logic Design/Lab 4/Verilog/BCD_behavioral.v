`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:41 04/12/2022 
// Design Name: 
// Module Name:    BCD_behavioral 
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
module BCD_behavioral(
    output [6:0] Y,
    input I0,
    input I1,
    input I2,
    input I3
    );
	 
	 wire [3:0] sel;
	 reg [6:0] out;
	 
	 assign sel = {I0, I1, I2, I3};
	 assign Y = out;
	 
	 always@(sel)
		begin
			case(sel)
				4'b0000 : out = 7'b1111110;
				4'b0001 : out = 7'b0110000;
				4'b0010 : out = 7'b1101101;
				4'b0011 : out = 7'b1111001;
				4'b0100 : out = 7'b0110011;
				4'b0101 : out = 7'b1011011;
				4'b0110 : out = 7'b1011111;
				4'b0111 : out = 7'b1110010;
				4'b1000 : out = 7'b1111111;
				4'b1001 : out = 7'b1111011;
			endcase
		end

endmodule
