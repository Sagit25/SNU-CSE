`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:03:04 05/04/2022 
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
    input input_ENA,
	input input_CLK,
    output [6:0] output_Y0,
    output [6:0] output_Y1
    );
	 
	wire overflow, clk, ooo;
	wire [3:0] y1;
	wire [3:0] y0;
	 
	Full_Counter T1(.input_CLK(clk), .input_ENA(input_ENA), .output_Y1(y1), .output_Y0(y0));
	Frequency_Divider T2(.input_CLK(input_CLK), .input_ENA(input_ENA), .output_CLK(clk));
	  
	BCD_to_7segment T3(.input_BCD(y1), .output_segment(output_Y0));
	BCD_to_7segment T4(.input_BCD(y0), .output_segment(output_Y1));

endmodule
