`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:15 04/06/2022 
// Design Name: 
// Module Name:    mux_4_ 
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
module mux_4_(
    input s1,
    input s2,
    input a,
    input b,
    input c,
    input d,
    output out
    );
	 
	 wire [1:0] sel;
	 reg Outt;
	 
	 assign sel = {s1, s2};
	 assign out = Outt;
	 
	always@(sel or a or b or c or d)
		begin
			case(sel)
				2'b00 : Outt = a;
				2'b01 : Outt = b;
				2'b10 : Outt = c;
				2'b11 : Outt = d;
			endcase
		end

endmodule
