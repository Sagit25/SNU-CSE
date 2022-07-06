`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:16 06/13/2022 
// Design Name: 
// Module Name:    Program_Counter 
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
module Program_Counter(
    input input_Clock,
	 input input_Reset,
    input [7:0] input_X,
    output [7:0] output_Y
    );
		
		reg [7:0] out;
		
		assign output_Y = out;
		
		always@(posedge input_Clock or posedge input_Reset) begin
			if(input_Reset) begin
				out = 8'b00000000;
			end
			else begin
				out = input_X;
			end
		end

endmodule
