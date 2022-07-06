`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:59:23 06/13/2022 
// Design Name: 
// Module Name:    Instruction_Memory 
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
module Instruction_Memory(
    input [7:0] input_Address,
    output [7:0] output_Instruction
    );

	wire [7:0] MemByte[31:0];
	
	assign output_Instruction = MemByte[input_Address[4:0]];

	 assign MemByte[0] = {2'b01, 2'b00, 2'b10, 2'b01};
	 assign MemByte[1] = {2'b11, 2'b00, 2'b00, 2'b01};
	 assign MemByte[2] = {2'b00, 2'b01, 2'b10, 2'b00};
	 assign MemByte[3] = {2'b10, 2'b10, 2'b10, 2'b01};
	 assign MemByte[4] = {2'b01, 2'b00, 2'b11, 2'b01};
		
endmodule
