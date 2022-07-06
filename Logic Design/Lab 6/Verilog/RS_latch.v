`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:32:16 04/25/2022 
// Design Name: 
// Module Name:    RS_latch 
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
module RS_latch(
    input R,
    input S,
	 input Q_L,
    output Q_H
    );
	 
	 wire [1:0] sel;
	 reg out;
	 
	 assign sel = {R, S};
	 assign Q_H = out;

	 always @(sel) 
		begin
			case(sel)
				2'b00 : out = Q_L;
				2'b10 : out = 0;
				2'b01 : out = 1;				
			endcase
		end

endmodule
