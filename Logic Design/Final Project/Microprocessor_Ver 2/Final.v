`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:10:27 06/13/2022 
// Design Name: 
// Module Name:    Final 
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
module Final(
    input input_Clock, 
    input input_Reset,
    output [13:0] output_Display
    );
	
	wire [7:0] instruction;
	wire [7:0] address;
	
	assign inst = instruction;
	
	Microprocessor T1(.input_Instruction(instruction), .input_Clock(input_Clock), .input_Reset(input_Reset), .output_Display(output_Display), .output_Address(address), .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4));
    Instruction_Memory T2(.input_Address(address), .output_Instruction(instruction));
	
endmodule
