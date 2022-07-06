`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:25:19 06/13/2022 
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory(
    input [7:0] input_Address,
    input [7:0] input_Write_Data,
    input input_MemRead,
    input input_MemWrite,
    input input_Clock,
    input input_Reset,
    output [7:0] output_Read_Data
    );
		
		reg [7:0] memory[31:0];
		reg [7:0] out;
		
		assign output_Read_Data = memory[input_Address[4:0]];
		
		always@(posedge input_Reset or posedge input_Clock) begin
			if(input_Reset) begin
				memory[0] = 8'b00000000;
				memory[1] = 8'b00000001;
				memory[2] = 8'b00000010;
				memory[3] = 8'b00000011;
				memory[4] = 8'b00000100;
				memory[5] = 8'b00000101;
				memory[6] = 8'b00000110;
				memory[7] = 8'b00000111;
				memory[8] = 8'b00001000;
				memory[9] = 8'b00001001;
				memory[10] = 8'b00001010;
				memory[11] = 8'b00001011;
				memory[12] = 8'b00001100;
				memory[13] = 8'b00001101;
				memory[14] = 8'b00001110;
				memory[15] = 8'b00001111;
				memory[16] = 8'b00000000;
				memory[17] = 8'b11111111;
				memory[18] = 8'b11111110;
				memory[19] = 8'b11111101;
				memory[20] = 8'b11111100;
				memory[21] = 8'b11111011;
				memory[22] = 8'b11111010;
				memory[23] = 8'b11111001;
				memory[24] = 8'b11111000;
				memory[25] = 8'b11110111;
				memory[26] = 8'b11110110;
				memory[27] = 8'b11110101;
				memory[28] = 8'b11110100;
				memory[29] = 8'b11110011;
				memory[30] = 8'b11110010;
				memory[31] = 8'b11110001;
			end
			else if(input_MemWrite) begin
				memory[input_Address[4:0]] = input_Write_Data;
			end
		end
endmodule
