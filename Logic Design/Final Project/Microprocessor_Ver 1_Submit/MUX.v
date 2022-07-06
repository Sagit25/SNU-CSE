`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:01:28 06/13/2022 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
    input input_Control,
    input [7:0] input_A,
    input [7:0] input_B,
    output [7:0] output_Y
    );
		
		reg [7:0] out;
		
		assign output_Y = out;
		
		always@(input_Control or input_A or input_B) begin
			if(input_Control) begin
				out = input_B;
			end
			else begin
				out = input_A;
			end
		end

endmodule
