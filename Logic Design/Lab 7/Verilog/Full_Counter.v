`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:55 05/02/2022 
// Design Name: 
// Module Name:    Full_Counter 
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
module Full_Counter(
    input input_CLK,
    input input_ENA,
    inout [3:0] output_Y1,
    inout [3:0] output_Y0
    );
	 
	wire overflow;
	 
	Counter T1(.input_CLK(input_CLK), .input_ENA(input_ENA), .output_Y(output_Y0), .overflow(overflow));
	Counter T2(.input_CLK(overflow), .input_ENA(input_ENA), .output_Y(output_Y1), .overflow());

endmodule
