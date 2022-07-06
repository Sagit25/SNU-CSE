`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:46:40 06/13/2022 
// Design Name: 
// Module Name:    Microprocessor 
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
module Microprocessor(
    input [7:0] input_Instruction,
    input input_Clock,
    input input_Reset,
    output [13:0] output_Display,
	 output [7:0] output_Address,
	 output [7:0] reg1, 
	 output [7:0] reg2, 
	 output [7:0] reg3, 
	 output [7:0] reg4
    );
	 
	 wire RegDst, RegWrite, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, ALUOp;
	 
	 wire [7:0] WriteReg;
	 wire [7:0] Extended;
	 wire [7:0] WriteData;
	 wire [7:0] ReadData1;
	 wire [7:0] ReadData2;
	 
	 wire [7:0] ALU2;
	 wire [7:0] ALUOut;
	 
	 wire [7:0] out;
	 wire [13:0] result;
	 wire [7:0] ReadData;
	 
	 wire [7:0] prev;
	 wire [7:0] next;
	 wire [7:0] next1;
	 wire [7:0] next2;
	 
	 wire clk;
	 
	 assign output_Address = next;
	 assign output_Display = result;
	 
	 Frequency_Divider T0(.input_CLK(input_Clock), .input_ENA(input_Reset), .output_CLK(clk));
	 
	 Control_Unit T1(.input_Operator(input_Instruction[7:6]), .output_RegDst(RegDst), .output_RegWrite(RegWrite), .output_ALUSrc(ALUSrc), .output_Branch(Branch), .output_MemRead(MemRead), .output_MemWrite(MemWrite), .output_MemtoReg(MemtoReg), .output_ALUOp(ALUOp));
	 MUX T2(.input_Control(RegDst), .input_A({6'b000000,input_Instruction[3:2]}), .input_B({6'b000000,input_Instruction[1:0]}), .output_Y(WriteReg));
	 Sign_Extend T3(.input_A(input_Instruction[1:0]), .output_Y(Extended));
	 Registers T4(.input_Reset(input_Reset), .input_Clock(clk), .input_Read_Address_1(input_Instruction[5:4]), .input_Read_Address_2(input_Instruction[3:2]), .input_Write_Address(WriteReg[1:0]), .input_Write_Data(WriteData), .input_RegWrite(RegWrite), .output_Read_Data_1(ReadData1), .output_Read_Data_2(ReadData2), .output_Output(out), .register1(reg1), .register2(reg2), .register3(reg3), .register4(reg4));
	 MUX T5(.input_Control(ALUSrc), .input_A(ReadData2), .input_B(Extended), .output_Y(ALU2));
	 ALU T6(.input_A(ReadData1), .input_B(ALU2), .output_Y(ALUOut));
	 MUX T7(.input_Control(MemtoReg), .input_A(ALUOut), .input_B(ReadData), .output_Y(WriteData));
	 Data_Memory T8(.input_Address(ALUOut), .input_Write_Data(ReadData2), .input_MemRead(MemRead), .input_MemWrite(MemWrite), .input_Clock(clk), .input_Reset(input_Reset), .output_Read_Data(ReadData));
	 Program_Counter T9(.input_Clock(clk), .input_Reset(input_Reset), .input_X(prev), .output_Y(next));
	 ALU T10(.input_A(next), .input_B(8'b00000001), .output_Y(next1));
	 ALU T11(.input_A(next1), .input_B(Extended), .output_Y(next2));
	 MUX T12(.input_Control(Branch), .input_A(next1), .input_B(next2), .output_Y(prev));
	 Decoder T13(.input_Signal(out), .output_7Segment(result));

endmodule
