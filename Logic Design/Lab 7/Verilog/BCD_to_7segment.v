`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:36 05/04/2022 
// Design Name: 
// Module Name:    BCD_to_7segment 
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
module BCD_to_7segment(
    input [3:0] input_BCD,
    output [6:0] output_segment
    );
	 
	reg [6:0] out;
	 
	assign output_segment = out;
	 
	always@(input_BCD) begin
		case(input_BCD)
			4'b0000: out = 7'b1111110;
			4'b0001: out = 7'b0110000;
			4'b0010: out = 7'b1101101;
			4'b0011: out = 7'b1111001;
			4'b0100: out = 7'b0110011;
			4'b0101: out = 7'b1011011;
			4'b0110: out = 7'b1011111;
			4'b0111: out = 7'b1110000;
			4'b1000: out = 7'b1111111;
			4'b1001: out = 7'b1111011;
			default: out = 7'b0000000;
		endcase
	end

endmodule
