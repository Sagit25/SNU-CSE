`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:59 05/02/2022 
// Design Name: 
// Module Name:    Counter 
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
module Counter(
    input input_CLK,
    input input_ENA,
    inout [3:0] output_Y,
	 inout overflow
    );
	 
	wire q2, q3, ena, temp1, temp2, temp3;
	//wire temp4;
	 
	JK_FlipFlop T1(.input_J(1'b1), .input_K(1'b1), .input_CLK(input_CLK), .input_ENA(ena), .output_QH(output_Y[0]), .output_QL());
	JK_FlipFlop T2(.input_J(output_Y[0]), .input_K(output_Y[0]), .input_CLK(input_CLK), .input_ENA(ena), .output_QH(output_Y[1]), .output_QL());
	and T3(q2, output_Y[0], output_Y[1]);
	JK_FlipFlop T4(.input_J(q2), .input_K(q2), .input_CLK(input_CLK), .input_ENA(ena), .output_QH(output_Y[2]), .output_QL());
	and T5(q3, output_Y[0], output_Y[1], output_Y[2]);
	JK_FlipFlop T6(.input_J(q3), .input_K(q3), .input_CLK(input_CLK), .input_ENA(ena), .output_QH(output_Y[3]), .output_QL());
	nor T7(temp1, output_Y[2], output_Y[0]);
	and T8(temp2, output_Y[3], output_Y[1], temp1);
	or T9(ena, input_ENA, temp2);
	//or T10(temp3, temp2, temp4);
	or T10(temp3, temp2, overflow);
	and T11(overflow, input_CLK, temp3);
	//and T12(temp4, overflow, temp3);
	 
endmodule
