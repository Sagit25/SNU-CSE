`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:53:14 04/28/2022 
// Design Name: 
// Module Name:    arithmatic_logic_unit 
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
module arithmatic_logic_unit(
    input A,
    input B,
    input S1,
    input S0,
    output F1,
    output F2,
    output F3,
    output F4
    );
	 
	 wire [1:0] sel;
	 reg [3:0] out;
	 
	 assign sel = {S1, S0};
	 assign {F1, F2, F3, F4} = out;
	 
	 always@(A or B or sel)
		begin
			case(sel)
				2'b00 : out = {0, 1, A, B};
				2'b01 : out = {A, A, !A, !A} & {B, !B, B, !B};
				2'b10 : out = {!A, !B, A!=B, A==B};
				2'b11 : out = {A, A, !A, !A} | {B, !B, B, !B};
			endcase
		end
	
endmodule
