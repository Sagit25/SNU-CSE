`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:50 04/06/2022 
// Design Name: 
// Module Name:    mux4_2 
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
module mux4_2(
    input s1,
    input s2,
    input a,
    input b,
    input c,
    input d,
    output out
	 
    );
	 wire [1:0] sel;
	 assign sel= {s1,s2};
	 
	 assign out=(sel==2'b00)?a:
					(sel==2'b01)?b:
					(sel==2'b10)?c:
					(sel==2'b11)?d:
					0;

endmodule
