`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:25 04/12/2022 
// Design Name: 
// Module Name:    Klingon_behavioral 
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
module Klingon_behavioral(
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
				4'b0001 : out = 7'b1000000;
				4'b0010 : out = 7'b1000001;
				4'b0011 : out = 7'b1001001;
				4'b0100 : out = 7'b0100011;
				4'b0101 : out = 7'b0011101;
				4'b0110 : out = 7'b0100101;
				4'b0111 : out = 7'b0010011;
				4'b1000 : out = 7'b0110110;
				4'b1001 : out = 7'b0110111;
			endcase
		end

endmodule
