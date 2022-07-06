`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:06:26 06/13/2022 
// Design Name: 
// Module Name:    Control_Unit 
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
module Control_Unit(
    input [1:0] input_Operator,
    output output_RegDst,
    output output_RegWrite,
    output output_ALUSrc,
    output output_Branch,
    output output_MemRead,
    output output_MemWrite,
    output output_MemtoReg,
    output output_ALUOp
    );
	 
	 reg [7:0] out;
	 
	 assign {output_RegDst, output_RegWrite, output_ALUSrc, output_Branch, output_MemRead, output_MemWrite, output_MemtoReg, output_ALUOp} = out;
	
	 always@(input_Operator) begin
		case(input_Operator)
			2'b00	:	out = 8'b11000001;
			2'b01	:	out = 8'b01101010;
			2'b10	:	out = 8'b00100100;
			2'b11	:	out = 8'b00010000;
		endcase
	 end

endmodule
