`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:12:55 04/25/2022 
// Design Name: 
// Module Name:    Simple_Oscillator 
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
module Simple_Oscillator(
    input ENA,
	inout CLK
    );
	 
	 wire tmp;
	
	 and T1(tmp, CLK, ENA);
	 not #5 T2(CLK, tmp);

endmodule
