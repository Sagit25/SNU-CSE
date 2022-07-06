`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:14:15 06/13/2022 
// Design Name: 
// Module Name:    Registers 
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
module Registers(
	 input input_Reset,
	 input input_Clock,
    input [1:0] input_Read_Address_1,
    input [1:0] input_Read_Address_2,
    input [1:0] input_Write_Address,
    input [7:0] input_Write_Data,
    input input_RegWrite,
    output [7:0] output_Read_Data_1,
    output [7:0] output_Read_Data_2,
    output [7:0] output_Output,
	 output [7:0] register1,
	 output [7:0] register2,
	 output [7:0] register3,
	 output [7:0] register4
    );

		reg [7:0] reg1;
		reg [7:0] reg2;
		reg [7:0] reg3;
		reg [7:0] reg4;
		
		reg [7:0] read1;
		reg [7:0] read2;
		reg [7:0] out;
		
		assign output_Read_Data_1 = 	input_Read_Address_1 == 2'b00 ? 	reg1:
												input_Read_Address_1 == 2'b01 ? 	reg2:
												input_Read_Address_1 == 2'b10 ? 	reg3:
																							reg4;
		
		assign output_Read_Data_2 = 	input_Read_Address_2 == 2'b00 ? 	reg1:
												input_Read_Address_2 == 2'b01 ? 	reg2:
												input_Read_Address_2 == 2'b10 ? 	reg3:
																							reg4;
		
		assign register1 = reg1;
		assign register2 = reg2;
		assign register3 = reg3;
		assign register4 = reg4;
		
		assign output_Output = input_Write_Data;
		
		always@(posedge input_Reset or posedge input_Clock) begin
			if(input_Reset) begin
				reg1 = 8'b00000000;
				reg2 = 8'b00000000;
				reg3 = 8'b00000000;
				reg4 = 8'b00000000;
				out = 8'b00000000;
			end
			else begin
				if(input_RegWrite) begin
					
					case(input_Write_Address)
						2'b00 : reg1 = input_Write_Data;
						2'b01 : reg2 = input_Write_Data;
						2'b10 : reg3 = input_Write_Data;
						2'b11 : reg4 = input_Write_Data;
					endcase
				end
			end
		end

endmodule
