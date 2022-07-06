`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:01:12 05/16/2022 
// Design Name: 
// Module Name:    Vending_Machine 
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
module Vending_Machine(
    input input_Ni,
    input input_Di,
    output output_Open,
    input input_Reset,
    input input_CLK,
    output [13:0] output_Segment
    );
	 
	 wire [1:0] Q;
	 wire clk;
	 
	 Core_Logic T1(.Ni(input_Ni), .Di(input_Di), .Q(Q), .open(output_Open), .reset(input_Reset), .clk(clk));
	 Frequency_Divider T2(.input_CLK(input_CLK), .input_ENA(input_Reset), .output_CLK(clk));
    BCD_to_7_segment_Decoder T3(.input_BCD(Q), .output_segment1(output_Segment[13:7]), .output_segment2(output_Segment[6:0]));
	 
endmodule
