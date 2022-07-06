`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:23:09 06/13/2022 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [7:0] input_A,
    input [7:0] input_B,
    output [7:0] output_Y
    );
		
	 reg [8:0] out;
	 
	 assign output_Y = out[7:0];
	 
	 always@(input_A or input_B) begin
			out = input_A + input_B;
	 end

endmodule
