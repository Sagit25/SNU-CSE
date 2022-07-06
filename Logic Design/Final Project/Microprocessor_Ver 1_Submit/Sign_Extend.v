`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:05 06/13/2022 
// Design Name: 
// Module Name:    Sign_Extend 
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
module Sign_Extend(
    input [1:0] input_A,
    output [7:0] output_Y
    );
	 
		reg [7:0] out;
		
		assign output_Y = out;
		
		always@(input_A) begin
			 out[7:2] = {6{input_A[1]}};
			 out[1:0] = input_A[1:0];
		end


endmodule
