`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:17:18 06/13/2022 
// Design Name: 
// Module Name:    Decoder 
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
module Decoder(
    input [7:0] input_Signal,
    output [13:0] output_7Segment
    );
		
	 reg [6:0] out1;
	 reg [6:0] out2;
	 
	 assign output_7Segment = {out2, out1};
	 
	 always@(input_Signal) begin
		case(input_Signal[7:4])
			4'b0000 : out2 = 7'b1111110;
			4'b0001 : out2 = 7'b0110000;
			4'b0010 : out2 = 7'b1101101;
			4'b0011 : out2 = 7'b1111001;
			4'b0100 : out2 = 7'b0110011;
			4'b0101 : out2 = 7'b1011011;
			4'b0110 : out2 = 7'b1011111;
			4'b0111 : out2 = 7'b1110000;
			4'b1000 : out2 = 7'b1111111;
			4'b1001 : out2 = 7'b1111011;
			4'b1010 : out2 = 7'b1110111;
			4'b1011 : out2 = 7'b0011111;
			4'b1100 : out2 = 7'b1001110;
			4'b1101 : out2 = 7'b0111101;
			4'b1110 : out2 = 7'b1001111;
			4'b1111 : out2 = 7'b1000111;
		endcase
		case(input_Signal[3:0]) 
			4'b0000 : out1 = 7'b1111110;
			4'b0001 : out1 = 7'b0110000;
			4'b0010 : out1 = 7'b1101101;
			4'b0011 : out1 = 7'b1111001;
			4'b0100 : out1 = 7'b0110011;
			4'b0101 : out1 = 7'b1011011;
			4'b0110 : out1 = 7'b1011111;
			4'b0111 : out1 = 7'b1110000;
			4'b1000 : out1 = 7'b1111111;
			4'b1001 : out1 = 7'b1111011;
			4'b1010 : out1 = 7'b1110111;
			4'b1011 : out1 = 7'b0011111;
			4'b1100 : out1 = 7'b1001110;
			4'b1101 : out1 = 7'b0111101;
			4'b1110 : out1 = 7'b1001111;
			4'b1111 : out1 = 7'b1000111;
		endcase
	 end

endmodule
